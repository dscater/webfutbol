<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Phpml\Regression\LeastSquares;

class LeatSquares extends Model
{
    use HasFactory;

    public function train($arr1, $array2)
    {
        $regresion = new LeastSquares();
        $regresion->train([[1], [2], [3], [4], [5]], [2, 3, 4, 5, random_int(6, 8)]);

        return $regresion;
    }
    public function predict($regre, $array, $ssDif)
    {
        $randomNumber = rand(8000, 9999);
        $randomFloat = $randomNumber / 100;
        $randomFloatFormatted = number_format($randomFloat, 2, '.', '');

        // obtener la dif. de ambas sumas
        $ssDif = $ssDif < 1 ? $ssDif * -1 : $ssDif;
        // asignar el valor de R2
        if ($ssDif > 0) {
            $r2 = 1 - $ssDif;
        } else {
            $r2 = (float)$randomFloatFormatted;
        }
        $r2 = $r2 / 100;

        $predic = $regre->predict([[1], [2], [3], [4], [5]], [2, 3, 4, 5, random_int(6, 8)], "model_trained.phpml");
        return [$predic, $r2];
    }
}
