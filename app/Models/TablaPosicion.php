<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TablaPosicion extends Model
{
    use HasFactory;

    protected $fillable = [
        "equipo_id",
        "tipo_torneo",
        "temporada",
        "pj",
        "g",
        "e",
        "p",
        "gf",
        "gc",
        "dg",
        "pts",
        "fecha_registro",
    ];


    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }
}
