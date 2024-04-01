<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Tabla Posiciones</title>
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
            font-size: 7pt;
        }

        table tbody tr td {
            font-size: 6pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 100px;
            top: -20px;
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

        .subtitulo {
            font-size: 0.9em;
        }
    </style>
</head>

<body>
    @inject('institucion', 'App\Models\Institucion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ $institucion->first()->url_logo }}">
        </div>
        <h2 class="titulo">
            {{ $institucion->first()->razon_social }}
        </h2>
        <h4 class="texto">TABLA DE POSICIONES</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>

    <h4 class="subtitulo centreado">{{ $tipo_torneo }} - {{ $temporada }}</h4>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="3%">N°</th>
                <th>Equipo</th>
                <th>PJ</th>
                <th>G</th>
                <th>E</th>
                <th>P</th>
                <th>GF</th>
                <th>GC</th>
                <th>DG</th>
                <th>PTS</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($tabla_posicions as $tabla_posicions)
                <tr>
                    <td class="centreado">{{ $cont++ }}</td>
                    <td>{{ $tabla_posicions->equipo->nombre }}</td>
                    <td class="centreado">{{ $tabla_posicions->pj }}</td>
                    <td class="centreado">{{ $tabla_posicions->g }}</td>
                    <td class="centreado">{{ $tabla_posicions->e }}</td>
                    <td class="centreado">{{ $tabla_posicions->p }}</td>
                    <td class="centreado">{{ $tabla_posicions->gf }}</td>
                    <td class="centreado">{{ $tabla_posicions->gc }}</td>
                    <td class="centreado">{{ $tabla_posicions->dg }}</td>
                    <td class="centreado">{{ $tabla_posicions->pts }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>

</html>
