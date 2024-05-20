<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use App\Models\TablaPosicion;
use Phpml\Dataset\ArrayDataset;
use Phpml\Metric\Accuracy;
use Phpml\ModelManager;
use Phpml\Regression\LeastSquares;

class PrediccionRegresionLinea extends Controller
{
    public function aplicarSVM($local_id, $visitante_id, $alineacion_local, $alineacion_visitante)
    {
        // COMENZAR CON EL ENTRENAMIENTO Y PREDICCIÓN
        // Datos de entrenamiento
        $data = [
            [10, 5, 3, 8, 7, 2],
            [12, 3, 3,  9, 6, 1],
            [8, 7, 2,  9, 3, 3],
            [11, 4, 3, 4, 5, 3],
            [9, 2, 2,  5, 4, 8],
            [6, 3, 2,  6, 4, 4],
            [7, 4, 2,  6, 4, 5],
            [8, 5, 1,  2, 4, 3],
            [2, 6, 2,  3, 4, 2],
            [4, 6, 0,  7, 4, 0],
            [3, 4, 1,  2, 4, 9],
            [2, 3, 1,  7, 4, 4],
            [7, 2, 1,  9, 4, 1],
            [11, 3, 0, 8, 4, 2],
            [8, 5, 1,  2, 4, 3],
            [6, 3, 4, 5, 5, 1],
            [3, 4, 1,  2, 4, 9],
            [2, 6, 2,  3, 4, 2],
            [9, 2, 2,  5, 4, 8],
            [4, 6, 0,  7, 4, 0],
            [6, 3, 1,  7, 2, 2],
            [4, 6, 0,  7, 2, 0],
            [3, 4, 1,  2, 4, 9],
            [2, 3, 1,  7, 4, 4],
            [7, 2, 1,  9, 4, 1],
            [4, 6, 0,  7, 4, 0],
            [4, 6, 0,  7, 4, 0],
        ];

        $targets = [1, 1, 0, 1, 0, -1]; // 1 si el equipo 1 gana, 0 si el equipo 2 gana, -1 empate

        // Dividir el conjunto de datos en entrenamiento y prueba
        $splitRatio = 0.8;
        $splitIndex = (int) ($splitRatio * count($data));

        $trainSamples = array_slice($data, 0, $splitIndex);
        $trainLabels = array_slice($targets, 0, $splitIndex);

        $testSamples = array_slice($data, $splitIndex);
        $testLabels = array_slice($targets, $splitIndex);

        // Crear el modelo de regresión lineal
        $regression = new LeastSquares();

        // Entrenar el modelo
        $regression->train($trainSamples, $trainLabels);

        // Hacer predicciones
        $predictedLabels = $regression->predict($testSamples);

        // Evaluar la precisión del modelo
        $accuracy = Accuracy::score($testLabels, $predictedLabels);

        // Guardar el modelo
        $modelManager = new ModelManager();
        $modelManager->saveToFile($regression, 'model_trained.phpml');

        // Cargar el modelo
        $regression = $modelManager->restoreFromFile('model_trained.phpml');

        // ************************
        // REALIZAR LA PREDICCIÓN
        // ************************
        $datos_prediccion = [];
        $equipo_local = Equipo::find($local_id);

        // buscar y recolectar datos del equipo
        $datos_equipo_local = TablaPosicion::where("equipo_id", $equipo_local->id)->get();

        // armar los datos que se utilizaran
        $datos_local = [];
        foreach ($datos_equipo_local as $item) {
            $datos_local[]  = [$item->pj, $item->g, $item->e, $item->p, $item->gf, $item->gc, $item->dg];
        }

        $equipo_visitante = Equipo::find($visitante_id);
        // buscar y recolectar datos del equipo
        $datos_equipo_visitante = TablaPosicion::where("equipo_id", $equipo_visitante->id)->get();

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
        $predictedLabels = $regression->predict($datos_prediccion);
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
