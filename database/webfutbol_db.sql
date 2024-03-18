-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-03-2024 a las 17:06:33
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `webfutbol_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alineacion_detalles`
--

CREATE TABLE `alineacion_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `alineacion_equipo_id` bigint UNSIGNED NOT NULL,
  `jugador_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alineacion_equipos`
--

CREATE TABLE `alineacion_equipos` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_p` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_e` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fundacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colores` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo_titulos`
--

CREATE TABLE `equipo_titulos` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anio` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichajes`
--

CREATE TABLE `fichajes` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `jugador_id` bigint UNSIGNED NOT NULL,
  `nro_polera` int NOT NULL,
  `fecha_fichaje` date NOT NULL,
  `contrato_hasta` date NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 0<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:12<br/>', NULL, 'USUARIOS', '2024-03-18', '11:54:12', '2024-03-18 15:54:12', '2024-03-18 15:54:12'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 0<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:12<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:16<br/>', 'USUARIOS', '2024-03-18', '11:54:16', '2024-03-18 15:54:16', '2024-03-18 15:54:16'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:16<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUANS<br/>paterno: PERESS<br/>materno: MAMANIS<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:37<br/>', 'USUARIOS', '2024-03-18', '11:54:37', '2024-03-18 15:54:37', '2024-03-18 15:54:37'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUANS<br/>paterno: PERESS<br/>materno: MAMANIS<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:37<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:43<br/>', 'USUARIOS', '2024-03-18', '11:54:43', '2024-03-18 15:54:43', '2024-03-18 15:54:43'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$.p4CCebskMO2LcMm2BIUwuGkMMI5o2e5xp/NEhGWRSqoga3BtIK52<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:43<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$h3y1tnipwBuY3FJz42ZyFeSyuyASZZJNT9BIANV9RznTZ5VSpjzSW<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:46<br/>', 'USUARIOS', '2024-03-18', '11:54:46', '2024-03-18 15:54:46', '2024-03-18 15:54:46'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$h3y1tnipwBuY3FJz42ZyFeSyuyASZZJNT9BIANV9RznTZ5VSpjzSW<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:46<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$bi41OPTk65mY/ifmWga7J.1RERadX6tXsXbKh5mzytmMk2/g29pmu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:54<br/>', 'USUARIOS', '2024-03-18', '11:54:54', '2024-03-18 15:54:54', '2024-03-18 15:54:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucions`
--

CREATE TABLE `institucions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `institucions`
--

INSERT INTO `institucions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `ciudad`, `dir`, `fono`, `correo`, `web`, `actividad`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'WEBFUTBOL', 'WF', 'WEBFUTBOL S.A.', '11111111', 'LA PAZ', 'LOS OLIVOS', '7777777', 'WEBFUTBOL@GMAIL.COM', 'WEBFUTBOL.COM', 'ACTIVIDAD', 'logo.webp', NULL, '2024-03-09 16:40:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugadors`
--

CREATE TABLE `jugadors` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nacionalidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nac` date NOT NULL,
  `posicion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `altura` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `peso` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valoracion_actual` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_convocado` int NOT NULL,
  `nro_alineaciones` int NOT NULL,
  `minutos_jugados` int NOT NULL,
  `nro_goles` int NOT NULL,
  `nro_asistencias` int NOT NULL,
  `nro_gol_penalti` int NOT NULL,
  `nro_penalti_cometido` int NOT NULL,
  `nro_tiro_palo` int NOT NULL,
  `nro_sustitucion` int NOT NULL,
  `nro_tarjeta_amarilla` int NOT NULL,
  `nro_tarjeta_roja` int NOT NULL,
  `nro_lesiones` int NOT NULL,
  `puntuacion_valorada` int NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador_titulos`
--

CREATE TABLE `jugador_titulos` (
  `id` bigint UNSIGNED NOT NULL,
  `jugador_id` bigint UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anio` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2024_01_31_165641_create_institucions_table', 1),
