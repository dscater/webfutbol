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
        Schema::create('equipos', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 255);
            $table->string("nombre_p", 255);
            $table->string("nombre_e", 255);
            $table->string("fundacion", 255)->nullable();
            $table->string("colores", 255)->nullable();
            $table->string("ubicacion", 255)->nullable();
            $table->string("logo", 255)->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('equipos');
    }
};
