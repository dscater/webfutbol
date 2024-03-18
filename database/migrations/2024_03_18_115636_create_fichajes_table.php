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
        Schema::create('fichajes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("equipo_id");
            $table->unsignedBigInteger("jugador_id");
            $table->integer("nro_polera");
            $table->date("fecha_fichaje");
            $table->date("contrato_hasta");
            $table->text("descripcion")->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("equipo_id")->on("equipos")->references("id");
            $table->foreign("jugador_id")->on("jugadors")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('fichajes');
    }
};
