<?php

namespace App\Http\Controllers;

use App\Models\AlineacionEquipo;
use App\Models\Equipo;
use App\Models\Jugador;
use App\Models\PrediccionPartido;
use App\Models\User;
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

            "reportes.usuarios",
            "reportes.equipos",
            "reportes.jugadors",
            "reportes.equipo_jugadors",
            "reportes.tabla_posicions",
            "reportes.g_tabla_posicions",
        ],
        "ANALISTA DEPORTIVO" => [
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

            "reportes.equipos",
            "reportes.jugadors",
            "reportes.equipo_jugadors",
            "reportes.tabla_posicions",
            "reportes.g_tabla_posicions",
        ],
        "ANALISTA DE VIDEO" => [
            "alineacion_equipos.index",
            "alineacion_equipos.create",
            "alineacion_equipos.edit",
            "alineacion_equipos.destroy",

            "prediccion_partidos.index",
            "prediccion_partidos.create",
            "prediccion_partidos.edit",
            "prediccion_partidos.destroy",

            "reportes.equipos",
            "reportes.jugadors",
            "reportes.equipo_jugadors",
            "reportes.tabla_posicions",
            "reportes.g_tabla_posicions",
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

    public static function getInfoBoxUser()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];
        if (in_array('usuarios.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Usuarios',
                'cantidad' => count(User::where('id', '!=', 1)->get()),
                'color' => 'bg-blue-darken-2',
                'icon' => asset("imgs/icon_users.png"),
                "url" => "usuarios.index"
            ];
        }
        if (in_array('equipos.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Equipos',
                'cantidad' => count(Equipo::all()),
                'color' => 'bg-cyan-darken-3',
                'icon' => asset("imgs/icon_solicitud.png"),
                "url" => "equipos.index"
            ];
        }
        if (in_array('jugadors.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Jugadores',
                'cantidad' => count(Jugador::all()),
                'color' => 'bg-red-darken-3',
                'icon' => asset("imgs/icon_inscripcion.png"),
                "url" => "jugadors.index"
            ];
        }
        if (in_array('alineacion_equipos.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Alineación de Equipos',
                'cantidad' => count(AlineacionEquipo::all()),
                'color' => 'bg-green-darken-3',
                'icon' => asset("imgs/checklist.png"),
                "url" => "alineacion_equipos.index"
            ];
        }
        if (in_array('prediccion_partidos.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'Predicción de Partidos',
                'cantidad' => count(PrediccionPartido::all()),
                'color' => 'bg-orange-darken-3',
                'icon' => asset("imgs/documentos.png"),
                "url" => "prediccion_partidos.index"
            ];
        }

        return $array_infos;
    }
}
