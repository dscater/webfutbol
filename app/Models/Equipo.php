<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Equipo extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "nombre_p",
        "nombre_e",
        "fundacion",
        "colores",
        "ubicacion",
        "logo",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "iniciales_nombre", "url_logo"];

    public function getUrlLogoAttribute()
    {
        if ($this->logo) {
            return asset("imgs/equipos/" . $this->logo);
        }
        return null;
    }

    public function getInicialesNombreAttribute()
    {
        $iniciales = substr($this->nombre, 0, 1) . substr($this->paterno, 0, 1);
        return $iniciales;
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }
}
