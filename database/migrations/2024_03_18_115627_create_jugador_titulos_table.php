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
        Schema::create('jugador_titulos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("jugador_id");
            $table->string("titulo", 255);
            $table->string("anio", 155);
            $table->date("fecha")->nullable();
            $table->text("descripcion");
            $table->string("tipo", 255);
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("jugador_id")->on("jugadors")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jugador_titulos');
    }
};
