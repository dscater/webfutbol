<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SVM extends Model
{
    public function train($data)
    {
        $data = array(1 => 0.43, 3 => 0.12, 9284 => 0.2);

        return $this;
    }


    public function predict($modelo)
    {

        return $modelo;
    }
}
