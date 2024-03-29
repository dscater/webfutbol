<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\JugadorTitulo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class JugadorTituloController extends Controller
{
    public $validacion = [
        "jugador_id" => "required",
        "anio" => "required|min:1",
        "tipo" => "required",
    ];

    public $mensajes = [
        "jugador_id.required" => "Este campo es obligatorio",
        "anio.required" => "Este campo es obligatorio",
        "anio.min" => "Debes ingresar al menos :min caracter",
        "tipo.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("JugadorTitulos/Index");
    }

    public function listado()
    {
        $jugador_titulos = JugadorTitulo::with(["jugador"])->select("jugador_titulos.*")->get();
        return response()->JSON([
            "jugador_titulos" => $jugador_titulos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $jugador_titulos = JugadorTitulo::with(["jugador"])->select("jugador_titulos.*")
            ->join("jugadors", "jugadors.id", "=", "jugador_titulos.jugador_id");

        if (trim($search) != "") {
            $jugador_titulos->orWhereRaw("CONCAT(jugadors.nombre,' ', jugadors.paterno,' ', jugadors.materno) LIKE ?", ["%$search%"]);
        }

        $jugador_titulos = $jugador_titulos->paginate($request->itemsPerPage);
        return response()->JSON([
            "jugador_titulos" => $jugador_titulos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el JugadorTitulo
            $nuevo_jugador_titulo = JugadorTitulo::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_jugador_titulo, "jugador_titulos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->jugador_titulo . ' REGISTRO UN TÍTULO DE EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'TÍTULO DE EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("jugador_titulos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(JugadorTitulo $jugador_titulo)
    {
    }

    public function update(JugadorTitulo $jugador_titulo, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($jugador_titulo, "jugador_titulos");
            $jugador_titulo->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($jugador_titulo, "jugador_titulos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->jugador_titulo . ' MODIFICÓ UN TÍTULO DE EQUIPO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'TÍTULO DE EQUIPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("jugador_titulos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(JugadorTitulo $jugador_titulo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($jugador_titulo, "jugador_titulos");
            $jugador_titulo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->jugador_titulo . ' ELIMINÓ UN TÍTULO DE EQUIPO',
                'datos_original' => $datos_original,
                'modulo' => 'TÍTULO DE EQUIPOS',
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
