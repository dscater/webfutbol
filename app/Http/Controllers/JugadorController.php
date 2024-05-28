<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Jugador;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class JugadorController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
        "paterno" => "required|min:1",
        "nacionalidad" => "required|min:1",
        "ci" => "required|min:1",
        "fecha_nac" => "required",
        "posicion" => "required|min:1",
        "altura" => "required",
        "peso" => "required",
        "pie" => "required",
        "valoracion_actual" => "required",
        "nro_convocado" => "required",
        "nro_alineaciones" => "required",
        "minutos_jugados" => "required",
        "nro_goles" => "required",
        "nro_asistencias" => "required",
        "nro_gol_penalti" => "required",
        "nro_penalti_cometido" => "required",
        "nro_tiro_palo" => "required",
        "nro_sustitucion" => "required",
        "nro_tarjeta_amarilla" => "required",
        "nro_tarjeta_roja" => "required",
        "nro_lesiones" => "required",
        "puntuacion_valorada" => "required",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracter",
        "paterno.required" => "Este campo es obligatorio",
        "paterno.min" => "Debes ingresar al menos :min caracter",
        "nacionalidad.required" => "Este campo es obligatorio",
        "nacionalidad.min" => "Debes ingresar al menos :min caracter",
        "ci.required" => "Este campo es obligatorio",
        "ci.min" => "Debes ingresar al menos :min caracter",
        "fecha_nac.required" => "Este campo es obligatorio",
        "posicion.required" => "Este campo es obligatorio",
        "posicion.min" => "Debes ingresar al menos :min caracter",
        "altura.required" => "Este campo es obligatorio",
        "peso.required" => "Este campo es obligatorio",
        "pie.required" => "Este campo es obligatorio",
        "valoracion_actual.required" => "Este campo es obligatorio",
        "nro_convocado.required" => "Este campo es obligatorio",
        "nro_alineaciones.required" => "Este campo es obligatorio",
        "minutos_jugados.required" => "Este campo es obligatorio",
        "nro_goles.required" => "Este campo es obligatorio",
        "nro_asistencias.required" => "Este campo es obligatorio",
        "nro_gol_penalti.required" => "Este campo es obligatorio",
        "nro_penalti_cometido.required" => "Este campo es obligatorio",
        "nro_tiro_palo.required" => "Este campo es obligatorio",
        "nro_sustitucion.required" => "Este campo es obligatorio",
        "nro_tarjeta_amarilla.required" => "Este campo es obligatorio",
        "nro_tarjeta_roja.required" => "Este campo es obligatorio",
        "nro_lesiones.required" => "Este campo es obligatorio",
        "puntuacion_valorada.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Jugadors/Index");
    }

    public function listado(Request $request)
    {
        $jugadors = Jugador::select("jugadors.id", "jugadors.nombre", "jugadors.paterno", "jugadors.materno");

        if (isset($request->sin_fichaje) && $request->sin_fichaje) {
            if ($request->id) {
                $jugadors = $jugadors->whereNotExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('fichajes')
                        ->whereRaw('fichajes.jugador_id = jugadors.id');
                })->orWhere(function ($subquery) use ($request) {
                    $subquery->whereIn('jugadors.id', [$request->id]);
                });
            } else {
                $jugadors = $jugadors->whereNotExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('fichajes')
                        ->whereRaw('fichajes.jugador_id = jugadors.id');
                });
            }
        }

        $jugadors = $jugadors->get();

        return response()->json([
            "jugadors" => $jugadors
        ], 200, [], JSON_INVALID_UTF8_SUBSTITUTE);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $jugadors = Jugador::select("jugadors.*");

        if (trim($search) != "") {
            $jugadors->orWhereRaw("CONCAT(nombre,' ', paterno,' ', materno) LIKE ?", ["%$search%"]);
        }

        $jugadors = $jugadors->paginate($request->itemsPerPage);
        return response()->JSON([
            "jugadors" => $jugadors
        ]);
    }

    public function store(Request $request)
    {
        $this->validacion['ci'] = 'required|min:4|numeric|unique:jugadors,ci';
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png,webp|max:2048';
        }
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Jugador
            $nuevo_jugador = Jugador::create(array_map('mb_strtoupper', $request->except('foto')));
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . '_' . $nuevo_jugador->id . '.' . $file->getClientOriginalExtension();
                $nuevo_jugador->foto = $nom_foto;
                $file->move(public_path() . '/imgs/jugadors/', $nom_foto);
            }
            $nuevo_jugador->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_jugador, "jugadors");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->jugador . ' REGISTRO UN JUGADOR',
                'datos_original' => $datos_original,
                'modulo' => 'JUGADORES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("jugadors.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Jugador $jugador)
    {
    }

    public function update(Jugador $jugador, Request $request)
    {
        $this->validacion['ci'] = 'required|min:4|numeric|unique:jugadors,ci,' . $jugador->id;
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png,webp|max:2048';
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($jugador, "jugadors");
            $jugador->update(array_map('mb_strtoupper', $request->except('foto')));
            if ($request->hasFile('foto')) {
                $antiguo = $jugador->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/jugadors/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . '_' . $jugador->id . '.' . $file->getClientOriginalExtension();
                $jugador->foto = $nom_foto;
                $file->move(public_path() . '/imgs/jugadors/', $nom_foto);
            }
            $jugador->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($jugador, "jugadors");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->jugador . ' MODIFICÓ UN JUGADOR',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'JUGADORES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);


            DB::commit();
            return redirect()->route("jugadors.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Jugador $jugador)
    {
        DB::beginTransaction();
        try {
            $antiguo = $jugador->foto;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/jugadors/' . $antiguo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($jugador, "jugadors");
            $jugador->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->jugador . ' ELIMINÓ UN JUGADOR',
                'datos_original' => $datos_original,
                'modulo' => 'JUGADORES',
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
