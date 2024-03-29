<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Jugador extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "paterno",
        "materno",
        "nacionalidad",
        "ci",
        "fecha_nac",
        "posicion",
        "altura",
        "peso",
        "pie",
        "valoracion_actual",
        "correo",
        "fono",
        "dir",
        "foto",
        "nro_convocado",
        "nro_alineaciones",
        "minutos_jugados",
        "nro_goles",
        "nro_asistencias",
        "nro_gol_penalti",
        "nro_penalti_cometido",
        "nro_tiro_palo",
        "nro_sustitucion",
        "nro_tarjeta_amarilla",
        "nro_tarjeta_roja",
        "nro_lesiones",
        "puntuacion_valorada",
        "fecha_registro",
    ];

    protected $appends = ["full_name", "fecha_registro_t", "iniciales_nombre", "url_foto", "mas"];

    public function getMasAttribute()
    {
        return false;
    }

    public function getFullNameAttribute()
    {
        return $this->nombre . ' ' . $this->paterno . ($this->materno != NULL && $this->materno != '' ? ' ' . $this->materno : '');
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getFechaNacTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_nac));
    }

    public function getUrlFotoAttribute()
    {
        if ($this->foto) {
            return asset("imgs/jugadors/" . $this->foto);
        }
        return null;
    }

    public function getInicialesNombreAttribute()
    {
        $iniciales = substr($this->nombre, 0, 1) . substr($this->paterno, 0, 1);
        return $iniciales;
    }

    public function jugador_titulos()
    {
        return $this->hasMany(JugadorTitulo::class, 'jugador_id');
    }
}
