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
            $table->string("r_prediccion");
            $table->string("r_final")->nullable();
            $table->timestamps();
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
