<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>jugadors</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 0.5cm;
            margin-bottom: 0.5cm;
            margin-left: 1.5cm;
            margin-right: 0.5cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 8pt;
        }

        table tbody tr td {
            font-size: 7pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 100px;
            top: 0px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #1867c0;
            color: white;
        }

        .txt_rojo {}

        .img_celda img {
            width: 45px;
        }

        .nueva_pagina {
            page-break-after: always;
        }

        .subtitulo {
            font-size: 0.9em;
        }

        .txtinfo {
            font-weight: bold;
        }

        .border-bot {
            border-bottom: solid 0.7px black;
        }

        .table-info {
            margin-top: 4px;
            border-collapse: separate;
            border-spacing: 15px 0px;
        }

        .bordeado {
            border: solid 0.7px black;
            height: 14px;
        }

        .bold {
            font-weight: bold;
        }

        .txt-md {
            font-size: 0.8em;
        }

        .foto {
            width: 15%;
            padding: 0px;
            padding-bottom: 5px;
        }

        .foto img {
            width: 100%;
        }

        .bg-gray {
            background: gray;
        }
    </style>
</head>

<body>
    @inject('institucion', 'App\Models\Institucion')
    @php
        $contador = 0;
    @endphp
    @foreach ($jugadors as $jugador)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $institucion->first()->url_logo }}">
            </div>
            <h2 class="titulo">
                {{ $institucion->first()->razon_social }}
            </h2>
            <h4 class="texto">DATOS DEL JUGADOR</h4>
            <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
        </div>
        <h2 class="subtitulo centreado" style="margin-top:20px;">INFORMACIÓN DEL JUGADOR</h2>
        <table class="table-info">
            <tbody>
                <tr>
                    <td class="centreado border-bot">{{ $jugador->paterno }}</td>
                    <td class="centreado border-bot">{{ $jugador->materno }}</td>
                    <td class="centreado border-bot">{{ $jugador->nombre }}</td>
                    <td rowspan="4" class="foto {{ $jugador->url_foto ? '' : 'bg-gray' }}">
                        @if ($jugador->url_foto)
                            <img src="{{ $jugador->url_foto }}" alt="">
                        @endif
                    </td>
                </tr>
                <tr>
                    <td class="centreado txtinfo">Ap. Paterno</td>
                    <td class="centreado txtinfo">Ap. Materno</td>
                    <td class="centreado txtinfo">Nombre(s)</td>
                </tr>
                <tr>
                    <td class="centreado border-bot">{{ $jugador->nacionalidad }}</td>
                    <td class="centreado border-bot">{{ $jugador->fecha_nac }}</td>
                    <td class="centreado border-bot">{{ $jugador->pie }}</td>
                </tr>
                <tr>
                    <td class="centreado txtinfo">Nacionalidad</td>
                    <td class="centreado txtinfo">Fecha de Nacimiento</td>
                    <td class="centreado txtinfo">Pie</td>
                </tr>
                <tr>
                    <td class="centreado border-bot">{{ $jugador->posicion }}</td>
                    <td class="centreado border-bot">{{ $jugador->altura }}</td>
                    <td class="centreado border-bot">{{ $jugador->peso }}</td>
                    <td class="centreado border-bot">{{ $jugador->ci }}</td>
                </tr>
                <tr>
                    <td class="centreado txtinfo">Posición de Juego</td>
                    <td class="centreado txtinfo">Altura</td>
                    <td class="centreado txtinfo">Peso</td>
                    <td class="centreado txtinfo">Número CI/DNI</td>
                </tr>
                <tr>
                    <td class="centreado border-bot">{{ $jugador->valoracion_actual }}</td>
                    <td class="centreado border-bot">{{ $jugador->correo }}</td>
                    <td class="centreado border-bot">{{ $jugador->dir }}</td>
                    <td class="centreado border-bot">{{ $jugador->fono }}</td>
                </tr>
                <tr>
                    <td class="centreado txtinfo">Valoración de Mercado actual</td>
                    <td class="centreado txtinfo">Correo Electrónico</td>
                    <td class="centreado txtinfo">Dirección</td>
                    <td class="centreado txtinfo">Teléfono</td>
                </tr>
            </tbody>
        </table>
        <h2 class="subtitulo centreado">DATOS DE RENDIMIENTO</h2>
        <table border="1">
            <thead>
                <tr>
                    <th class="centreado">No. Convocado</th>
                    <th class="centreado">No. Alineaciones</th>
                    <th class="centreado">Min. Jugados</th>
                    <th class="centreado">No. Goles</th>
                    <th class="centreado">No. Asistencias</th>
                    <th class="centreado">No. Gol Penalti</th>
                    <th class="centreado">No. Penalti Cometido</th>
                    <th class="centreado">No. Tiro al Palo</th>
                    <th class="centreado">No. Sustitución</th>
                    <th class="centreado">No. Tarjeta Amarilla</th>
                    <th class="centreado">No. Tarjeta Roja</th>
                    <th class="centreado">No. Lesiones</th>
                    <th class="centreado">Puntuación Valorada</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="centreado">{{ $jugador->nro_convocado }}</td>
                    <td class="centreado">{{ $jugador->nro_alineaciones }}</td>
                    <td class="centreado">{{ $jugador->minutos_jugados }}</td>
                    <td class="centreado">{{ $jugador->nro_goles }}</td>
                    <td class="centreado">{{ $jugador->nro_asistencias }}</td>
                    <td class="centreado">{{ $jugador->nro_gol_penalti }}</td>
                    <td class="centreado">{{ $jugador->nro_penalti_cometido }}</td>
                    <td class="centreado">{{ $jugador->nro_tiro_palo }}</td>
                    <td class="centreado">{{ $jugador->nro_sustitucion }}</td>
                    <td class="centreado">{{ $jugador->nro_tarjeta_amarilla }}</td>
                    <td class="centreado">{{ $jugador->nro_tarjeta_roja }}</td>
                    <td class="centreado">{{ $jugador->nro_lesiones }}</td>
                    <td class="centreado">{{ $jugador->puntuacion_valorada }}</td>
                </tr>
            </tbody>
        </table>
        <h2 class="subtitulo centreado">TÍTULOS DEL JUGADOR</h2>
        @if (count($jugador->jugador_titulos) > 0)
            @php
                $jugador_titulos = $jugador->jugador_titulos;
            @endphp
            <table border="1">
                <thead>
                    <tr>
                        <th width="3%" class="centreado">N°</th>
                        <th>Nombre del Título</th>
                        <th>Año</th>
                        <th>Fecha</th>
                        <th>Descripción</th>
                        <th>Tipo</th>
                        <th>Fecha de Registro</th>
                    </tr>
                </thead>
                <tbody>
                    @php
                        $cont = 1;
                    @endphp
                    @foreach ($jugador_titulos as $value)
                        <tr>
                            <td class="centreado">{{ $cont++ }}</td>
                            <td>{{ $value->titulo }}</td>
                            <td>{{ $value->anio }}</td>
                            <td>{{ $value->fecha_t }}</td>
                            <td>{{ $value->descripcion }}</td>
                            <td>{{ $value->tipo }}</td>
                            <td>{{ $value->fecha_registro_t }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        @else
            <p class="txt-md centreado">NO SE ENCONTRÓ NINGUN REGISTRO</p>
        @endif
        @php
            $contador++;
        @endphp
        @if ($contador < count($jugadors))
            <div class="nueva_pagina"></div>
        @endif
    @endforeach
</body>

</html>
