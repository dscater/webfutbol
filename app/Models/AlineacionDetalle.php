<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AlineacionDetalle extends Model
{
    use HasFactory;

    protected $fillable = [
        "alineacion_equipo_id",
        "fichaje_id",
        "jugador_id",
    ];

    public function fichaje()
    {
        return $this->belongsTo(Fichaje::class, 'fichaje_id');
    }

    public function alineacion_equipo()
    {
        return $this->belongsTo(AlineacionEquipo::class, 'alineacion_equipo_id');
    }

    public function jugador()
    {
        return $this->belongsTo(Jugador::class, 'jugador_id');
    }
}
