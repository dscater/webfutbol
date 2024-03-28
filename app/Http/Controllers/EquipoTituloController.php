<?php

namespace App\Http\Controllers;

use App\Models\EquipoTitulo;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class EquipoTituloController extends Controller
{
    public $validacion = [
        "equipo_id" => "required",
        "anio" => "required|min:1",
        "tipo" => "required",
    ];

    public $mensajes = [
        "equipo_id.required" => "Este campo es obligatorio",
        "anio.required" => "Este campo es obligatorio",
        "anio.min" => "Debes ingresar al menos :min caracter",
        "tipo.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("EquipoTitulos/Index");
    }

    public function listado()
    {
        $equipo_titulos = EquipoTitulo::with(["equipo"])->select("equipo_titulos.*")->get();
        return response()->JSON([
            "equipo_titulos" => $equipo_titulos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $equipo_titulos = EquipoTitulo::with(["equipo"])->select("equipo_titulos.*")
            ->join("equipos", "equipos.id", "=", "equipo_titulos.equipo_id");

        if (trim($search) != "") {
            $equipo_titulos->where("equipos.nombre", "LIKE", "%$search%");
        }

        $equipo_titulos = $equipo_titulos->paginate($request->itemsPerPage);
        return response()->JSON([
            "equipo_titulos" => $equipo_titulos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el EquipoTitulo
            $nuevo_equipo_titulo = EquipoTitulo::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_equipo_titulo, "equipo_titulos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->equipo_titulo . ' REGISTRO UN TÍTULO DE EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'TÍTULO DE EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("equipo_titulos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(EquipoTitulo $equipo_titulo)
    {
    }

    public function update(EquipoTitulo $equipo_titulo, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($equipo_titulo, "equipo_titulos");
            $equipo_titulo->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($equipo_titulo, "equipo_titulos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->equipo_titulo . ' MODIFICÓ UN TÍTULO DE EQUIPO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'TÍTULO DE EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("equipo_titulos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(EquipoTitulo $equipo_titulo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($equipo_titulo, "equipo_titulos");
            $equipo_titulo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->equipo_titulo . ' ELIMINÓ UN TÍTULO DE EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'TÍTULO DE EQUIPOS',
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
