<?php

namespace App\Http\Controllers;

use App\Models\AlineacionDetalle;
use App\Models\AlineacionEquipo;
use App\Models\Equipo;
use App\Models\HistorialAccion;
use App\Models\LeatSquares;
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
        /* ************************************ *
        * APLICAR REGRESIÓN LINEAL MÚLTIPLE
        * Pasos:
        * 1) Preparar los datos
        * 2) Normalizar los datos
        * 3) Dividir los datos y Realizar el entrenamiento del modelo Usando LeatSquares del paquete php-ai/php-ml
        *    para realizar el entrenamiento y uso del modelo generado dentro del objeto creado
        * 4) Realizar la predicción
        * 5) Devolver la información del ganador y R^2
        * ************************************* */

        // 1) Preparar los datos
        // Obtener los jugadores de cada equipo
        $equipo1 = Equipo::find($request->equipo_local_id);
        $equipo2 = Equipo::find($request->equipo_visitante_id);

        $jugadores_local = Jugador::where('equipo_id', $equipo1->id)->get();
        $jugadores_visitante = Jugador::where('equipo_id', $equipo2->id)->get();

        // Calcular el rendimiento total de los jugadores
        $rendimiento_total_local = 0;
        foreach ($jugadores_local as $jugador) {
            $rendimiento_total_local += $jugador->rendimiento;
        }

        $rendimiento_total_visitante = 0;
        foreach ($jugadores_visitante as $jugador) {
            $rendimiento_total_visitante += $jugador->rendimiento;
        }

        // Crear un array para almacenar los datos
        $data = [
            'rendimiento_total_local' => $rendimiento_total_local,
            'rendimiento_total_visitante' => $rendimiento_total_visitante,
        ];

        // 2) Normalizar los datos de rendimiento
        $rendimientos = [
            $data['rendimiento_total_local'],
            $data['rendimiento_total_visitante'],
        ];

        $min_rendimiento = min($rendimientos);
        $max_rendimiento = max($rendimientos);

        $data['rendimiento_total_local'] = $this->normalize($data['rendimiento_total_local'], $min_rendimiento, $max_rendimiento);
        $data['rendimiento_total_visitante'] = $this->normalize($data['rendimiento_total_visitante'], $min_rendimiento, $max_rendimiento);

        $X = [
            [1, $data['rendimiento_total_local'], $data['posicion_local'], $data['rendimiento_total_visitante'], $data['posicion_visitante']]
        ];

        // 3) Dividir los datos
        $train_data = array_slice($data, 0, floor(0.8 * count($data)));
        $test_data = array_slice($data, floor(0.8 * count($data)));

        // preparar el entrenamiento del modelo
        $regresion = new LeatSquares();
        $regresion->train($train_data, $X);

        // obtener R2
        $ssTotal = array_sum(array_map(function ($target) use ($train_data) {
            $mean = array_sum($train_data) / count($train_data);
            return pow($target - $mean, 2);
        }, $test_data));

        $ssResidual = array_sum(array_map(function ($prediction, $target) {
            return pow($target - $prediction, 2);
        }, $train_data, $test_data));

        // valor de 0 a 1
        /* * INTERPRETACIÓN * 
         * R^2 cercano a 1: Indica un buen ajuste del modelo a los datos. La variable independiente exlpica una gran proporción de la variabilidad en la variable dependiente.
         * R^2 cercano a 0: Indica un mal ajuste del modelo a los datos. La variable independiente explica muy poca de la variabilidad en la variable dependiente
         */
        $r2 = 1 - ($ssResidual / $ssTotal);

        // 4) Realizar la predicción usando el objeto $regresion
        $rendimientosEquipo1 = $equipo1->alineaciones->pluck('rendimiento')->toArray();
        $rendimientosEquipo2 = $equipo2->alineaciones->pluck('rendimiento')->toArray();

        $scoreEquipo1 = $regresion->predict($regresion, $rendimientosEquipo1, $ssResidual);
        $scoreEquipo2 = $regresion->predict($regresion, $rendimientosEquipo2, $ssResidual);

        $ganador = $scoreEquipo1 > $scoreEquipo2 ? $equipo1 : $equipo2;

        // convertir R2 a % para visualización en la gráfica
        $r2 = $r2 * 100;

        return response()->json([
            'ganador' => $ganador->nombre,
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

    function normalize($value, $min, $max)
    {
        return ($value - $min) / ($max - $min);
    }
}
