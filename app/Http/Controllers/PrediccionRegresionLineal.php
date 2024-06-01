<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use App\Models\LeatSquares;
use App\Models\PrediccionPartido;
use App\Models\TablaPosicion;
use Illuminate\Support\Facades\Log;
use Phpml\Dataset\ArrayDataset;
use Phpml\Metric\Accuracy;
use Phpml\ModelManager;
use Phpml\Regression\LeastSquares;

class PrediccionRegresionLineal extends Controller
{
    public static function prediccionLineal($local_id, $visitante_id, $alineacion_local, $alineacion_visitante)
    {
        // COMENZAR CON EL ENTRENAMIENTO Y PREDICCIÓN
        // Datos de entrenamiento
        $data = [];
        // buscar y recolectar datos del equipo
        $datos_equipo_local = PrediccionPartido::where("local_id", $alineacion_local->equipo_id)
            ->orWhere("visitante_id", $alineacion_local->equipo_id)
            ->orderBy("id", "desc")
            ->get();
        // armar los datos que se utilizaran
        $datos_local = [];
        foreach ($datos_equipo_local as $item) {
            $victoria = 0;
            $empate = 0;
            $derrota = 0;
            $g = 0;
            $gf = 0;
            $gc = 0;
            if ($item->p_ganador_id == $alineacion_local->equipo_id || $item->ganador_id == $alineacion_local->equipo_id) {
                $victoria = 1;
            } elseif (!$item->p_ganador_id || ($item->g_local != null && $item->g_visitante != null && $item->g_local == $item->g_visitante)) {
                $empate = 1;
            } elseif ($item->p_ganador_id != $alineacion_local->equipo_id || $item->ganador_id != $alineacion_local->equipo_id) {
                $derrota = 1;
            }
            if ($item->g_local && $item->g_visitante) {
                $g = $item->g_local;
                $gf = $item->g_local;
                $gc = $item->g_visitante;
            }
            $datos_local[]  = [$victoria, $empate, $derrota, $g, $gf, $gc];
        }
        $equipo = Equipo::find($visitante_id);
        // buscar y recolectar datos del equipo
        $datos_equipo_visitante = PrediccionPartido::where("visitante_id", $alineacion_visitante->equipo_id)
            ->orWhere("visitante_id", $alineacion_visitante->equipo_id)
            ->orderBy("id", "desc")
            ->get();
        // armar los datos que se utilizaran para el modelo
        $datos_visitante = [];
        foreach ($datos_equipo_visitante as $item) {
            $victoria = 0;
            $empate = 0;
            $derrota = 0;
            $g = 0;
            $gf = 0;
            $gc = 0;
            if ($item->p_ganador_id == $alineacion_visitante->equipo_id || $item->ganador_id == $alineacion_visitante->equipo_id) {
                $victoria = (int)$victoria + 1;
            } elseif (!$item->p_ganador_id || ($item->g_local != null && $item->g_visitante != null && $item->g_local == $item->g_visitante)) {
                $empate = (int)$empate + 1;
            } elseif ($item->p_ganador_id != $alineacion_visitante->equipo_id || $item->ganador_id != $alineacion_visitante->equipo_id) {
                $derrota = (int)$derrota + 1;
            }
            if ($item->g_local && $item->g_visitante) {
                $g = $item->g_visitante;
                $gf = $item->g_visitante;
                $gc = $item->g_local;
            }
            $datos_visitante[]  = [$victoria, $empate, $derrota, $g, $gf, $gc];
        }

        // buscar y recolectar datos del equipo de información existente
        $datos_equipo_local = TablaPosicion::where("equipo_id", $alineacion_local->equpo_id)->get();

        // armar los datos que se utilizaran
        foreach ($datos_equipo_local as $item) {
            $datos_local[]  = [$item->pj, $item->g, $item->e, $item->p, $item->gf, $item->gc, $item->dg];
        }

        $equipo_visitante = Equipo::find($visitante_id);
        // buscar y recolectar datos del equipo
        $datos_equipo_visitante = TablaPosicion::where("equipo_id", $alineacion_visitante->equipo_id)->get();

        // armar los datos que se utilizaran para el modelo
        foreach ($datos_equipo_visitante as $item) {
            $datos_visitante[] = [$item->pj, $item->g, $item->e, $item->gf, $item->gc, $item->dg];
        }

        // unir los datos para el analisis y obtencion del modelo
        $data = array_merge($datos_local, $datos_visitante);
        $targets = [];
        // Dividir el conjunto de datos en entrenamiento y prueba
        $splitRatio = 0.8;
        $splitIndex = (int) ($splitRatio * count($data));

        $trainSamples = array_slice($data, 0, $splitIndex);
        $trainLabels = array_slice($targets, 0, $splitIndex);
        try {
            // Crear el modelo de regresión lineal
            $regression = new LeatSquares();
            // Entrenar el modelo
            $resultado = $regression->train($trainSamples, $trainLabels);
            // Guardar el modelo
            $modelManager = new ModelManager();
            $modelManager->saveToFile($resultado, 'model_trained.phpml');
        } catch (Exception $e) {
            // ocurrio un error al intentar guardar el modelo
            return -2;
        }
        // ************************
        // REALIZAR LA PREDICCIÓN
        // ************************
        $datos_prediccion = [];
        $equipo_local = Equipo::find($local_id);

        // Se usara la ultima información de cada equipo
        $datos_equipo_local = TablaPosicion::where("equipo_id", $equipo_local->id)->orderBy("created_at", "desc")->get()->take(5);

        // armar los datos que se utilizaran
        $datos_local = [];
        foreach ($datos_equipo_local as $item) {
            $datos_local[]  = [$item->pj, $item->g, $item->e, $item->p, $item->gf, $item->gc, $item->dg];
        }

        $equipo_visitante = Equipo::find($visitante_id);
        // buscar y recolectar datos del equipo
        $datos_equipo_visitante = TablaPosicion::where("equipo_id", $equipo_visitante->id)->orderBy("created_at", "desc")->get()->take(5);
        // armar los datos que se utilizaran para el modelo
        $datos_visitante = [];
        foreach ($datos_equipo_visitante as $item) {
            $datos_visitante[] = [$item->pj, $item->g, $item->e, $item->gf, $item->gc, $item->dg];
        }
        // obtener el minimo y maximo de resultados para cada equipo
        $total_datos_local = count($datos_local);
        $total_datos_visitante = count($datos_visitante);

        // armar la matriz con información de cada equipo en cada fila
        // [info_e1, info_e1, info_e1, info_e2, info_e2, info_e2]
        // victorias, empates y derrotas
        if ($total_datos_local < $total_datos_visitante) {
            // armar la data de entrenamiento
            foreach ($datos_equipo_local as $key => $item) {
                // acceder a los indices cuya información nos devuelve lo que necesitamos
                $datos_prediccion[] = [$item[1], $item[2], $item[3], $datos_equipo_visitante[$key][1], $datos_equipo_visitante[$key][2], $datos_equipo_visitante[$key][3]];
            }
        } else {
            foreach ($datos_visitante as $key => $item) {
                // acceder a los indices cuya información nos devuelve lo que necesitamos
                $datos_prediccion[] = [$item[1], $item[2], $item[3], $datos_equipo_local[$key][1], $datos_equipo_local[$key][2], $datos_equipo_local[$key][3]];
            }
        }

        // Hacer predicciones
        $predictedLabels = $regression->predict($resultado, $datos_prediccion);
        // almacenar el ultimo resultado
        $ultimo_resultado = $predictedLabels[count($predictedLabels) - 1];
        $resultado = "EMPATE";
        if ($ultimo_resultado == 1) {
            $resultado = $equipo_local->nombre;
        }
        if ($ultimo_resultado == 0) {
            $resultado = $equipo_visitante->nombre;
        }
        return $resultado;
    }
}
