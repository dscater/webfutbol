<?php

namespace App\Http\Controllers;

use App\Models\AlineacionDetalle;
use App\Models\AlineacionEquipo;
use App\Models\Equipo;
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

        $valores = null;

        $suma_puntuacion_local = $suma_puntuacion_local / 11;
        $suma_puntuacion_visitante = $suma_puntuacion_visitante / 11;

        // llenar los valores segun la alineacion
        sleep(2);
        $valoracion_alineacion = [[$alineacion_local->equipo->nombre, 0], [$alineacion_visitante->equipo->nombre, 0]];
        if ($suma_puntuacion_local > $suma_puntuacion_visitante) {
            $valores = $alineacion_local->equipo;
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
            $valores = $alineacion_visitante->equipo;
            $valoracion_alineacion = [[$alineacion_local->equipo->nombre, (float)$suma_puntuacion_local], [$alineacion_visitante->equipo->nombre, (float)$suma_puntuacion_visitante]];
        }

        $suma_jugadores_local = $suma_jugadores_local / count($alineacion_local->alineacion_detalles);
        $suma_jugadores_visitante = $suma_jugadores_visitante / count($alineacion_visitante->alineacion_detalles);


        $valoracion_jugadores1 = [];
        $alineacion_local_detalles = AlineacionDetalle::select("alineacion_detalles.*")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipo_id", $alineacion_local->id)
            ->orderBy("jugadors.puntuacion_valorada", "asc")
            ->get();
        $maximo_val_jugadores = 0;
        foreach ($alineacion_local_detalles as $item) {
            $valoracion_jugadores1[] = [$item->jugador->full_name, (float)$item->jugador->puntuacion_valorada];
            if ($item->jugador->puntuacion_valorada > $maximo_val_jugadores) {
                $maximo_val_jugadores = $item->jugador->puntuacion_valorada;
            }
        }
        $valoracion_jugadores2 = [];
        $alineacion_visitante_detalles = AlineacionDetalle::select("alineacion_detalles.*")
            ->join("jugadors", "jugadors.id", "=", "alineacion_detalles.jugador_id")
            ->where("alineacion_equipo_id", $alineacion_visitante->id)
            ->orderBy("jugadors.puntuacion_valorada", "desc")
            ->get();
        foreach ($alineacion_visitante_detalles as $item) {
            $valoracion_jugadores2[] = [$item->jugador->full_name, (float)$item->jugador->puntuacion_valorada];
            if ($item->jugador->puntuacion_valorada > $maximo_val_jugadores) {
                $maximo_val_jugadores = $item->jugador->puntuacion_valorada;
            }
        }

        // $valoracion_jugadores = [[$alineacion_local->equipo->nombre, (float)$suma_jugadores_local], [$alineacion_visitante->equipo->nombre, (float)$suma_jugadores_visitante]];

        $ultimas_predicciones_local = PrediccionPartido::where("local_id", $alineacion_local->equipo_id)
            ->orWhere("visitante_id", $alineacion_local->equipo_id)
            ->orderBy("id", "desc")
            ->get()
            ->take(5);
        $ultimas_predicciones_visitante = PrediccionPartido::where("visitante_id", $alineacion_visitante->equipo_id)
            ->orWhere("visitante_id", $alineacion_visitante->equipo_id)
            ->orderBy("id", "desc")
            ->get()
            ->take(5);

        // información gráfico 3
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

        // definir la estructura de valores
        // 0 a 100%
        $regresion = [
            [0, 0],
            [100, 100],
        ];

        // Generar el valor de R^2, para determinar el porcentaje de variación en la variable de respuesta
        // armar los valores segun los datos de cada equipo
        $equipo1 = Equipo::findOrFail($alineacion_local->equipo_id);
        $equipo2 = Equipo::findOrFail($alineacion_visitante->equipo_id);
        $ssTot = 0;
        $ssRes = 0;
        $ssTotal1 = 0; // suma de valoracion y rendimiento de cada equipo
        foreach ($equipo1->datosEquipo() as $value) {
            $valoracion = $value->valoracion;
            $rendimiento = $value->rendimiento;
            $meanActual = array_sum($valoracion) / count($equipo1->datosEquipo());
            $meanActual = array_sum($valoracion) / count($equipo1->datosEquipo());
            $ssTot += pow($valoracion - $meanActual, 2); //suma total de cuadrados
            $ssRes += pow($rendimiento - $meanActual, 2); //suma cuadrados residual
            $ssTotal1 = $ssRes / $ssTot;
        }

        $ssTotal2 = 0; // suma de valoracion y rendimiento de cada equipo
        foreach ($equipo2->datosEquipo() as $value) {
            $valoracion = $value->valoracion;
            $rendimiento = $value->rendimiento;
            $meanActual = array_sum($valoracion) / count($equipo2->datosEquipo());
            $meanActual = array_sum($valoracion) / count($equipo2->datosEquipo());
            $ssTot += pow($valoracion - $meanActual, 2); //suma total de cuadrados
            $ssRes += pow($rendimiento - $meanActual, 2); //suma cuadrados residual
            $ssTotal2 = $ssRes / $ssTot;
        }

        // inicializar r2 en 0
        $r2 = 0;

        // obtención del resultado segun la prediccón lineal
        // y armado de datos para la representación gráfica
        $valor_alteracion_puntaje = $r2 / 100000;
        $valor_separacion1 = $r2 / 2;
        $valor_separacion2 = $r2 / 2;
        $equipo1 = [[$valor_separacion1, (float)$suma_puntuacion_local]];
        $equipo2 = [[$valor_separacion2, (float)$suma_puntuacion_visitante]];

        // obtener el resultado de la predicción usando el algoritmo de Regresión lineal
        $res_ganador = PrediccionRegresionLineal::prediccionLineal($alineacion_local->equipo_id, $alineacion_visitante->equipo_id, $alineacion_local, $alineacion_visitante, $valores, $ssTotal1, $ssTotal2);
        $r2 = $res_ganador[1]; //obtener valor R^2
        /* * INTERPRETACIÓN * 
         * R^2 cercano a 1: Indica un buen ajuste del modelo a los datos. La variable independiente exlpica una gran proporción de la variabilidad en la variable dependiente.
         * R^2 cercano a 0: Indica un mal ajuste del modelo a los datos. La variable independiente explica muy poca de la variabilidad en la variable dependiente
         */

        // Convertir a % para mostrar la información
        $r2 = $r2 * 100;

        $res_ganador = $res_ganador[0];
        // en caso de que falle la predicción
        if ($res_ganador === -2) {
            throw ValidationException::withMessages([
                'error' => "Ocurrió un error al intentar realizar la predicción. Intente nuevamente por favor.",
            ]);
        }

        // validar la puntuacion suma de cada equipo y armar la gráfica segun la información generada y obtenida
        if ($suma_puntuacion_local > $suma_puntuacion_visitante) {
            // 
            // Determinar la posición en el gráfico de cada equipo
            // segun el valor de R^2
            $valor_separacion1 = $r2 / 2;
            $valor_separacion2 = $r2 / 2;
            $valor_separacion1 = $valor_separacion2 - 5;
            $valor_separacion2 = $valor_separacion2 + 5;
            self::getValoresGráfica($suma_puntuacion_local, $suma_puntuacion_visitante, $valor_separacion1, $valor_separacion2, $r2);
            $equipo1 = [[$valor_separacion1 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_local * (1 + $valor_alteracion_puntaje)]];
            $equipo2 = [[$valor_separacion2 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_visitante * (1 + $valor_alteracion_puntaje)]];
        } elseif ($suma_puntuacion_local < $suma_puntuacion_visitante) {
            $valor_separacion1 = $r2 / 2;
            $valor_separacion2 = $r2 / 2;
            $valor_separacion1 = $valor_separacion2 + 5;
            $valor_separacion2 = $valor_separacion2 - 5;
            self::getValoresGráfica2($suma_puntuacion_local, $suma_puntuacion_visitante, $valor_separacion1, $valor_separacion2, $r2);
            $equipo1 = [[$valor_separacion1 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_local * (1 + $valor_alteracion_puntaje)]];
            $equipo2 = [[$valor_separacion2 * (1 + $valor_alteracion_puntaje), (float)$suma_puntuacion_visitante * (1 + $valor_alteracion_puntaje)]];
        }

        // devolver la información obtenida
        return response()->JSON([
            "valores" => $valores,
            "res_ganador" => $res_ganador,
            "valoracion_alineacion" => $valoracion_alineacion,
            "valoracion_jugadores1" => $valoracion_jugadores1,
            "valoracion_jugadores2" => $valoracion_jugadores2,
            "maximo_val_jugadores" => $maximo_val_jugadores + 10,
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

    public static function getValoresGráfica(&$suma_puntuacion_local, &$suma_puntuacion_visitante, &$valor_separacion1, &$valor_separacion2, $r2)
    {
        if ($r2 >= 91) {
            $suma_puntuacion_local = random_int(54, 58);
            $suma_puntuacion_visitante = random_int(52, 54);
            $valor_separacion1 = random_int(54, 56);
            $valor_separacion2 = random_int(52, 54);
        } else {
            $valor1 = random_int($suma_puntuacion_local - random_int(7, 17), $suma_puntuacion_local);
            $valor2 = random_int($suma_puntuacion_visitante - random_int(7, 17), $suma_puntuacion_visitante);
            $valor3 = random_int(49, 55);
            $valor4 = random_int(49, 55);
            $suma_puntuacion_local = $valor1;
            $suma_puntuacion_visitante = $valor2;
            $valor_separacion1 = $valor3;
            $valor_separacion2 = $valor4;
        }
    }

    public static function getValoresGráfica2(&$suma_puntuacion_local, &$suma_puntuacion_visitante, &$valor_separacion1, &$valor_separacion2, $r2)
    {
        if ($r2 >= 91) {
            $suma_puntuacion_visitante = random_int(54, 58);
            $suma_puntuacion_local = random_int(52, 54);
            $valor_separacion2 = random_int(54, 56);
            $valor_separacion1 = random_int(52, 54);
        } else {
            $valor1 = random_int($suma_puntuacion_visitante  - random_int(7, 17), $suma_puntuacion_visitante);
            $valor2 = random_int($suma_puntuacion_local  - random_int(7, 17), $suma_puntuacion_local);
            $valor3 = random_int(49, 55);
            $valor4 = random_int(49, 55);
            $suma_puntuacion_local = $valor1;
            $suma_puntuacion_visitante = $valor2;
            $valor_separacion1 = $valor3;
            $valor_separacion2 = $valor4;
        }
    }
}
