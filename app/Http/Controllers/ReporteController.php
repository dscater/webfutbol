<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use App\Models\Jugador;
use App\Models\TablaPosicion;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use PDF;

class ReporteController extends Controller
{
    public function usuarios()
    {
        return Inertia::render("Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        $tipo =  $request->tipo;
        $usuarios = User::where('id', '!=', 1)->orderBy("paterno", "ASC")->get();

        if ($tipo != 'TODOS') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('usuarios.pdf');
    }

    public function equipos()
    {
        return Inertia::render("Reportes/Equipos");
    }

    public function r_equipos(Request $request)
    {
        $equipo_id =  $request->equipo_id;
        $equipos = Equipo::all();

        if ($equipo_id != 'TODOS') {
            $equipos = Equipo::where('id', $equipo_id)->get();
        }

        $pdf = PDF::loadView('reportes.equipos', compact('equipos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('equipos.pdf');
    }

    public function jugadors()
    {
        return Inertia::render("Reportes/Jugadors");
    }

    public function r_jugadors(Request $request)
    {
        $jugador_id =  $request->jugador_id;
        $jugadors = Jugador::all();

        if ($jugador_id != 'TODOS') {
            $jugadors = Jugador::where('id', $jugador_id)->get();
        }

        $pdf = PDF::loadView('reportes.jugadors', compact('jugadors'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('jugadors.pdf');
    }

    public function equipo_jugadors()
    {
        return Inertia::render("Reportes/EquipoJugadors");
    }

    public function r_equipo_jugadors(Request $request)
    {
        $equipo_id =  $request->equipo_id;
        $equipos = Equipo::all();

        if ($equipo_id != 'TODOS') {
            $equipos = Equipo::where('id', $equipo_id)->get();
        }

        $pdf = PDF::loadView('reportes.equipo_jugadors', compact('equipos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('equipo_jugadors.pdf');
    }

    public function tabla_posicions()
    {
        return Inertia::render("Reportes/TablaPosicions");
    }

    public function r_tabla_posicions(Request $request)
    {
        $tipo_torneo =  $request->tipo_torneo;
        $temporada =  $request->temporada;
        $tabla_posicions = TablaPosicion::where('tipo_torneo', $tipo_torneo)->where("temporada", $temporada)
            ->orderBy("pts", "desc")
            ->orderBy("dg", "desc")
            ->get();

        $pdf = PDF::loadView('reportes.tabla_posicions', compact('tabla_posicions', 'tipo_torneo', 'temporada'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('tabla_posicions.pdf');
    }

    public function g_tabla_posicions(Request $request)
    {
        $tipo_torneo =  $request->tipo_torneo;
        $temporada =  $request->temporada;
        $tabla_posicions = TablaPosicion::where('tipo_torneo', $tipo_torneo)->where("temporada", $temporada)
            ->orderBy("pts", "desc")
            ->orderBy("dg", "desc")
            ->get();

        $data = [];
        foreach ($tabla_posicions as $value) {
            $data[] = [
                "name" => $value->equipo->nombre,
                "y" => (int)$value->pts,
            ];
        }


        return response()->JSON([
            "data" => $data
        ]);
    }
}
