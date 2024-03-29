<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class EquipoController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
        "nombre_p" => "required|min:1",
        "nombre_e" => "required|min:1",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracter",
        "nombre_p.required" => "Este campo es obligatorio",
        "nombre_p.min" => "Debes ingresar al menos :min caracter",
        "nombre_e.required" => "Este campo es obligatorio",
        "nombre_e.min" => "Debes ingresar al menos :min caracter",
    ];

    public function index()
    {
        return Inertia::render("Equipos/Index");
    }

    public function listado()
    {
        $equipos = Equipo::select("equipos.*")->get();
        return response()->JSON([
            "equipos" => $equipos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $equipos = Equipo::select("equipos.*");

        if (trim($search) != "") {
            $equipos->where("nombre", "LIKE", "%$search%");
        }

        $equipos = $equipos->paginate($request->itemsPerPage);
        return response()->JSON([
            "equipos" => $equipos
        ]);
    }

    public function store(Request $request)
    {
        if ($request->hasFile('logo')) {
            $this->validacion['logo'] = 'image|mimes:jpeg,jpg,png,webp|max:2048';
        }
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Equipo
            $nuevo_equipo = Equipo::create(array_map('mb_strtoupper', $request->except('logo')));
            if ($request->hasFile('logo')) {
                $file = $request->logo;
                $nom_logo = time() . '_' . $nuevo_equipo->id . '.' . $file->getClientOriginalExtension();
                $nuevo_equipo->logo = $nom_logo;
                $file->move(public_path() . '/imgs/equipos/', $nom_logo);
            }
            $nuevo_equipo->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_equipo, "equipos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->equipo . ' REGISTRO UN EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("equipos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Equipo $equipo)
    {
    }

    public function update(Equipo $equipo, Request $request)
    {
        if ($request->hasFile('logo')) {
            $this->validacion['logo'] = 'image|mimes:jpeg,jpg,png,webp|max:2048';
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($equipo, "equipos");
            $equipo->update(array_map('mb_strtoupper', $request->except('logo')));
            if ($request->hasFile('logo')) {
                $antiguo = $equipo->logo;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/equipos/' . $antiguo);
                }
                $file = $request->logo;
                $nom_logo = time() . '_' . $equipo->id . '.' . $file->getClientOriginalExtension();
                $equipo->logo = $nom_logo;
                $file->move(public_path() . '/imgs/equipos/', $nom_logo);
            }
            $equipo->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($equipo, "equipos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->equipo . ' MODIFICÓ UN EQUIPO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("equipos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Equipo $equipo)
    {
        DB::beginTransaction();
        try {
            $antiguo = $equipo->logo;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/equipos/' . $antiguo);
            }

            $equipo->equipo_titulos()->delete();

            $datos_original = HistorialAccion::getDetalleRegistro($equipo, "equipos");
            $equipo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->equipo . ' ELIMINÓ UN EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
