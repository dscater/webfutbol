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
        Schema::create('alineacion_equipos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("equipo_id");
            $table->string("nombre", 255);
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("equipo_id")->on("equipos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('alineacion_equipos');
    }
};
