<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{


    public static $permisos = [
        "PERIODISTA" => [
            "usuarios.index",
            "usuarios.create",
            "usuarios.edit",
            "usuarios.destroy",

            "institucions.index",
            "institucions.create",
            "institucions.edit",
            "institucions.destroy",

            "equipos.index",
            "equipos.create",
            "equipos.edit",
            "equipos.destroy",

            "equipo_titulos.index",
            "equipo_titulos.create",
            "equipo_titulos.edit",
            "equipo_titulos.destroy",

            "jugadors.index",
            "jugadors.create",
            "jugadors.edit",
            "jugadors.destroy",

            "jugador_titulos.index",
            "jugador_titulos.create",
            "jugador_titulos.edit",
            "jugador_titulos.destroy",

            "fichajes.index",
            "fichajes.create",
            "fichajes.edit",
            "fichajes.destroy",

            "tabla_posicions.index",
            "tabla_posicions.create",
            "tabla_posicions.edit",
            "tabla_posicions.destroy",

            "alineacion_equipos.index",
            "alineacion_equipos.create",
            "alineacion_equipos.edit",
            "alineacion_equipos.destroy",

            "prediccion_partidos.index",
            "prediccion_partidos.create",
            "prediccion_partidos.edit",
            "prediccion_partidos.destroy",
        ],
        "ANALISTA DEPORTIVO" => [
            "vuetify",
        ],
        "ANALISTA DE VIDEO" => [
            "vuetify",
        ],
    ];

    public static function getPermisosUser()
    {
        $array_permisos = self::$permisos;
        if ($array_permisos[Auth::user()->tipo]) {
            return $array_permisos[Auth::user()->tipo];
        }
        return [];
    }


    public static function verificaPermiso($permiso)
    {
        if (in_array($permiso, self::$permisos[Auth::user()->tipo])) {
            return true;
        }
        return false;
    }

    public function permisos(Request $request)
    {
        return response()->JSON([
            "permisos" => $this->permisos[Auth::user()->tipo]
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }
}
