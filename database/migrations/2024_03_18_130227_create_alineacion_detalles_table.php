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
        Schema::create('alineacion_detalles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("alineacion_equipo_id");
            $table->unsignedBigInteger("jugador_id");
            $table->timestamps();

            $table->foreign("alineacion_equipo_id")->on("alineacion_equipos")->references("id");
            $table->foreign("jugador_id")->on("jugadors")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('alineacion_detalles');
    }
};
