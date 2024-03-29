<?php

namespace App\Http\Controllers;

use App\Models\Fichaje;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class FichajeController extends Controller
{
    public $validacion = [
        "jugador_id" => "required",
        "equipo_id" => "required",
        "nro_polera" => "required",
        "fecha_fichaje" => "required",
        "contrato_hasta" => "required",
    ];

    public $mensajes = [
        "jugador_id.required" => "Este campo es obligatorio",
        "equipo_id.required" => "Este campo es obligatorio",
        "nro_polera.required" => "Este campo es obligatorio",
        "fecha_fichaje.required" => "Este campo es obligatorio",
        "contrato_hasta.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Fichajes/Index");
    }

    public function listado()
    {
        $fichajes = Fichaje::with(["equipo", "jugador"])->select("fichajes.*")->get();
        return response()->JSON([
            "fichajes" => $fichajes
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $fichajes = Fichaje::with(["equipo", "jugador"])->select("fichajes.*")
            ->join("equipos", "equipos.id", "=", "fichajes.equipo_id")
            ->join("jugadors", "jugadors.id", "=", "fichajes.jugador_id");

        if (trim($search) != "") {
            $fichajes->where("equipos.nombre", "LIKE", "%$search%");
            $fichajes->orWhereRaw("CONCAT(jugadors.nombre,' ', jugadors.paterno,' ', jugadors.materno) LIKE ?", ["%$search%"]);
        }

        $fichajes = $fichajes->paginate($request->itemsPerPage);
        return response()->JSON([
            "fichajes" => $fichajes
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Fichaje
            $nuevo_fichaje = Fichaje::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_fichaje, "fichajes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->fichaje . ' REGISTRO UN FICHAJE',
                'datos_original' => $datos_original,
                'modulo' => 'FICHAJES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("fichajes.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Fichaje $fichaje)
    {
    }

    public function update(Fichaje $fichaje, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($fichaje, "fichajes");
            $fichaje->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($fichaje, "fichajes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->fichaje . ' MODIFICÓ UN FICHAJE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'FICHAJES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("fichajes.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Fichaje $fichaje)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($fichaje, "fichajes");
            $fichaje->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->fichaje . ' ELIMINÓ UN FICHAJE',
                'datos_original' => $datos_original,
                'modulo' => 'FICHAJES',
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
