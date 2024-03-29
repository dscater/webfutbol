<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\TablaPosicion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class TablaPosicionController extends Controller
{
    public $validacion = [
        "equipo_id" => "required",
        "temporada" => "required|min:1",
        "tipo_torneo" => "required",
        "g" => "required",
        "e" => "required",
        "p" => "required",
        "gf" => "required",
        "gc" => "required",
        "dg" => "required",
        "pts" => "required",
    ];

    public $mensajes = [
        "equipo_id.required" => "Este campo es obligatorio",
        "temporada.required" => "Este campo es obligatorio",
        "temporada.min" => "Debes ingresar al menos :min caracter",
        "tipo_torneo.required" => "Este campo es obligatorio",
        "g.required" => "Este campo es obligatorio",
        "e.required" => "Este campo es obligatorio",
        "p.required" => "Este campo es obligatorio",
        "gf.required" => "Este campo es obligatorio",
        "gc.required" => "Este campo es obligatorio",
        "dg.required" => "Este campo es obligatorio",
        "pts.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("TablaPosicions/Index");
    }

    public function listado()
    {
        $tabla_posicions = TablaPosicion::with(["equipo"])->select("tabla_posicions.*")->get();
        return response()->JSON([
            "tabla_posicions" => $tabla_posicions
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $tabla_posicions = TablaPosicion::with(["equipo"])->select("tabla_posicions.*")
            ->join("equipos", "equipos.id", "=", "tabla_posicions.equipo_id");

        if (trim($search) != "") {
            $tabla_posicions->where("equipos.nombre", "LIKE", "%$search%");
        }

        $tabla_posicions = $tabla_posicions->paginate($request->itemsPerPage);
        return response()->JSON([
            "tabla_posicions" => $tabla_posicions
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // validar que no exista un registro del equipo en el mismo AÑO y TEMPORADA
            $existe = TablaPosicion::where("equipo_id", $request->equipo_id)
                ->where("temporada", $request->temporada)
                ->where("tipo_torneo", $request->tipo_torneo)
                ->get()->first();
            if ($existe) {
                throw ValidationException::withMessages([
                    'error' => "El equipo seleccionado ya cuenta con un registro en la temporada " . $request->temporada . ', Torneo ' . $request->tipo_torneo,
                ]);
            }

            // crear el TablaPosicion
            $nuevo_tabla_posicion = TablaPosicion::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_tabla_posicion, "tabla_posicions");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->tabla_posicion . ' REGISTRO UNA TABLA DE POSICION',
                'datos_original' => $datos_original,
                'modulo' => 'TABLA DE POSICIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("tabla_posicions.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(TablaPosicion $tabla_posicion)
    {
    }

    public function update(TablaPosicion $tabla_posicion, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($tabla_posicion, "tabla_posicions");
            $tabla_posicion->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($tabla_posicion, "tabla_posicions");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->tabla_posicion . ' MODIFICÓ UNA TABLA DE POSICION',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'TABLA DE POSICIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("tabla_posicions.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(TablaPosicion $tabla_posicion)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($tabla_posicion, "tabla_posicions");
            $tabla_posicion->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->tabla_posicion . ' ELIMINÓ UNA TABLA DE POSICION',
                'datos_original' => $datos_original,
                'modulo' => 'TABLA DE POSICIONES',
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
