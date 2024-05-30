<?php

namespace App\Http\Controllers;

use App\Models\AlineacionDetalle;
use App\Models\AlineacionEquipo;
use App\Models\Fichaje;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class AlineacionEquipoController extends Controller
{
    public $validacion = [
        "equipo_id" => "required",
        "nombre" => "required|min:1",
    ];

    public $mensajes = [
        "equipo_id.required" => "Este campo es obligatorio",
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
    ];

    public function index()
    {
        return Inertia::render("AlineacionEquipos/Index");
    }

    public function listado()
    {
        $alineacion_equipos = AlineacionEquipo::with(["equipo"])->select("alineacion_equipos.*")->get();
        return response()->JSON([
            "alineacion_equipos" => $alineacion_equipos
        ]);
    }

    public function byEquipo(Request $request)
    {
        $alineacion_equipos = AlineacionEquipo::with(["equipo"])->select("alineacion_equipos.*")->where("equipo_id", $request->id)->get();
        return response()->JSON([
            "alineacion_equipos" => $alineacion_equipos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $alineacion_equipos = AlineacionEquipo::with(["equipo", "alineacion_detalles.jugador", "alineacion_detalles.fichaje"])->select("alineacion_equipos.*");
        if (trim($search) != "") {
            $alineacion_equipos->where("equipos.nombre", "LIKE", "%$search%");
            $alineacion_equipos->orWhereRaw("CONCAT(jugadors.nombre,' ', jugadors.paterno,' ', jugadors.materno) LIKE ?", ["%$search%"]);
        }

        $alineacion_equipos = $alineacion_equipos->paginate($request->itemsPerPage);
        return response()->JSON([
            "alineacion_equipos" => $alineacion_equipos
        ]);
    }

    public function create()
    {
        return Inertia::render("AlineacionEquipos/Create");
    }

    public function store(Request $request)
    {
        Log::debug($request->alineacion_detalles);
        $request->validate($this->validacion, $this->mensajes);

        if (!isset($request->alineacion_detalles) || count($request->alineacion_detalles) < 7) {
            throw ValidationException::withMessages([
                "error" => "Debes seleccionar al menos un 7 jugadores para la alineación"
            ]);
        }

        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el AlineacionEquipo
            $nuevo_alineacion_equipo = AlineacionEquipo::create(array_map('mb_strtoupper', $request->except("eliminados", "alineacion_detalles")));

            foreach ($request->alineacion_detalles as $value) {
                if (isset($value["fichaje_id"]) && $value["fichaje_id"] && isset($value["jugador_id"]) && $value["jugador_id"]) {
                    $nuevo_alineacion_equipo->alineacion_detalles()->create([
                        "fichaje_id" => $value["fichaje_id"],
                        "jugador_id" => $value["jugador_id"],
                    ]);
                } elseif (isset($value["jugador_id"]) && $value["jugador_id"]) {
                    $fichaje = Fichaje::find($value["fichaje_id"]);
                    $nuevo_alineacion_equipo->alineacion_detalles()->create([
                        "fichaje_id" => $value["fichaje_id"],
                        "jugador_id" => $fichaje->jugador_id,
                    ]);
                }
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_alineacion_equipo, "alineacion_equipos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->alineacion_equipo . ' REGISTRO UNA ALINEACIÓN DE EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'ALINEACIÓN DE EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("alineacion_equipos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(AlineacionEquipo $alineacion_equipo)
    {
    }

    public function ById(Request $request)
    {
        $alineacion_equipo = AlineacionEquipo::find($request->id);
        return response()->JSON([
            "alineacion_equipo" => $alineacion_equipo->load(["alineacion_detalles.jugador", "alineacion_detalles.fichaje", "equipo"])
        ]);
    }

    public function edit(AlineacionEquipo $alineacion_equipo)
    {
        $alineacion_equipo = $alineacion_equipo->load(["alineacion_detalles.jugador", "alineacion_detalles.fichaje"]);

        return Inertia::render("AlineacionEquipos/Edit", compact("alineacion_equipo"));
    }

    public function update(AlineacionEquipo $alineacion_equipo, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        if (!isset($request->alineacion_detalles) || count($request->alineacion_detalles) < 7) {
            throw ValidationException::withMessages([
                "error" => "Debes seleccionar al menos un 7 jugadores para la alineación"
            ]);
        }
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($alineacion_equipo, "alineacion_equipos");
            $alineacion_equipo->update(array_map('mb_strtoupper', $request->except("eliminados", "alineacion_detalles")));

            if (isset($request->eliminados) && $request->eliminados) {
                foreach ($request->eliminados as $value) {
                    $id = $value;
                    $alineacion_detalle = AlineacionDetalle::find($id);
                    $alineacion_detalle->delete();
                }
            }
            foreach ($request->alineacion_detalles as $value) {
                if ($value["id"] == 0) {
                    $alineacion_equipo->alineacion_detalles()->create([
                        "fichaje_id" => $value["fichaje_id"],
                        "jugador_id" => $value["jugador_id"],
                    ]);
                }
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($alineacion_equipo, "alineacion_equipos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->alineacion_equipo . ' MODIFICÓ UNA ALINEACIÓN DE EQUIPO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ALINEACIÓN DE EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("alineacion_equipos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(AlineacionEquipo $alineacion_equipo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($alineacion_equipo, "alineacion_equipos");
            $alineacion_equipo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->alineacion_equipo . ' ELIMINÓ UNA ALINEACIÓN DE EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'ALINEACIÓN DE EQUIPOS',
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
