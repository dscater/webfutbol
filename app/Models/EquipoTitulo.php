<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EquipoTitulo extends Model
{
    use HasFactory;

    protected $fillable = [
        "equipo_id",
        "titulo",
        "anio",
        "fecha",
        "descripcion",
        "tipo",
        "fecha_registro",
    ];


    protected $appends = ["fecha_registro_t", "fecha_t"];

    public function getFechaTAttribute()
    {
        if ($this->fecha) {
            return date("d/m/Y", strtotime($this->fecha));
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
}
