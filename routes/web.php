<?php

use App\Http\Controllers\EquipoController;
use App\Http\Controllers\EquipoTituloController;
use App\Http\Controllers\FichajeController;
use App\Http\Controllers\InstitucionController;
use App\Http\Controllers\JugadorController;
use App\Http\Controllers\JugadorTituloController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('/', function () {
//     return Inertia::render('Welcome', [
//         'canLogin' => Route::has('login'),
//         'canRegister' => Route::has('register'),
//         'laravelVersion' => Application::VERSION,
//         'phpVersion' => PHP_VERSION,
//     ]);
// });

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
});

Route::get("institucions/getInstitucion", [InstitucionController::class, 'getInstitucion'])->name("institucions.getInstitucion");

Route::middleware('auth')->group(function () {
    // BORRAR
    Route::get('/vuetify', function () {
        return Inertia::render('Vuetify/Index');
    })->name("vuetify");

    // INICIO
    Route::get('/inicio', function () {
        return Inertia::render('Home');
    })->name('inicio');

    // INSTITUCION
    Route::resource("institucions", InstitucionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('/profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get("/getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("/permisos", [UserController::class, 'permisos']);
    Route::get("/menu_user", [UserController::class, 'permisos']);

    // USUARIOS
    Route::put("/usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("/usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("/usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("/usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("/usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("/usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("/usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // EQUIPOS
    Route::get("/equipos/paginado", [EquipoController::class, 'paginado'])->name("equipos.paginado");
    Route::get("/equipos/listado", [EquipoController::class, 'listado'])->name("equipos.listado");
    Route::resource("equipos", EquipoController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // EQUIPOS TITULOS
    Route::get("/equipo_titulos/paginado", [EquipoTituloController::class, 'paginado'])->name("equipo_titulos.paginado");
    Route::get("/equipo_titulos/listado", [EquipoTituloController::class, 'listado'])->name("equipo_titulos.listado");
    Route::resource("equipo_titulos", EquipoTituloController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // JUGADORES
    Route::get("/jugadors/paginado", [JugadorController::class, 'paginado'])->name("jugadors.paginado");
    Route::get("/jugadors/listado", [JugadorController::class, 'listado'])->name("jugadors.listado");
    Route::resource("jugadors", JugadorController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // JUGADORES TITULOS
    Route::get("/jugador_titulos/paginado", [JugadorTituloController::class, 'paginado'])->name("jugador_titulos.paginado");
    Route::get("/jugador_titulos/listado", [JugadorTituloController::class, 'listado'])->name("jugador_titulos.listado");
    Route::resource("jugador_titulos", JugadorTituloController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // FICHAJES
    Route::get("/fichajes/paginado", [FichajeController::class, 'paginado'])->name("fichajes.paginado");
    Route::get("/fichajes/listado", [FichajeController::class, 'listado'])->name("fichajes.listado");
    Route::resource("fichajes", FichajeController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );
});

require __DIR__ . '/auth.php';
