<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PrediccionPartido extends Model
{
    use HasFactory;

    protected $fillable = [
        "local_id",
        "alineacion_local_id",
        "visitante_id",
        "alineacion_visitante_id",
        "p_ganador_id",
        "ganador_id",
        "g_local",
        "g_visitante",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function local()
    {
        return $this->belongsTo(Equipo::class, 'local_id');
    }

    public function alineacion_local()
    {
        return $this->belongsTo(AlineacionEquipo::class, 'alineacion_local_id');
    }

    public function visitante()
    {
        return $this->belongsTo(Equipo::class, 'visitante_id');
    }

    public function alineacion_visitante()
    {
        return $this->belongsTo(AlineacionEquipo::class, 'alineacion_visitante_id');
    }

    public function p_ganador()
    {
        return $this->belongsTo(Equipo::class, 'p_ganador_id');
    }

    public function ganador()
    {
        return $this->belongsTo(Equipo::class, 'ganador_id');
    }
}
