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
        Schema::create('prediccion_partidos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("local_id");
            $table->unsignedBigInteger("alineacion_local_id");
            $table->unsignedBigInteger("visitante_id");
            $table->unsignedBigInteger("alineacion_visitante_id");
            $table->unsignedBigInteger("p_ganador_id")->nullable();
            $table->unsignedBigInteger("ganador_id")->nullable();
            $table->integer("g_local")->nullable();
            $table->integer("g_visitante")->nullable();
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("local_id")->on("equipos")->references("id");
            $table->foreign("alineacion_local_id")->on("alineacion_equipos")->references("id");
            $table->foreign("visitante_id")->on("equipos")->references("id");
            $table->foreign("alineacion_visitante_id")->on("alineacion_equipos")->references("id");
            $table->foreign("p_ganador_id")->on("equipos")->references("id");
            $table->foreign("ganador_id")->on("equipos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('prediccion_partidos');
    }
};
