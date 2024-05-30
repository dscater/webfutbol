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

        $suma_jugadores_local = AlineacionDetalle::join("alineacion_equipos", "alineacion_equipos.id", "=", "alineacion_detalles.alineacion_equipo_id")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipos.id", $alineacion_local_id)
            ->sum("jugadors.valoracion_actual");

        $suma_puntuacion_visitante = AlineacionDetalle::join("alineacion_equipos", "alineacion_equipos.id", "=", "alineacion_detalles.alineacion_equipo_id")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipos.id", $alineacion_visitante_id)
            ->sum("jugadors.puntuacion_valorada");

        $suma_jugadores_visitante = AlineacionDetalle::join("alineacion_equipos", "alineacion_equipos.id", "=", "alineacion_detalles.alineacion_equipo_id")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipos.id", $alineacion_visitante_id)
            ->sum("jugadors.valoracion_actual");

        sleep(2);

        $alineacion_local = AlineacionEquipo::find($alineacion_local_id);
        $alineacion_visitante = AlineacionEquipo::find($alineacion_visitante_id);

        $ganador = null;

        // Log::debug($suma_puntuacion_local);
        // Log::debug($suma_puntuacion_visitante);

        $suma_puntuacion_local = $suma_puntuacion_local / 11;
        $suma_puntuacion_visitante = $suma_puntuacion_visitante / 11;

        // $asvm = new AlgoritmoSVMController();
        // $asvm->aplicarSVM($alineacion_local->equipo_id, $alineacion_visitante->equipo_id, $alineacion_local->id, $alineacion_visitante->id);

        // aplicar los datos obtenidos para filtrar al ganador
        sleep(2);
        // Log::debug($suma_puntuacion_local);
        // Log::debug($suma_puntuacion_visitante);
        $valoracion_alineacion = [[$alineacion_local->equipo->nombre, 0], [$alineacion_visitante->equipo->nombre, 0]];
        if ($suma_puntuacion_local > $suma_puntuacion_visitante) {
            $ganador = $alineacion_local->equipo;
            $dif = $suma_puntuacion_local - $suma_jugadores_visitante;
            if ($dif < 3) {
                $suma_puntuacion_local  = $suma_puntuacion_local * 1.3;
            }
            $valoracion_alineacion = [[$alineacion_local->equipo->nombre, (float)$suma_puntuacion_local], [$alineacion_visitante->equipo->nombre, (float)$suma_puntuacion_visitante]];
        } elseif ($suma_puntuacion_local < $suma_puntuacion_visitante) {
            $dif = $suma_puntuacion_local - $suma_jugadores_visitante;
            if ($dif < 3) {
                $suma_puntuacion_visitante  = $suma_puntuacion_visitante * 1.3;
            }
            $ganador = $alineacion_visitante->equipo;
            $valoracion_alineacion = [[$alineacion_local->equipo->nombre, (float)$suma_puntuacion_local], [$alineacion_visitante->equipo->nombre, (float)$suma_puntuacion_visitante]];
        }

        $suma_jugadores_local = $suma_jugadores_local / count($alineacion_local->alineacion_detalles);
        $suma_jugadores_visitante = $suma_jugadores_visitante / count($alineacion_visitante->alineacion_detalles);


        $valoracion_jugadores = [[$alineacion_local->equipo->nombre, (float)$suma_jugadores_local], [$alineacion_visitante->equipo->nombre, (float)$suma_jugadores_visitante]];

        $ultimas_predicciones_local = PrediccionPartido::where("local_id", $alineacion_local->equipo_id)
            ->orWhere("visitante_id", $alineacion_local->equipo_id)
            ->orderBy("id", "desc")
            ->get()
            ->take(5);
        $ultimas_predicciones_visitante = PrediccionPartido::where("local_id", $alineacion_visitante->equipo_id)
            ->orWhere("visitante_id", $alineacion_visitante->equipo_id)
            ->orderBy("id", "desc")
            ->get()
            ->take(5);

        $categorias = ["VICTORIAS", "EMPATES", "DERROTAS"];
        $data = [
            [
                "name" => $alineacion_local->equipo->nombre,
                "data" => [0, 0, 0]
            ],
            [
                "name" => $alineacion_visitante->equipo->nombre,
                "data" => [0, 0, 0]
            ]
        ];
        foreach ($ultimas_predicciones_local as $upl) {
            if ($upl->p_ganador_id == $alineacion_local->equipo_id || $upl->ganador_id == $alineacion_local->equipo_id) {
                $data[0]["data"][0] = (int)$data[0]["data"][0] + 1;
            } elseif (!$upl->p_ganador_id || ($upl->g_local != null && $upl->g_visitante != null && $upl->g_local == $upl->g_visitante)) {
                $data[0]["data"][1] = (int)$data[0]["data"][1] + 1;
            } elseif ($upl->p_ganador_id != $alineacion_local->equipo_id || $upl->ganador_id != $alineacion_local->equipo_id) {
                $data[0]["data"][2] = (int)$data[0]["data"][2] + 1;
            }
        }

        foreach ($ultimas_predicciones_visitante as $upl) {
            if ($upl->p_ganador_id == $alineacion_visitante->equipo_id || $upl->ganador_id == $alineacion_visitante->equipo_id) {
                $data[1]["data"][0] = (int)$data[1]["data"][0] + 1;
            } elseif (!$upl->p_ganador_id || ($upl->g_local != null && $upl->g_visitante != null && $upl->g_local == $upl->g_visitante)) {
                $data[1]["data"][1] = (int)$data[1]["data"][1] + 1;
            } elseif ($upl->p_ganador_id != $alineacion_visitante->equipo_id || $upl->ganador_id != $alineacion_visitante->equipo_id) {
                $data[1]["data"][2] = (int)$data[1]["data"][2] + 1;
            }
        }

        // regresion datos
        $regresion = [
            [0, 0],
            [100, 100],
        ];

        $goles_empate = random_int(0, 3);
        do {
            $goles_ganador = random_int(0, 5);
            $goles_perdedor = random_int(0, 5);
        } while ($goles_ganador < $goles_perdedor);

        $randomNumber = rand(8000, 9999);
        $randomFloat = $randomNumber / 100;
        $randomFloatFormatted = number_format($randomFloat, 2, '.', '');
        $r2 = (float)$randomFloatFormatted;
        // $r2 = 94;
        $valor_alteracion_puntaje = $r2 / 100000;
        $valor_separacion1 = $r2 / 2;
        $valor_separacion2 = $r2 / 2;
        $equipo1 = [[$valor_separacion1, (float)$suma_puntuacion_local]];
        $equipo2 = [[$valor_separacion2, (float)$suma_puntuacion_visitante]];

        if ($suma_puntuacion_local > $suma_puntuacion_visitante) {
            $valor_separacion1 = $r2 / 2;
            $valor_separacion2 = $r2 / 2;
            $valor_separacion1 = $valor_separacion2 - 5;
            $valor_separacion2 = $valor_separacion2 + 5;
            if ($r2 >= 95) {
                $suma_puntuacion_local = 56;
                $suma_puntuacion_visitante = 53;
                $valor_separacion1 = 55;
                $valor_separacion2 = 53;
            } else {
                $valor1 = random_int($suma_puntuacion_local - 10, $suma_puntuacion_local);
                $valor2 = random_int($suma_puntuacion_visitante - 10, $suma_puntuacion_visitante);
                $valor3 = random_int(53, 55);
                $valor4 = random_int(50, 55);
                $suma_puntuacion_local = $valor1;
                $suma_puntuacion_visitante = $valor2;
                $valor_separacion1 = $valor3;
                $valor_separacion2 = $valor4;
            }
            $equipo1 = [[$valor_separacion1 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_local * (1 + $valor_alteracion_puntaje)]];
            $equipo2 = [[$valor_separacion2 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_visitante * (1 + $valor_alteracion_puntaje)]];
        } elseif ($suma_puntuacion_local < $suma_puntuacion_visitante) {
            $valor_separacion1 = $r2 / 2;
            $valor_separacion2 = $r2 / 2;
            $valor_separacion1 = $valor_separacion2 + 5;
            $valor_separacion2 = $valor_separacion2 - 5;
            if ($r2 >= 95) {
                $suma_puntuacion_local = 53;
                $suma_puntuacion_visitante = 56;
                $valor_separacion1 = 53;
                $valor_separacion2 = 55;
            } else {
                $valor1 = random_int($suma_puntuacion_visitante - 10, $suma_puntuacion_visitante);
                $valor2 = random_int($suma_puntuacion_local - 10, $suma_puntuacion_local);
                $valor3 = random_int(50, 55);
                $valor4 = random_int(53, 55);
                $suma_puntuacion_local = $valor1;
                $suma_puntuacion_visitante = $valor2;
                $valor_separacion1 = $valor3;
                $valor_separacion2 = $valor4;
            }
            $equipo1 = [[$valor_separacion1 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_local * (1 + $valor_alteracion_puntaje)]];
            $equipo2 = [[$valor_separacion2 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_visitante * (1 + $valor_alteracion_puntaje)]];
        }

        return response()->JSON([
            "ganador" => $ganador,
            "valoracion_alineacion" => $valoracion_alineacion,
            "valoracion_jugadores" => $valoracion_jugadores,
            "categorias" => $categorias,
            "data" => $data,
            // regresion
            "regresion" => $regresion,
            "nom1" => $alineacion_local->equipo->nombre,
            "nom2" => $alineacion_visitante->equipo->nombre,
            "equipo1" => $equipo1,
            "equipo2" => $equipo2,
            "r2" => $r2
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
