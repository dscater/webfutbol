<?php

namespace App\Http\Controllers;

use App\Models\AlineacionDetalle;
use App\Models\AlineacionEquipo;
use App\Models\HistorialAccion;
use App\Models\PrediccionPartido;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class PrediccionPartidoController extends Controller
{
    public $validacion = [
        "local_id" => "required",
        "visitante_id" => "required",
        "alineacion_local_id" => "required",
        "alineacion_visitante_id" => "required",
    ];

    public $mensajes = [
        "local_id.required" => "Este campo es obligatorio",
        "visitante_id.required" => "Este campo es obligatorio",
        "alineacion_local_id.required" => "Este campo es obligatorio",
        "alineacion_visitante_id.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("PrediccionPartidos/Index");
    }

    public function listado()
    {
        $prediccion_partidos = PrediccionPartido::with(["local", "visitante", "p_ganador", "ganador"])->select("prediccion_partidos.*")->get();
        return response()->JSON([
            "prediccion_partidos" => $prediccion_partidos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $prediccion_partidos = PrediccionPartido::with(["local", "visitante", "p_ganador", "ganador"])->select("prediccion_partidos.*");
        if (trim($search) != "") {
            $prediccion_partidos->where("equipos.nombre", "LIKE", "%$search%");
            $prediccion_partidos->orWhereRaw("CONCAT(jugadors.nombre,' ', jugadors.paterno,' ', jugadors.materno) LIKE ?", ["%$search%"]);
        }

        $prediccion_partidos = $prediccion_partidos->paginate($request->itemsPerPage);
        return response()->JSON([
            "prediccion_partidos" => $prediccion_partidos
        ]);
    }

    public function create()
    {
        return Inertia::render("PrediccionPartidos/Create");
    }

    public function prediccion(Request  $request)
    {
        $alineacion_local_id = $request->alineacion_local_id;
        $alineacion_visitante_id = $request->alineacion_visitante_id;
        $alineacion_local = AlineacionEquipo::find($alineacion_local_id);
        $alineacion_visitante = AlineacionEquipo::find($alineacion_visitante_id);

        $suma_puntuacion_local = AlineacionDetalle::join("alineacion_equipos", "alineacion_equipos.id", "=", "alineacion_detalles.alineacion_equipo_id")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipos.id", $alineacion_local_id)
            ->sum("jugadors.puntuacion_valorada");

        $suma_puntuacion_visitante = AlineacionDetalle::join("alineacion_equipos", "alineacion_equipos.id", "=", "alineacion_detalles.alineacion_equipo_id")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipos.id", $alineacion_visitante_id)
            ->sum("jugadors.puntuacion_valorada");

        sleep(2);

        $alineacion_local = AlineacionEquipo::find($alineacion_local_id);
        $alineacion_visitante = AlineacionEquipo::find($alineacion_visitante_id);

        $ganador = null;

        // Log::debug($suma_puntuacion_local);
        // Log::debug($suma_puntuacion_visitante);

        $suma_puntuacion_local = $suma_puntuacion_local / 11;
        $suma_puntuacion_visitante = $suma_puntuacion_visitante / 11;

        $asvm = new AlgoritmoSVMController();
        $asvm->aplicarSVM($alineacion_local->equipo_id, $alineacion_visitante->equipo_id, $alineacion_local->id, $alineacion_visitante->id);

        // aplicar los datos obtenidos para filtrar al ganador
        sleep(2);
        // Log::debug($suma_puntuacion_local);
        // Log::debug($suma_puntuacion_visitante);
        if ($suma_puntuacion_local > $suma_puntuacion_visitante) {
            $ganador = $alineacion_local->equipo;
        } elseif ($suma_puntuacion_local < $suma_puntuacion_visitante) {
            $ganador = $alineacion_visitante->equipo;
        }


        return response()->JSON([
            "ganador" => $ganador
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el PrediccionPartido
            if (!$request->ganador_id) {
                unset($request["ganador_id"]);
            }
            if (!$request->g_local) {
                unset($request["g_local"]);
            }
            if (!$request->g_visitante) {
                unset($request["g_visitante"]);
            }
            if (!$request->p_ganador_id) {
                unset($request["p_ganador_id"]);
            }

            $nuevo_prediccion_partido = PrediccionPartido::create(array_map('mb_strtoupper', $request->except("p_ganador", "ganador")));
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_prediccion_partido, "prediccion_partidos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->prediccion_partido . ' REGISTRO UNA PREDICCIÓN DE PARTIDO',
                'datos_original' => $datos_original,
                'modulo' => 'PREDICCIÓN DE PARTIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("prediccion_partidos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(PrediccionPartido $prediccion_partido)
    {
    }

    public function edit(PrediccionPartido $prediccion_partido)
    {
        $prediccion_partido = $prediccion_partido->load(["p_ganador", "ganador"]);

        return Inertia::render("PrediccionPartidos/Edit", compact("prediccion_partido"));
    }

    public function update(PrediccionPartido $prediccion_partido, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            if (!$request->ganador_id) {
                unset($request["ganador_id"]);
            }
            if (!$request->g_local) {
                unset($request["g_local"]);
            }
            if (!$request->g_visitante) {
                unset($request["g_visitante"]);
            }
            if (!$request->p_ganador_id) {
                unset($request["p_ganador_id"]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($prediccion_partido, "prediccion_partidos");
            $prediccion_partido->update(array_map('mb_strtoupper', $request->except("p_ganador", "ganador")));
            if (!$request->ganador_id) {
                $prediccion_partido["ganador_id"] = null;
            }
            if (!$request->g_local) {
                $prediccion_partido["g_local"] = null;
            }
            if (!$request->g_visitante) {
                $prediccion_partido["g_visitante"] = null;
            }
            if (!$request->p_ganador_id) {
                $prediccion_partido["p_ganador_id"] = null;
            }
            $prediccion_partido->save();

            if ($request->g_local && $request->g_visitante) {
                $g_local = (int)$request->g_local;
                $g_visitante = (int)$request->g_visitante;

                $prediccion_partido->ganador_id = null;
                if ($g_local > $g_visitante) {
                    $prediccion_partido->ganador_id = $prediccion_partido->local_id;
                } elseif ($g_local < $g_visitante) {
                    $prediccion_partido->ganador_id = $prediccion_partido->visitante_id;
                }
            }
            $prediccion_partido->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($prediccion_partido, "prediccion_partidos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->prediccion_partido . ' MODIFICÓ UNA PREDICCIÓN DE PARTIDO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PREDICCIÓN DE PARTIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("prediccion_partidos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(PrediccionPartido $prediccion_partido)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($prediccion_partido, "prediccion_partidos");
            $prediccion_partido->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->prediccion_partido . ' ELIMINÓ UNA PREDICCIÓN DE PARTIDO',
                'datos_original' => $datos_original,
                'modulo' => 'PREDICCIÓN DE PARTIDOS',
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
