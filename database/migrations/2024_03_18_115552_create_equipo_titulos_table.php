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
        Schema::create('equipo_titulos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("equipo_id");
            $table->string("titulo");
            $table->string("anio");
            $table->date("fecha");
            $table->text("descripcion")->nullable();
            $table->string("tipo");
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
        Schema::dropIfExists('equipo_titulos');
    }
};
