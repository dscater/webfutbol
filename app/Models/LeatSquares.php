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
    public function predict($regre, $array)
    {
        return $regre->predict([[1], [2], [3], [4], [5]], [2, 3, 4, 5, random_int(6, 8)], "model_trained.phpml");
    }
}
