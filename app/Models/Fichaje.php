<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Fichaje extends Model
{
    use HasFactory;

    protected $fillable = [
        "equipo_id",
        "jugador_id",
        "nro_polera",
        "fecha_fichaje",
        "contrato_hasta",
        "descripcion",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "fecha_fichaje_t", "contrato_hasta_t"];

    public function getContratoHastaTAttribute()
    {
        if ($this->contrato_hasta) {
            return date("d/m/Y", strtotime($this->contrato_hasta));
        }
        return "";
    }

    public function getFechaFichajeTAttribute()
    {
        if ($this->fecha_fichaje) {
            return date("d/m/Y", strtotime($this->fecha_fichaje));
        }
        return "";
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }


    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }

    public function jugador()
    {
        return $this->belongsTo(Jugador::class, 'jugador_id');
    }
}
