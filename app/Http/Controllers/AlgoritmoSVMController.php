<?php

namespace App\Http\Controllers;

use App\Models\AlineacionEquipo;
use App\Models\Equipo;
use App\Models\SVM;
use App\Models\TablaPosicion;
use Illuminate\Http\Request;

class AlgoritmoSVMController extends Controller
{
    public function aplicarSVM($local_id, $visitante_id, $alineacion_local, $alineacion_visitante)
    {
        $datos_prediccion = [];
        $equipo = Equipo::find($local_id);

        // buscar y recolectar datos del equipo
        $datos_equipo_local = TablaPosicion::where("equipo_id", $equipo->id)->get();

        // armar los datos que se utilizaran
        $datos_local = [];
        foreach ($datos_equipo_local as $item) {
            $datos_local[]  = [$item->pj, $item->g, $item->e, $item->gf, $item->gc, $item->dg];
        }


        $equipo = Equipo::find($visitante_id);
        // buscar y recolectar datos del equipo
        $datos_equipo_visitante = TablaPosicion::where("equipo_id", $equipo->id)->get();

        // armar los datos que se utilizaran para el modelo
        $datos_visitante = [];
        foreach ($datos_equipo_visitante as $item) {
            $datos_visitante[] = [$item->pj, $item->g, $item->e, $item->gf, $item->gc, $item->dg];
        }

        // unir los datos para el analisis y obtencion del modelo
        $datos_prediccion[0] = $datos_local;
        $datos_prediccion[1] = $datos_visitante;

        $svm = new SVM();
        // generar el modelo de información que se usara
        $modelo = $svm->train($datos_prediccion);

        // obtener información de pesos sobre alineacion del equipo
        $datos_alineacion_local = AlineacionEquipo::find($alineacion_local);
        $datos_alineacion_visitante = AlineacionEquipo::find($alineacion_visitante);
        $datos_valor = [];
        $datos_valor_local = [];
        $datos_valor_visitante = [];
        // guardar la informacion en porcentaje de 0 a 1
        foreach ($datos_alineacion_local->alineacion_detalles as $item) {
            $datos_valor_local[] = (float)$item->jugador->puntuacion_valorada / 100;
        }
        // guardar la informacion en porcentaje de 0 a 1
        foreach ($datos_alineacion_visitante->alineacion_detalles as $item) {
            $datos_valor_visitante[] = (float)$item->jugador->puntuacion_valorada / 100;
        }
        // unir la información local/visitante
        $datos_valor[0] = $datos_valor_local;
        $datos_valor[1] = $datos_valor_visitante;

        // enviar los datos obtenidos
        $resultado = $modelo->predict($datos_valor);
        // el resultado sera 0(Local) / 1(Visitante) / -1 (Empate)
        return $resultado;
    }
}
