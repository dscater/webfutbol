<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('jugadors', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 155);
            $table->string("paterno", 155);
            $table->string("materno", 155)->nullable();
            $table->string("nacionalidad", 255);
            $table->string("ci", 255);
            $table->date("fecha_nac");
            $table->string("posicion", 255);
            $table->string("altura", 255);
            $table->string("peso", 255);
            $table->string("pie", 255);
            $table->string("valoracion_actual", 255);
            $table->string("correo", 255)->nullable();
            $table->string("fono", 155)->nullable();
            $table->string("dir", 255)->nullable();
            $table->integer("nro_convocado");
            $table->integer("nro_alineaciones");
            $table->integer("minutos_jugados");
            $table->integer("nro_goles");
            $table->integer("nro_asistencias");
            $table->integer("nro_gol_penalti");
            $table->integer("nro_penalti_cometido");
            $table->integer("nro_tiro_palo");
            $table->integer("nro_sustitucion");
            $table->integer("nro_tarjeta_amarilla");
            $table->integer("nro_tarjeta_roja");
            $table->integer("nro_lesiones");
            $table->integer("puntuacion_valorada");
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jugadors');
    }
};
