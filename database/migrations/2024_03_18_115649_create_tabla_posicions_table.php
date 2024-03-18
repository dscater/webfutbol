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
        Schema::create('tabla_posicions', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("equipo_id");
            $table->string("tipo_torneo", 255);
            $table->integer("temporada");
            $table->integer("pj");
            $table->integer("g");
            $table->integer("e");
            $table->integer("p");
            $table->integer("gf");
            $table->integer("gc");
            $table->integer("dg");
            $table->integer("pts");
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
        Schema::dropIfExists('tabla_posicions');
    }
};