(4, '2024_02_02_205431_create_historial_accions_table', 2),
(5, '2024_03_18_115537_create_equipos_table', 3),
(6, '2024_03_18_115552_create_equipo_titulos_table', 3),
(7, '2024_03_18_115603_create_jugadors_table', 3),
(8, '2024_03_18_115627_create_jugador_titulos_table', 3),
(9, '2024_03_18_115636_create_fichajes_table', 3),
(10, '2024_03_18_115649_create_tabla_posicions_table', 3),
(11, '2024_03_18_115706_create_alineacion_equipos_table', 3),
(12, '2024_03_18_115718_create_prediccion_partidos_table', 3),
(13, '2024_03_18_130227_create_alineacion_detalles_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prediccion_partidos`
--

CREATE TABLE `prediccion_partidos` (
  `id` bigint UNSIGNED NOT NULL,
  `local_id` bigint UNSIGNED NOT NULL,
  `alineacion_local_id` bigint UNSIGNED NOT NULL,
  `visitante_id` bigint UNSIGNED NOT NULL,
  `alineacion_visitante_id` bigint UNSIGNED NOT NULL,
  `r_prediccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `r_final` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_posicions`
--

CREATE TABLE `tabla_posicions` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `tipo_torneo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `temporada` int NOT NULL,
  `pj` int NOT NULL,
  `g` int NOT NULL,
  `e` int NOT NULL,
  `p` int NOT NULL,
  `gf` int NOT NULL,
  `gc` int NOT NULL,
  `dg` int NOT NULL,
  `pts` int NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acceso` int NOT NULL DEFAULT '1',
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `email`, `fono`, `tipo`, `foto`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 'admin', NULL, NULL, '0', '', '', 'admin@gmail.com', '', 'PERIODISTA', NULL, 1, '2024-01-31', NULL, '2024-02-02 18:13:58'),
(2, 'JPERES', '$2y$12$bi41OPTk65mY/ifmWga7J.1RERadX6tXsXbKh5mzytmMk2/g29pmu', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', 'LOS OLIVOS', 'JUAN@GMAIL.COM', '7777777', 'PERIODISTA', '1710777252_JPERES.jpg', 1, '2024-03-18', '2024-03-18 15:54:12', '2024-03-18 15:54:54');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alineacion_detalles`
--
ALTER TABLE `alineacion_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alineacion_detalles_alineacion_equipo_id_foreign` (`alineacion_equipo_id`),
  ADD KEY `alineacion_detalles_jugador_id_foreign` (`jugador_id`);

--
-- Indices de la tabla `alineacion_equipos`
--
ALTER TABLE `alineacion_equipos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alineacion_equipos_equipo_id_foreign` (`equipo_id`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `equipo_titulos`
--
ALTER TABLE `equipo_titulos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipo_titulos_equipo_id_foreign` (`equipo_id`);

--
-- Indices de la tabla `fichajes`
--
ALTER TABLE `fichajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fichajes_equipo_id_foreign` (`equipo_id`),
  ADD KEY `fichajes_jugador_id_foreign` (`jugador_id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `institucions`
--
ALTER TABLE `institucions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `jugadors`
--
ALTER TABLE `jugadors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `jugador_titulos`
--
ALTER TABLE `jugador_titulos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jugador_titulos_jugador_id_foreign` (`jugador_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `prediccion_partidos`
--
ALTER TABLE `prediccion_partidos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tabla_posicions`
--
ALTER TABLE `tabla_posicions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tabla_posicions_equipo_id_foreign` (`equipo_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alineacion_detalles`
--
ALTER TABLE `alineacion_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `alineacion_equipos`
--
ALTER TABLE `alineacion_equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `equipo_titulos`
--
ALTER TABLE `equipo_titulos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fichajes`
--
ALTER TABLE `fichajes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `institucions`
--
ALTER TABLE `institucions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `jugadors`
--
ALTER TABLE `jugadors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jugador_titulos`
--
ALTER TABLE `jugador_titulos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prediccion_partidos`
--
ALTER TABLE `prediccion_partidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tabla_posicions`
--
ALTER TABLE `tabla_posicions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alineacion_detalles`
--
ALTER TABLE `alineacion_detalles`
  ADD CONSTRAINT `alineacion_detalles_alineacion_equipo_id_foreign` FOREIGN KEY (`alineacion_equipo_id`) REFERENCES `alineacion_equipos` (`id`),
  ADD CONSTRAINT `alineacion_detalles_jugador_id_foreign` FOREIGN KEY (`jugador_id`) REFERENCES `jugadors` (`id`);

--
-- Filtros para la tabla `alineacion_equipos`
--
ALTER TABLE `alineacion_equipos`
  ADD CONSTRAINT `alineacion_equipos_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`);

--
-- Filtros para la tabla `equipo_titulos`
--
ALTER TABLE `equipo_titulos`
  ADD CONSTRAINT `equipo_titulos_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`);

--
-- Filtros para la tabla `fichajes`
--
ALTER TABLE `fichajes`
  ADD CONSTRAINT `fichajes_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`),
  ADD CONSTRAINT `fichajes_jugador_id_foreign` FOREIGN KEY (`jugador_id`) REFERENCES `jugadors` (`id`);

--
-- Filtros para la tabla `jugador_titulos`
--
ALTER TABLE `jugador_titulos`
  ADD CONSTRAINT `jugador_titulos_jugador_id_foreign` FOREIGN KEY (`jugador_id`) REFERENCES `jugadors` (`id`);

--
-- Filtros para la tabla `tabla_posicions`
--
ALTER TABLE `tabla_posicions`
  ADD CONSTRAINT `tabla_posicions_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
