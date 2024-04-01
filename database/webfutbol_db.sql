-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 01-04-2024 a las 16:49:15
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
  `fichaje_id` bigint UNSIGNED NOT NULL,
  `jugador_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alineacion_detalles`
--

INSERT INTO `alineacion_detalles` (`id`, `alineacion_equipo_id`, `fichaje_id`, `jugador_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(2, 1, 2, 2, '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(3, 1, 3, 3, '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(4, 1, 4, 4, '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(5, 1, 5, 5, '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(6, 1, 6, 6, '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(8, 1, 8, 8, '2024-03-31 17:38:59', '2024-03-31 17:38:59'),
(9, 2, 13, 13, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(10, 2, 14, 14, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(11, 2, 15, 15, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(12, 2, 16, 16, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(13, 2, 17, 17, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(14, 2, 18, 18, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(15, 2, 19, 19, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(16, 2, 20, 20, '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(17, 2, 21, 21, '2024-03-31 22:54:16', '2024-03-31 22:54:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alineacion_equipos`
--

CREATE TABLE `alineacion_equipos` (
  `id` bigint UNSIGNED NOT NULL,
  `equipo_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alineacion_equipos`
--

INSERT INTO `alineacion_equipos` (`id`, `equipo_id`, `nombre`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'ALINEACION #1', '2024-03-31', '2024-03-31 17:20:12', '2024-03-31 17:20:12'),
(2, 2, 'ALINEACION #1 EQUIPO #2', '2024-03-31', '2024-03-31 22:54:16', '2024-03-31 22:54:16');

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

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`id`, `nombre`, `nombre_p`, `nombre_e`, `fundacion`, `colores`, `ubicacion`, `logo`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'EQUIPO #1', 'JUAN PERES', 'EDUARDO MARTINEZ', '', 'AMARILLO', 'UBICACION EQUIPO #1', '1711663731_.png', '2024-03-28', '2024-03-28 22:08:51', '2024-03-28 22:08:58'),
(2, 'EQUIPO #2', 'MARCOS MARTINEZ', 'JUAN GONZALES', '', 'AZUL Y BLANCO', '', NULL, '2024-03-28', '2024-03-28 22:20:38', '2024-03-28 22:20:38');

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

--
-- Volcado de datos para la tabla `equipo_titulos`
--

INSERT INTO `equipo_titulos` (`id`, `equipo_id`, `titulo`, `anio`, `fecha`, `descripcion`, `tipo`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'TITULO #1 (E1)', '2020', '2020-01-21', 'DESC. TITULO #1', 'NACIONAL', '2024-03-28', '2024-03-28 22:29:49', '2024-03-28 22:29:49'),
(2, 2, 'TITULO #2', '2020', '2020-01-01', 'DESC', 'NACIONAL', '2024-03-29', '2024-03-29 17:13:38', '2024-03-29 17:13:38');

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

--
-- Volcado de datos para la tabla `fichajes`
--

INSERT INTO `fichajes` (`id`, `equipo_id`, `jugador_id`, `nro_polera`, `fecha_fichaje`, `contrato_hasta`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2024-02-01', '2024-12-31', 'DESC. FICHAJE #1', '2024-03-29', '2024-03-29 17:25:14', '2024-03-29 17:25:14'),
(2, 1, 2, 3, '2024-03-02', '2024-12-31', '', '2024-03-31', '2024-03-31 16:35:23', '2024-03-31 16:35:23'),
(3, 1, 3, 7, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:36:23', '2024-03-31 16:36:23'),
(4, 1, 4, 5, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:37:02', '2024-03-31 16:37:02'),
(5, 1, 5, 10, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:37:19', '2024-03-31 16:37:19'),
(6, 1, 6, 12, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:37:35', '2024-03-31 16:37:35'),
(7, 1, 7, 13, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:37:49', '2024-03-31 16:37:49'),
(8, 1, 8, 16, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:38:00', '2024-03-31 16:38:00'),
(9, 1, 9, 13, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:38:19', '2024-03-31 16:38:19'),
(10, 1, 10, 20, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:38:34', '2024-03-31 16:38:34'),
(11, 1, 11, 15, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:38:44', '2024-03-31 16:38:44'),
(12, 1, 12, 24, '2024-01-09', '2024-12-31', '', '2024-03-31', '2024-03-31 16:38:56', '2024-03-31 16:38:56'),
(13, 2, 13, 1, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:39:51', '2024-03-31 16:42:19'),
(14, 2, 14, 3, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:40:10', '2024-03-31 16:40:10'),
(15, 2, 15, 11, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:40:20', '2024-03-31 16:40:20'),
(16, 2, 16, 8, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:40:32', '2024-03-31 16:40:32'),
(17, 2, 17, 10, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:40:41', '2024-03-31 16:40:41'),
(18, 2, 18, 4, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:40:57', '2024-03-31 16:40:57'),
(19, 2, 19, 12, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:41:09', '2024-03-31 16:41:09'),
(20, 2, 20, 13, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:41:28', '2024-03-31 16:41:28'),
(21, 2, 21, 14, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:41:41', '2024-03-31 16:41:41'),
(22, 2, 22, 16, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:41:52', '2024-03-31 16:41:52'),
(23, 2, 23, 23, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:42:03', '2024-03-31 16:42:03'),
(24, 2, 24, 18, '2024-01-01', '2024-12-31', '', '2024-03-31', '2024-03-31 16:42:14', '2024-03-31 16:42:14');

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
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$h3y1tnipwBuY3FJz42ZyFeSyuyASZZJNT9BIANV9RznTZ5VSpjzSW<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:46<br/>', 'id: 2<br/>usuario: JPERES<br/>password: $2y$12$bi41OPTk65mY/ifmWga7J.1RERadX6tXsXbKh5mzytmMk2/g29pmu<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>tipo: PERIODISTA<br/>foto: 1710777252_JPERES.jpg<br/>acceso: 1<br/>fecha_registro: 2024-03-18 00:00:00<br/>created_at: 2024-03-18 11:54:12<br/>updated_at: 2024-03-18 11:54:54<br/>', 'USUARIOS', '2024-03-18', '11:54:54', '2024-03-18 15:54:54', '2024-03-18 15:54:54'),
(7, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663438_.jpeg<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:03:58<br/>', NULL, 'EQUIPOS', '2024-03-28', '18:03:58', '2024-03-28 22:03:58', '2024-03-28 22:03:58'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663438_.jpeg<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:03:58<br/>', 'id: 2<br/>nombre: EQUIPO #1S<br/>nombre_p: JUAN PERESS<br/>nombre_e: EDUARDO MARTINEZS<br/>fundacion: <br/>colores: AZUL Y ROJOS<br/>ubicacion: UBICACION EQUIPO #1S<br/>logo: 1711663438_.jpeg<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:07:42<br/>', 'EQUIPOS', '2024-03-28', '18:07:42', '2024-03-28 22:07:42', '2024-03-28 22:07:42'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #1S<br/>nombre_p: JUAN PERESS<br/>nombre_e: EDUARDO MARTINEZS<br/>fundacion: <br/>colores: AZUL Y ROJOS<br/>ubicacion: UBICACION EQUIPO #1S<br/>logo: 1711663438_.jpeg<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:07:42<br/>', 'id: 2<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663670_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:07:50<br/>', 'EQUIPOS', '2024-03-28', '18:07:50', '2024-03-28 22:07:50', '2024-03-28 22:07:50'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663670_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:07:50<br/>', 'id: 2<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663710_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:08:30<br/>', 'EQUIPOS', '2024-03-28', '18:08:30', '2024-03-28 22:08:30', '2024-03-28 22:08:30'),
(11, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663710_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:03:58<br/>updated_at: 2024-03-28 18:08:30<br/>', NULL, 'EQUIPOS', '2024-03-28', '18:08:34', '2024-03-28 22:08:34', '2024-03-28 22:08:34'),
(12, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN EQUIPO', 'id: 1<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663731_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:08:51<br/>updated_at: 2024-03-28 18:08:51<br/>', NULL, 'EQUIPOS', '2024-03-28', '18:08:51', '2024-03-28 22:08:51', '2024-03-28 22:08:51'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN EQUIPO', 'id: 1<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AZUL Y ROJO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663731_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:08:51<br/>updated_at: 2024-03-28 18:08:51<br/>', 'id: 1<br/>nombre: EQUIPO #1<br/>nombre_p: JUAN PERES<br/>nombre_e: EDUARDO MARTINEZ<br/>fundacion: <br/>colores: AMARILLO<br/>ubicacion: UBICACION EQUIPO #1<br/>logo: 1711663731_.png<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:08:51<br/>updated_at: 2024-03-28 18:08:58<br/>', 'EQUIPOS', '2024-03-28', '18:08:58', '2024-03-28 22:08:58', '2024-03-28 22:08:58'),
(14, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #2<br/>nombre_p: MARCOS MARTINEZ<br/>nombre_e: JUAN GONZALES<br/>fundacion: <br/>colores: AZUL Y BLANCO<br/>ubicacion: <br/>logo: <br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:20:38<br/>updated_at: 2024-03-28 18:20:38<br/>', NULL, 'EQUIPOS', '2024-03-28', '18:20:38', '2024-03-28 22:20:38', '2024-03-28 22:20:38'),
(15, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN EQUIPO', 'id: 2<br/>nombre: EQUIPO #2<br/>nombre_p: MARCOS MARTINEZ<br/>nombre_e: JUAN GONZALES<br/>fundacion: <br/>colores: AZUL Y BLANCO<br/>ubicacion: <br/>logo: <br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:20:38<br/>updated_at: 2024-03-28 18:20:38<br/>', 'id: 2<br/>nombre: EQUIPO #2<br/>nombre_p: MARCOS MARTINEZ<br/>nombre_e: JUAN GONZALES<br/>fundacion: <br/>colores: AZUL Y BLANCO<br/>ubicacion: <br/>logo: <br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:20:38<br/>updated_at: 2024-03-28 18:20:38<br/>', 'EQUIPOS', '2024-03-28', '18:20:43', '2024-03-28 22:20:43', '2024-03-28 22:20:43'),
(16, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN TÍTULO DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>titulo: TITULO #1 (E1)<br/>anio: 2013<br/>fecha: 2013-03-03<br/>descripcion: DESCRIPCION TITULO<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:27:44<br/>updated_at: 2024-03-28 18:27:44<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-28', '18:27:44', '2024-03-28 22:27:44', '2024-03-28 22:27:44'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>titulo: TITULO #1 (E1)<br/>anio: 2013<br/>fecha: 2013-03-03<br/>descripcion: DESCRIPCION TITULO<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:27:44<br/>updated_at: 2024-03-28 18:27:44<br/>', 'id: 1<br/>equipo_id: 2<br/>titulo: TITULO #1 (E1)S<br/>anio: 2013S<br/>fecha: 2013-03-04<br/>descripcion: DESCRIPCION TITULOS<br/>tipo: INTERNACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:27:44<br/>updated_at: 2024-03-28 18:27:55<br/>', 'TÍTULO DE EQUIPOS', '2024-03-28', '18:27:55', '2024-03-28 22:27:55', '2024-03-28 22:27:55'),
(18, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>equipo_id: 2<br/>titulo: TITULO #1 (E1)S<br/>anio: 2013S<br/>fecha: 2013-03-04<br/>descripcion: DESCRIPCION TITULOS<br/>tipo: INTERNACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:27:44<br/>updated_at: 2024-03-28 18:27:55<br/>', 'id: 1<br/>equipo_id: 1<br/>titulo: TITULO #1 (E1)<br/>anio: 2013<br/>fecha: 2013-03-03<br/>descripcion: DESCRIPCION TITULO<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:27:44<br/>updated_at: 2024-03-28 18:28:04<br/>', 'TÍTULO DE EQUIPOS', '2024-03-28', '18:28:04', '2024-03-28 22:28:04', '2024-03-28 22:28:04'),
(19, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>titulo: TITULO #1 (E1)<br/>anio: 2013<br/>fecha: 2013-03-03<br/>descripcion: DESCRIPCION TITULO<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:27:44<br/>updated_at: 2024-03-28 18:28:04<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-28', '18:28:44', '2024-03-28 22:28:44', '2024-03-28 22:28:44'),
(20, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN TÍTULO DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>titulo: TITULO #1 (E1)<br/>anio: 2020<br/>fecha: 2020-01-21<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-28<br/>created_at: 2024-03-28 18:29:49<br/>updated_at: 2024-03-28 18:29:49<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-28', '18:29:49', '2024-03-28 22:29:49', '2024-03-28 22:29:49'),
(21, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN JUGADOR', 'id: 1<br/>nombre: CARLOS<br/>paterno: CORTEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2001-01-01<br/>posicion: PORTERO<br/>altura: 1.98 M<br/>peso: 97 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_1.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 90.5<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:10:20<br/>', NULL, 'JUGADORES', '2024-03-29', '12:10:20', '2024-03-29 16:10:20', '2024-03-29 16:10:20'),
(22, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN JUGADOR', 'id: 2<br/>nombre: CARLOS<br/>paterno: CORTEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2001-01-01<br/>posicion: PORTERO<br/>altura: 1.98 M<br/>peso: 97 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_2.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 90.5<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:10:20<br/>', NULL, 'JUGADORES', '2024-03-29', '12:10:20', '2024-03-29 16:10:20', '2024-03-29 16:10:20'),
(23, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 2<br/>nombre: CARLOS<br/>paterno: CORTEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2001-01-01<br/>posicion: PORTERO<br/>altura: 1.98 M<br/>peso: 97 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_2.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:10:20<br/>', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_2.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:23<br/>', 'JUGADORES', '2024-03-29', '12:32:23', '2024-03-29 16:32:23', '2024-03-29 16:32:23'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_2.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:23<br/>', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711729950_2.jpeg<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:30<br/>', 'JUGADORES', '2024-03-29', '12:32:30', '2024-03-29 16:32:30', '2024-03-29 16:32:30'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711729950_2.jpeg<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:30<br/>', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711729950_2.jpeg<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:30<br/>', 'JUGADORES', '2024-03-29', '12:32:34', '2024-03-29 16:32:34', '2024-03-29 16:32:34'),
(26, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711729950_2.jpeg<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:30<br/>', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711729950_2.jpeg<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:30<br/>', 'JUGADORES', '2024-03-29', '12:32:37', '2024-03-29 16:32:37', '2024-03-29 16:32:37'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 1<br/>nombre: CARLOS<br/>paterno: CORTEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2001-01-01<br/>posicion: PORTERO<br/>altura: 1.98 M<br/>peso: 97 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_1.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:10:20<br/>', 'id: 1<br/>nombre: CARLOS<br/>paterno: CORTEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2001-01-01<br/>posicion: PORTERO<br/>altura: 1.98 M<br/>peso: 97 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711728620_1.png<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 0<br/>nro_asistencias: 0<br/>nro_gol_penalti: 0<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 0<br/>nro_sustitucion: 0<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:58<br/>', 'JUGADORES', '2024-03-29', '12:32:58', '2024-03-29 16:32:58', '2024-03-29 16:32:58'),
(28, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN JUGADOR', 'id: 2<br/>nombre: JUAN<br/>paterno: MARTINEZ<br/>materno: MARTINEZ<br/>nacionalidad: BOLIVIANO<br/>ci: 343434<br/>fecha_nac: 2001-01-01<br/>posicion: DELANTERO<br/>altura: 1.8 M<br/>peso: 85 KG<br/>pie: DERECHO<br/>valoracion_actual: 100000<br/>correo: CARLOS@GMAIL.COM<br/>fono: 7777777<br/>dir: LOS OLIVOS<br/>foto: 1711729950_2.jpeg<br/>nro_convocado: 2<br/>nro_alineaciones: 2<br/>minutos_jugados: 300<br/>nro_goles: 10<br/>nro_asistencias: 5<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 0<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 2<br/>nro_tarjeta_roja: 0<br/>nro_lesiones: 0<br/>puntuacion_valorada: 91<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:10:20<br/>updated_at: 2024-03-29 12:32:30<br/>', NULL, 'JUGADORES', '2024-03-29', '12:33:29', '2024-03-29 16:33:29', '2024-03-29 16:33:29'),
(29, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:48:21<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-29', '12:48:21', '2024-03-29 16:48:21', '2024-03-29 16:48:21'),
(30, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:48:21<br/>', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1S<br/>anio: 2013S<br/>fecha: 2013-02-01<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:18<br/>', 'TÍTULO DE EQUIPOS', '2024-03-29', '12:49:18', '2024-03-29 16:49:18', '2024-03-29 16:49:18'),
(31, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1S<br/>anio: 2013S<br/>fecha: 2013-02-01<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:18<br/>', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1S<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:26<br/>', 'TÍTULO DE EQUIPOS', '2024-03-29', '12:49:26', '2024-03-29 16:49:26', '2024-03-29 16:49:26'),
(32, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1S<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:26<br/>', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1<br/>tipo: INTERNACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:31<br/>', 'TÍTULO DE EQUIPOS', '2024-03-29', '12:49:31', '2024-03-29 16:49:31', '2024-03-29 16:49:31'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1<br/>tipo: INTERNACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:31<br/>', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:34<br/>', 'TÍTULO DE EQUIPOS', '2024-03-29', '12:49:34', '2024-03-29 16:49:34', '2024-03-29 16:49:34'),
(34, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-02-02<br/>descripcion: DESC. TITULO #1<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:48:21<br/>updated_at: 2024-03-29 12:49:34<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-29', '12:50:02', '2024-03-29 16:50:02', '2024-03-29 16:50:02'),
(35, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN TÍTULO DE EQUIPO', 'id: 1<br/>jugador_id: 1<br/>titulo: TITULO #1<br/>anio: 2013<br/>fecha: 2013-01-01<br/>descripcion: <br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 12:50:19<br/>updated_at: 2024-03-29 12:50:19<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-29', '12:50:19', '2024-03-29 16:50:19', '2024-03-29 16:50:19'),
(36, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN TÍTULO DE EQUIPO', 'id: 2<br/>equipo_id: 2<br/>titulo: TITULO #2<br/>anio: 2020<br/>fecha: 2020-01-01<br/>descripcion: DESC<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:13:38<br/>updated_at: 2024-03-29 13:13:38<br/>', NULL, 'TÍTULO DE EQUIPOS', '2024-03-29', '13:13:38', '2024-03-29 17:13:38', '2024-03-29 17:13:38'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN TÍTULO DE EQUIPO', 'id: 2<br/>equipo_id: 2<br/>titulo: TITULO #2<br/>anio: 2020<br/>fecha: 2020-01-01<br/>descripcion: DESC<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:13:38<br/>updated_at: 2024-03-29 13:13:38<br/>', 'id: 2<br/>equipo_id: 2<br/>titulo: TITULO #2<br/>anio: 2020<br/>fecha: 2020-01-01<br/>descripcion: DESC<br/>tipo: NACIONAL<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:13:38<br/>updated_at: 2024-03-29 13:13:38<br/>', 'TÍTULO DE EQUIPOS', '2024-03-29', '13:13:41', '2024-03-29 17:13:41', '2024-03-29 17:13:41'),
(38, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-01<br/>descripcion: DESC. FICHAJE #1<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:20:12<br/>', NULL, 'FICHAJES', '2024-03-29', '13:20:12', '2024-03-29 17:20:12', '2024-03-29 17:20:12'),
(39, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-01<br/>descripcion: DESC. FICHAJE #1<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:20:12<br/>', 'id: 1<br/>equipo_id: 2<br/>jugador_id: 1<br/>nro_polera: 2<br/>fecha_fichaje: 2024-01-02<br/>contrato_hasta: 0001-03-01<br/>descripcion: DESC. FICHAJE #1S<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:23:21<br/>', 'FICHAJES', '2024-03-29', '13:23:21', '2024-03-29 17:23:21', '2024-03-29 17:23:21'),
(40, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN FICHAJE', 'id: 1<br/>equipo_id: 2<br/>jugador_id: 1<br/>nro_polera: 2<br/>fecha_fichaje: 2024-01-02<br/>contrato_hasta: 0001-03-01<br/>descripcion: DESC. FICHAJE #1S<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:23:21<br/>', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-01<br/>descripcion: DESC. FICHAJE #1S<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:23:59<br/>', 'FICHAJES', '2024-03-29', '13:23:59', '2024-03-29 17:23:59', '2024-03-29 17:23:59'),
(41, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-01<br/>descripcion: DESC. FICHAJE #1S<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:23:59<br/>', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: DESC. FICHAJE #1S<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:24:08<br/>', 'FICHAJES', '2024-03-29', '13:24:08', '2024-03-29 17:24:08', '2024-03-29 17:24:08'),
(42, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: DESC. FICHAJE #1S<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:24:08<br/>', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-02<br/>contrato_hasta: 2024-12-31<br/>descripcion: DESC. FICHAJE #1<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:24:20<br/>', 'FICHAJES', '2024-03-29', '13:24:20', '2024-03-29 17:24:20', '2024-03-29 17:24:20'),
(43, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-02<br/>contrato_hasta: 2024-12-31<br/>descripcion: DESC. FICHAJE #1<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:20:12<br/>updated_at: 2024-03-29 13:24:20<br/>', NULL, 'FICHAJES', '2024-03-29', '13:24:55', '2024-03-29 17:24:55', '2024-03-29 17:24:55'),
(44, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>jugador_id: 1<br/>nro_polera: 1<br/>fecha_fichaje: 2024-02-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: DESC. FICHAJE #1<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 13:25:14<br/>updated_at: 2024-03-29 13:25:14<br/>', NULL, 'FICHAJES', '2024-03-29', '13:25:14', '2024-03-29 17:25:14', '2024-03-29 17:25:14'),
(45, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA TABLA DE POSICION', 'id: 1<br/>equipo_id: 1<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 10<br/>e: 5<br/>p: 5<br/>gf: 20<br/>gc: 13<br/>dg: 7<br/>pts: 30<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 17:23:17<br/>updated_at: 2024-03-29 17:23:17<br/>', NULL, 'TABLA DE POSICIONES', '2024-03-29', '17:23:17', '2024-03-29 21:23:17', '2024-03-29 21:23:17'),
(46, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA TABLA DE POSICION', 'id: 1<br/>equipo_id: 1<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 10<br/>e: 5<br/>p: 5<br/>gf: 20<br/>gc: 13<br/>dg: 7<br/>pts: 30<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 17:23:17<br/>updated_at: 2024-03-29 17:23:17<br/>', 'id: 1<br/>equipo_id: 1<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 10<br/>e: 5<br/>p: 5<br/>gf: 20<br/>gc: 13<br/>dg: 7<br/>pts: 35<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 17:23:17<br/>updated_at: 2024-03-29 17:23:52<br/>', 'TABLA DE POSICIONES', '2024-03-29', '17:23:52', '2024-03-29 21:23:52', '2024-03-29 21:23:52'),
(47, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA TABLA DE POSICION', 'id: 2<br/>equipo_id: 1<br/>tipo_torneo: CLAUSURA<br/>temporada: 2023<br/>pj: 20<br/>g: 2<br/>e: 2<br/>p: 2<br/>gf: 2<br/>gc: 2<br/>dg: 2<br/>pts: 2<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 17:24:55<br/>updated_at: 2024-03-29 17:24:55<br/>', NULL, 'TABLA DE POSICIONES', '2024-03-29', '17:24:55', '2024-03-29 21:24:55', '2024-03-29 21:24:55'),
(48, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA TABLA DE POSICION', 'id: 2<br/>equipo_id: 1<br/>tipo_torneo: CLAUSURA<br/>temporada: 2023<br/>pj: 20<br/>g: 2<br/>e: 2<br/>p: 2<br/>gf: 2<br/>gc: 2<br/>dg: 2<br/>pts: 2<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 17:24:55<br/>updated_at: 2024-03-29 17:24:55<br/>', NULL, 'TABLA DE POSICIONES', '2024-03-29', '17:24:58', '2024-03-29 21:24:58', '2024-03-29 21:24:58'),
(49, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN JUGADOR', 'id: 2<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', NULL, 'JUGADORES', '2024-03-31', '12:22:09', '2024-03-31 16:22:09', '2024-03-31 16:22:09'),
(50, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 3<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 3<br/>nombre: JUAN<br/>paterno: CHOQUE<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 4444322<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 74<br/>pie: DERECHO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 2<br/>nro_alineaciones: 3<br/>minutos_jugados: 150<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 50<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:23:31<br/>', 'JUGADORES', '2024-03-31', '12:23:31', '2024-03-31 16:23:31', '2024-03-31 16:23:31'),
(51, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 4<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 4<br/>nombre: ALEX<br/>paterno: CAMPOS<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: MEDIO CAMPO<br/>altura: 1,8<br/>peso: 81<br/>pie: IZQUIERDO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 6<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 20<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 65<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:24:06<br/>', 'JUGADORES', '2024-03-31', '12:24:06', '2024-03-31 16:24:06', '2024-03-31 16:24:06'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 5<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 5<br/>nombre: LEONEL<br/>paterno: CARVAJAL<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DEFENSA<br/>altura: 1,9<br/>peso: 92<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 65<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:24:33<br/>', 'JUGADORES', '2024-03-31', '12:24:33', '2024-03-31 16:24:33', '2024-03-31 16:24:33'),
(53, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 6<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 6<br/>nombre: LUIS<br/>paterno: JAUREGUI<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 10000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 10<br/>nro_alineaciones: 7<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 93<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:25:26<br/>', 'JUGADORES', '2024-03-31', '12:25:26', '2024-03-31 16:25:26', '2024-03-31 16:25:26'),
(54, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 7<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 7<br/>nombre: GUILLERMO<br/>paterno: VISCARRA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: VOLANTE DERECHO<br/>altura: 1,77<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:26:05<br/>', 'JUGADORES', '2024-03-31', '12:26:05', '2024-03-31 16:26:05', '2024-03-31 16:26:05'),
(55, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 8<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 8<br/>nombre: JOSE<br/>paterno: SAUCEDO<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DEFENSA CENTRAL<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:26:26<br/>', 'JUGADORES', '2024-03-31', '12:26:26', '2024-03-31 16:26:26', '2024-03-31 16:26:26'),
(56, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 2<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 2<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 54454<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:26:37<br/>', 'JUGADORES', '2024-03-31', '12:26:37', '2024-03-31 16:26:37', '2024-03-31 16:26:37'),
(57, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 4<br/>nombre: ALEX<br/>paterno: CAMPOS<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: MEDIO CAMPO<br/>altura: 1,8<br/>peso: 81<br/>pie: IZQUIERDO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 6<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 20<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 65<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:24:06<br/>', 'id: 4<br/>nombre: ALEX<br/>paterno: CAMPOS<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 655656<br/>fecha_nac: 2000-03-03<br/>posicion: MEDIO CAMPO<br/>altura: 1,8<br/>peso: 81<br/>pie: IZQUIERDO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 6<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 20<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 65<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:26:45<br/>', 'JUGADORES', '2024-03-31', '12:26:45', '2024-03-31 16:26:45', '2024-03-31 16:26:45');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(58, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 5<br/>nombre: LEONEL<br/>paterno: CARVAJAL<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DEFENSA<br/>altura: 1,9<br/>peso: 92<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 65<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:24:33<br/>', 'id: 5<br/>nombre: LEONEL<br/>paterno: CARVAJAL<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 65565<br/>fecha_nac: 2000-03-03<br/>posicion: DEFENSA<br/>altura: 1,9<br/>peso: 92<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 65<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:27:43<br/>', 'JUGADORES', '2024-03-31', '12:27:43', '2024-03-31 16:27:43', '2024-03-31 16:27:43'),
(59, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 6<br/>nombre: LUIS<br/>paterno: JAUREGUI<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 10000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 10<br/>nro_alineaciones: 7<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 93<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:25:26<br/>', 'id: 6<br/>nombre: LUIS<br/>paterno: JAUREGUI<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 43433<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 10000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 10<br/>nro_alineaciones: 7<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 93<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:27:53<br/>', 'JUGADORES', '2024-03-31', '12:27:53', '2024-03-31 16:27:53', '2024-03-31 16:27:53'),
(60, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 7<br/>nombre: GUILLERMO<br/>paterno: VISCARRA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: VOLANTE DERECHO<br/>altura: 1,77<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:26:05<br/>', 'id: 7<br/>nombre: GUILLERMO<br/>paterno: VISCARRA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 8777<br/>fecha_nac: 2000-03-03<br/>posicion: VOLANTE DERECHO<br/>altura: 1,77<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:01<br/>', 'JUGADORES', '2024-03-31', '12:28:01', '2024-03-31 16:28:01', '2024-03-31 16:28:01'),
(61, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 8<br/>nombre: JOSE<br/>paterno: SAUCEDO<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DEFENSA CENTRAL<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:26:26<br/>', 'id: 8<br/>nombre: JOSE<br/>paterno: SAUCEDO<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 454454<br/>fecha_nac: 2000-03-03<br/>posicion: DEFENSA CENTRAL<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:08<br/>', 'JUGADORES', '2024-03-31', '12:28:08', '2024-03-31 16:28:08', '2024-03-31 16:28:08'),
(62, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 9<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 9<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 676767<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:14<br/>', 'JUGADORES', '2024-03-31', '12:28:14', '2024-03-31 16:28:14', '2024-03-31 16:28:14'),
(63, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 10<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 10<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 65656<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:20<br/>', 'JUGADORES', '2024-03-31', '12:28:20', '2024-03-31 16:28:20', '2024-03-31 16:28:20'),
(64, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 11<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 11<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 656556<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:24<br/>', 'JUGADORES', '2024-03-31', '12:28:24', '2024-03-31 16:28:24', '2024-03-31 16:28:24'),
(65, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 12<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 12<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 67676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:29<br/>', 'JUGADORES', '2024-03-31', '12:28:29', '2024-03-31 16:28:29', '2024-03-31 16:28:29'),
(66, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 13<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 13<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:34<br/>', 'JUGADORES', '2024-03-31', '12:28:34', '2024-03-31 16:28:34', '2024-03-31 16:28:34'),
(67, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 14<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 14<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 78777<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:38<br/>', 'JUGADORES', '2024-03-31', '12:28:38', '2024-03-31 16:28:38', '2024-03-31 16:28:38'),
(68, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 15<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 15<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 76655<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:43<br/>', 'JUGADORES', '2024-03-31', '12:28:43', '2024-03-31 16:28:43', '2024-03-31 16:28:43'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 16<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 16<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 66555<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:51<br/>', 'JUGADORES', '2024-03-31', '12:28:51', '2024-03-31 16:28:51', '2024-03-31 16:28:51'),
(70, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 17<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 17<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 7666776<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:56<br/>', 'JUGADORES', '2024-03-31', '12:28:56', '2024-03-31 16:28:56', '2024-03-31 16:28:56'),
(71, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 18<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 322323<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:22:09<br/>', 'id: 18<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:29:00<br/>', 'JUGADORES', '2024-03-31', '12:29:00', '2024-03-31 16:29:00', '2024-03-31 16:29:00'),
(72, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 9<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 676767<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:14<br/>', 'id: 9<br/>nombre: JAIME<br/>paterno: BAUTISTA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676767<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:29:23<br/>', 'JUGADORES', '2024-03-31', '12:29:23', '2024-03-31 16:29:23', '2024-03-31 16:29:23'),
(73, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 11<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 656556<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:24<br/>', 'id: 11<br/>nombre: ROBERTO<br/>paterno: LINO<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 656556<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:29:40<br/>', 'JUGADORES', '2024-03-31', '12:29:40', '2024-03-31 16:29:40', '2024-03-31 16:29:40'),
(74, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 12<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 67676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:29<br/>', 'id: 12<br/>nombre: MARCELO<br/>paterno: SUAREZ<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 67676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:29:50<br/>', 'JUGADORES', '2024-03-31', '12:29:50', '2024-03-31 16:29:50', '2024-03-31 16:29:50'),
(75, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 10<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 65656<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:20<br/>', 'id: 10<br/>nombre: DANIEL<br/>paterno: FERNANDEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 65656<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:30:07<br/>', 'JUGADORES', '2024-03-31', '12:30:07', '2024-03-31 16:30:07', '2024-03-31 16:30:07'),
(76, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 13<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:34<br/>', 'id: 13<br/>nombre: PABLO<br/>paterno: VILLAROEL<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:30:27<br/>', 'JUGADORES', '2024-03-31', '12:30:27', '2024-03-31 16:30:27', '2024-03-31 16:30:27'),
(77, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 14<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 78777<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:38<br/>', 'id: 14<br/>nombre: MOISES<br/>paterno: VILLAMIL<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 78777<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:30:40<br/>', 'JUGADORES', '2024-03-31', '12:30:40', '2024-03-31 16:30:40', '2024-03-31 16:30:40'),
(78, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 15<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 76655<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:43<br/>', 'id: 15<br/>nombre: GABRIEL<br/>paterno: SAUCEDO<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 76655<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:30:59<br/>', 'JUGADORES', '2024-03-31', '12:30:59', '2024-03-31 16:30:59', '2024-03-31 16:30:59'),
(79, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 16<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 66555<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:51<br/>', 'id: 16<br/>nombre: RODRIGO<br/>paterno: GONZALES<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 66555<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:10<br/>', 'JUGADORES', '2024-03-31', '12:31:10', '2024-03-31 16:31:10', '2024-03-31 16:31:10'),
(80, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 17<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 7666776<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:28:56<br/>', 'id: 17<br/>nombre: BRUNO<br/>paterno: MARQUEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 7666776<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:22<br/>', 'JUGADORES', '2024-03-31', '12:31:22', '2024-03-31 16:31:22', '2024-03-31 16:31:22'),
(81, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 18<br/>nombre: MARCOS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:29:00<br/>', 'id: 18<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'JUGADORES', '2024-03-31', '12:31:36', '2024-03-31 16:31:36', '2024-03-31 16:31:36'),
(82, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 19<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'id: 19<br/>nombre: KEVIN<br/>paterno: CUELLAR<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 6766755<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:33:08<br/>', 'JUGADORES', '2024-03-31', '12:33:08', '2024-03-31 16:33:08', '2024-03-31 16:33:08'),
(83, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 20<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'id: 20<br/>nombre: GARRY<br/>paterno: RAMAYO<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676633<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:33:28<br/>', 'JUGADORES', '2024-03-31', '12:33:28', '2024-03-31 16:33:28', '2024-03-31 16:33:28'),
(84, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 21<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'id: 21<br/>nombre: LUIS ALFONSO<br/>paterno: GONZALES<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676622<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:33:43<br/>', 'JUGADORES', '2024-03-31', '12:33:43', '2024-03-31 16:33:43', '2024-03-31 16:33:43'),
(85, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 22<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'id: 22<br/>nombre: JAIRO<br/>paterno: QUINTEROS<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 556676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:33:59<br/>', 'JUGADORES', '2024-03-31', '12:33:59', '2024-03-31 16:33:59', '2024-03-31 16:33:59'),
(86, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 23<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'id: 23<br/>nombre: LEONEL<br/>paterno: MARTINEZ<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 555444<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:34:11<br/>', 'JUGADORES', '2024-03-31', '12:34:11', '2024-03-31 16:34:11', '2024-03-31 16:34:11'),
(87, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 24<br/>nombre: JUAN<br/>paterno: CARTAJENA<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 676676<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:31:36<br/>', 'id: 24<br/>nombre: JOSE<br/>paterno: SAGREDO<br/>materno: <br/>nacionalidad: BOLIVIANO<br/>ci: 55666<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:34:27<br/>', 'JUGADORES', '2024-03-31', '12:34:27', '2024-03-31 16:34:27', '2024-03-31 16:34:27'),
(88, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 2<br/>equipo_id: 1<br/>jugador_id: 2<br/>nro_polera: 3<br/>fecha_fichaje: 2024-03-02<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:35:23<br/>updated_at: 2024-03-31 12:35:23<br/>', NULL, 'FICHAJES', '2024-03-31', '12:35:23', '2024-03-31 16:35:23', '2024-03-31 16:35:23'),
(89, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 3<br/>equipo_id: 1<br/>jugador_id: 3<br/>nro_polera: 7<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:36:23<br/>updated_at: 2024-03-31 12:36:23<br/>', NULL, 'FICHAJES', '2024-03-31', '12:36:23', '2024-03-31 16:36:23', '2024-03-31 16:36:23'),
(90, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 4<br/>equipo_id: 1<br/>jugador_id: 4<br/>nro_polera: 5<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:37:02<br/>updated_at: 2024-03-31 12:37:02<br/>', NULL, 'FICHAJES', '2024-03-31', '12:37:02', '2024-03-31 16:37:02', '2024-03-31 16:37:02'),
(91, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 5<br/>equipo_id: 1<br/>jugador_id: 5<br/>nro_polera: 10<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:37:19<br/>updated_at: 2024-03-31 12:37:19<br/>', NULL, 'FICHAJES', '2024-03-31', '12:37:19', '2024-03-31 16:37:19', '2024-03-31 16:37:19'),
(92, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 6<br/>equipo_id: 1<br/>jugador_id: 6<br/>nro_polera: 12<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:37:35<br/>updated_at: 2024-03-31 12:37:35<br/>', NULL, 'FICHAJES', '2024-03-31', '12:37:35', '2024-03-31 16:37:35', '2024-03-31 16:37:35'),
(93, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 7<br/>equipo_id: 1<br/>jugador_id: 7<br/>nro_polera: 13<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:37:49<br/>updated_at: 2024-03-31 12:37:49<br/>', NULL, 'FICHAJES', '2024-03-31', '12:37:49', '2024-03-31 16:37:49', '2024-03-31 16:37:49'),
(94, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 8<br/>equipo_id: 1<br/>jugador_id: 8<br/>nro_polera: 16<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:38:00<br/>updated_at: 2024-03-31 12:38:00<br/>', NULL, 'FICHAJES', '2024-03-31', '12:38:00', '2024-03-31 16:38:00', '2024-03-31 16:38:00'),
(95, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 9<br/>equipo_id: 1<br/>jugador_id: 9<br/>nro_polera: 13<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:38:19<br/>updated_at: 2024-03-31 12:38:19<br/>', NULL, 'FICHAJES', '2024-03-31', '12:38:19', '2024-03-31 16:38:19', '2024-03-31 16:38:19'),
(96, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 10<br/>equipo_id: 1<br/>jugador_id: 10<br/>nro_polera: 20<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:38:34<br/>updated_at: 2024-03-31 12:38:34<br/>', NULL, 'FICHAJES', '2024-03-31', '12:38:34', '2024-03-31 16:38:34', '2024-03-31 16:38:34');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(97, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 11<br/>equipo_id: 1<br/>jugador_id: 11<br/>nro_polera: 15<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:38:44<br/>updated_at: 2024-03-31 12:38:44<br/>', NULL, 'FICHAJES', '2024-03-31', '12:38:44', '2024-03-31 16:38:44', '2024-03-31 16:38:44'),
(98, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 12<br/>equipo_id: 1<br/>jugador_id: 12<br/>nro_polera: 24<br/>fecha_fichaje: 2024-01-09<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:38:56<br/>updated_at: 2024-03-31 12:38:56<br/>', NULL, 'FICHAJES', '2024-03-31', '12:38:56', '2024-03-31 16:38:56', '2024-03-31 16:38:56'),
(99, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 13<br/>equipo_id: 2<br/>jugador_id: 13<br/>nro_polera: 2<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:39:51<br/>updated_at: 2024-03-31 12:39:51<br/>', NULL, 'FICHAJES', '2024-03-31', '12:39:51', '2024-03-31 16:39:51', '2024-03-31 16:39:51'),
(100, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 14<br/>equipo_id: 2<br/>jugador_id: 14<br/>nro_polera: 3<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:40:10<br/>updated_at: 2024-03-31 12:40:10<br/>', NULL, 'FICHAJES', '2024-03-31', '12:40:10', '2024-03-31 16:40:10', '2024-03-31 16:40:10'),
(101, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 15<br/>equipo_id: 2<br/>jugador_id: 15<br/>nro_polera: 11<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:40:20<br/>updated_at: 2024-03-31 12:40:20<br/>', NULL, 'FICHAJES', '2024-03-31', '12:40:20', '2024-03-31 16:40:20', '2024-03-31 16:40:20'),
(102, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 16<br/>equipo_id: 2<br/>jugador_id: 16<br/>nro_polera: 8<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:40:32<br/>updated_at: 2024-03-31 12:40:32<br/>', NULL, 'FICHAJES', '2024-03-31', '12:40:32', '2024-03-31 16:40:32', '2024-03-31 16:40:32'),
(103, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 17<br/>equipo_id: 2<br/>jugador_id: 17<br/>nro_polera: 10<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:40:41<br/>updated_at: 2024-03-31 12:40:41<br/>', NULL, 'FICHAJES', '2024-03-31', '12:40:41', '2024-03-31 16:40:41', '2024-03-31 16:40:41'),
(104, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 18<br/>equipo_id: 2<br/>jugador_id: 18<br/>nro_polera: 4<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:40:57<br/>updated_at: 2024-03-31 12:40:57<br/>', NULL, 'FICHAJES', '2024-03-31', '12:40:57', '2024-03-31 16:40:57', '2024-03-31 16:40:57'),
(105, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 19<br/>equipo_id: 2<br/>jugador_id: 19<br/>nro_polera: 12<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:41:09<br/>updated_at: 2024-03-31 12:41:09<br/>', NULL, 'FICHAJES', '2024-03-31', '12:41:09', '2024-03-31 16:41:09', '2024-03-31 16:41:09'),
(106, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 20<br/>equipo_id: 2<br/>jugador_id: 20<br/>nro_polera: 13<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:41:28<br/>updated_at: 2024-03-31 12:41:28<br/>', NULL, 'FICHAJES', '2024-03-31', '12:41:28', '2024-03-31 16:41:28', '2024-03-31 16:41:28'),
(107, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 21<br/>equipo_id: 2<br/>jugador_id: 21<br/>nro_polera: 14<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:41:41<br/>updated_at: 2024-03-31 12:41:41<br/>', NULL, 'FICHAJES', '2024-03-31', '12:41:41', '2024-03-31 16:41:41', '2024-03-31 16:41:41'),
(108, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 22<br/>equipo_id: 2<br/>jugador_id: 22<br/>nro_polera: 16<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:41:52<br/>updated_at: 2024-03-31 12:41:52<br/>', NULL, 'FICHAJES', '2024-03-31', '12:41:52', '2024-03-31 16:41:52', '2024-03-31 16:41:52'),
(109, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 23<br/>equipo_id: 2<br/>jugador_id: 23<br/>nro_polera: 23<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:42:03<br/>updated_at: 2024-03-31 12:42:03<br/>', NULL, 'FICHAJES', '2024-03-31', '12:42:03', '2024-03-31 16:42:03', '2024-03-31 16:42:03'),
(110, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 24<br/>equipo_id: 2<br/>jugador_id: 24<br/>nro_polera: 18<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:42:14<br/>updated_at: 2024-03-31 12:42:14<br/>', NULL, 'FICHAJES', '2024-03-31', '12:42:14', '2024-03-31 16:42:14', '2024-03-31 16:42:14'),
(111, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN FICHAJE', 'id: 13<br/>equipo_id: 2<br/>jugador_id: 13<br/>nro_polera: 2<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:39:51<br/>updated_at: 2024-03-31 12:39:51<br/>', 'id: 13<br/>equipo_id: 2<br/>jugador_id: 13<br/>nro_polera: 1<br/>fecha_fichaje: 2024-01-01<br/>contrato_hasta: 2024-12-31<br/>descripcion: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:39:51<br/>updated_at: 2024-03-31 12:42:19<br/>', 'FICHAJES', '2024-03-31', '12:42:19', '2024-03-31 16:42:19', '2024-03-31 16:42:19'),
(112, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 13<br/>nombre: PABLO<br/>paterno: VILLAROEL<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: DELANTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:30:27<br/>', 'id: 13<br/>nombre: PABLO<br/>paterno: VILLAROEL<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: PORTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:42:35<br/>', 'JUGADORES', '2024-03-31', '12:42:35', '2024-03-31 16:42:35', '2024-03-31 16:42:35'),
(113, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN JUGADOR', 'id: 13<br/>nombre: PABLO<br/>paterno: VILLAROEL<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: PORTERO<br/>altura: 1,76<br/>peso: 78<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:42:35<br/>', 'id: 13<br/>nombre: PABLO<br/>paterno: VILLAROEL<br/>materno: MAMANI<br/>nacionalidad: BOLIVIANO<br/>ci: 77878<br/>fecha_nac: 2000-03-03<br/>posicion: PORTERO<br/>altura: 1,93<br/>peso: 88<br/>pie: DIESTRO<br/>valoracion_actual: 9000<br/>correo: <br/>fono: <br/>dir: <br/>foto: <br/>nro_convocado: 5<br/>nro_alineaciones: 3<br/>minutos_jugados: 300<br/>nro_goles: 30<br/>nro_asistencias: 14<br/>nro_gol_penalti: 3<br/>nro_penalti_cometido: 2<br/>nro_tiro_palo: 1<br/>nro_sustitucion: 2<br/>nro_tarjeta_amarilla: 1<br/>nro_tarjeta_roja: 1<br/>nro_lesiones: 1<br/>puntuacion_valorada: 80<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 12:22:09<br/>updated_at: 2024-03-31 12:42:54<br/>', 'JUGADORES', '2024-03-31', '12:42:54', '2024-03-31 16:42:54', '2024-03-31 16:42:54'),
(114, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN FICHAJE', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', NULL, 'FICHAJES', '2024-03-31', '13:20:12', '2024-03-31 17:20:12', '2024-03-31 17:20:12'),
(115, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:25:02', '2024-03-31 17:25:02', '2024-03-31 17:25:02'),
(116, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:25:42', '2024-03-31 17:25:42', '2024-03-31 17:25:42'),
(117, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:26:03', '2024-03-31 17:26:03', '2024-03-31 17:26:03'),
(118, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:27:31', '2024-03-31 17:27:31', '2024-03-31 17:27:31'),
(119, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:27:44', '2024-03-31 17:27:44', '2024-03-31 17:27:44'),
(120, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:28:33', '2024-03-31 17:28:33', '2024-03-31 17:28:33'),
(121, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:31:18', '2024-03-31 17:31:18', '2024-03-31 17:31:18'),
(122, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:35:03', '2024-03-31 17:35:03', '2024-03-31 17:35:03'),
(123, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:36:42', '2024-03-31 17:36:42', '2024-03-31 17:36:42'),
(124, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:37:26', '2024-03-31 17:37:26', '2024-03-31 17:37:26'),
(125, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:37:39', '2024-03-31 17:37:39', '2024-03-31 17:37:39'),
(126, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:38:17', '2024-03-31 17:38:17', '2024-03-31 17:38:17'),
(127, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:38:41', '2024-03-31 17:38:41', '2024-03-31 17:38:41'),
(128, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:38:59', '2024-03-31 17:38:59', '2024-03-31 17:38:59'),
(129, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ALINEACIÓN DE EQUIPO', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'id: 1<br/>equipo_id: 1<br/>nombre: ALINEACION #1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 13:20:12<br/>updated_at: 2024-03-31 13:20:12<br/>', 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '13:39:35', '2024-03-31 17:39:35', '2024-03-31 17:39:35'),
(130, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ALINEACIÓN DE EQUIPO', 'id: 2<br/>equipo_id: 2<br/>nombre: ALINEACION #1 EQUIPO #2<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 18:54:16<br/>updated_at: 2024-03-31 18:54:16<br/>', NULL, 'ALINEACIÓN DE EQUIPOS', '2024-03-31', '18:54:16', '2024-03-31 22:54:16', '2024-03-31 22:54:16'),
(131, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:09:45<br/>', NULL, 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:09:45', '2024-04-01 00:09:45', '2024-04-01 00:09:45'),
(132, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:09:45<br/>', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:19:15<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:19:15', '2024-04-01 00:19:15', '2024-04-01 00:19:15'),
(133, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:19:15<br/>', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:20:28<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:20:28', '2024-04-01 00:20:28', '2024-04-01 00:20:28'),
(134, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:20:28<br/>', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: <br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:30:29<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:30:29', '2024-04-01 00:30:29', '2024-04-01 00:30:29'),
(135, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: <br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:30:29<br/>', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:31:08<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:31:08', '2024-04-01 00:31:08', '2024-04-01 00:31:08'),
(136, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:31:08<br/>', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: 3<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:31:20<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:31:20', '2024-04-01 00:31:20', '2024-04-01 00:31:20'),
(137, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 1<br/>alineacion_local_id: 1<br/>visitante_id: 2<br/>alineacion_visitante_id: 2<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: 3<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:09:45<br/>updated_at: 2024-03-31 20:31:20<br/>', NULL, 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:32:34', '2024-04-01 00:32:34', '2024-04-01 00:32:34'),
(138, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-03-31 20:33:59<br/>', NULL, 'PREDICCIÓN DE PARTIDOS', '2024-03-31', '20:33:59', '2024-04-01 00:33:59', '2024-04-01 00:33:59'),
(139, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: <br/>g_visitante: <br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-03-31 20:33:59<br/>', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 2<br/>g_local: 3<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:09<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-04-01', '10:13:09', '2024-04-01 14:13:09', '2024-04-01 14:13:09'),
(140, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 2<br/>g_local: 3<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:09<br/>', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 1<br/>g_local: 1<br/>g_visitante: 3<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:21<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-04-01', '10:13:21', '2024-04-01 14:13:21', '2024-04-01 14:13:21'),
(141, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 1<br/>g_local: 1<br/>g_visitante: 3<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:21<br/>', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: 1<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:33<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-04-01', '10:13:33', '2024-04-01 14:13:33', '2024-04-01 14:13:33'),
(142, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: <br/>g_local: 1<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:33<br/>', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 2<br/>g_local: 2<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:53<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-04-01', '10:13:53', '2024-04-01 14:13:53', '2024-04-01 14:13:53'),
(143, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA TABLA DE POSICION', 'id: 2<br/>equipo_id: 2<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 7<br/>e: 13<br/>p: 0<br/>gf: 20<br/>gc: 20<br/>dg: 0<br/>pts: 34<br/>fecha_registro: 2024-04-01<br/>created_at: 2024-04-01 11:36:43<br/>updated_at: 2024-04-01 11:36:43<br/>', NULL, 'TABLA DE POSICIONES', '2024-04-01', '11:36:43', '2024-04-01 15:36:43', '2024-04-01 15:36:43'),
(144, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA TABLA DE POSICION', 'id: 2<br/>equipo_id: 2<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 7<br/>e: 13<br/>p: 0<br/>gf: 20<br/>gc: 20<br/>dg: 0<br/>pts: 34<br/>fecha_registro: 2024-04-01<br/>created_at: 2024-04-01 11:36:43<br/>updated_at: 2024-04-01 11:36:43<br/>', 'id: 2<br/>equipo_id: 2<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 7<br/>e: 13<br/>p: 0<br/>gf: 20<br/>gc: 20<br/>dg: 0<br/>pts: 35<br/>fecha_registro: 2024-04-01<br/>created_at: 2024-04-01 11:36:43<br/>updated_at: 2024-04-01 11:53:05<br/>', 'TABLA DE POSICIONES', '2024-04-01', '11:53:05', '2024-04-01 15:53:05', '2024-04-01 15:53:05'),
(145, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA TABLA DE POSICION', 'id: 2<br/>equipo_id: 2<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 7<br/>e: 13<br/>p: 0<br/>gf: 20<br/>gc: 20<br/>dg: 0<br/>pts: 35<br/>fecha_registro: 2024-04-01<br/>created_at: 2024-04-01 11:36:43<br/>updated_at: 2024-04-01 11:53:05<br/>', 'id: 2<br/>equipo_id: 2<br/>tipo_torneo: APERTURA<br/>temporada: 2023<br/>pj: 20<br/>g: 7<br/>e: 13<br/>p: 0<br/>gf: 20<br/>gc: 20<br/>dg: 0<br/>pts: 34<br/>fecha_registro: 2024-04-01<br/>created_at: 2024-04-01 11:36:43<br/>updated_at: 2024-04-01 11:53:16<br/>', 'TABLA DE POSICIONES', '2024-04-01', '11:53:16', '2024-04-01 15:53:16', '2024-04-01 15:53:16'),
(146, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 3<br/>usuario: MMAMANI<br/>password: $2y$12$J.21aLLDSTyAyqFR/4Mz2u.GvMke0EVGfzP/XwaInHI1BeUeQSihm<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 3333<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 77777<br/>tipo: ANALISTA DE VIDEO<br/>foto: 1711987237_MMAMANI.png<br/>acceso: 1<br/>fecha_registro: 2024-04-01 00:00:00<br/>created_at: 2024-04-01 12:00:37<br/>updated_at: 2024-04-01 12:00:37<br/>', NULL, 'USUARIOS', '2024-04-01', '12:00:37', '2024-04-01 16:00:37', '2024-04-01 16:00:37'),
(147, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 4<br/>usuario: MGONZALES<br/>password: $2y$12$3Eno6A.rM5f3k1zcgBvxYOFOle6NIOl/tH6CZL/HJGm/seuIk5yMW<br/>nombre: MARCOS<br/>paterno: GONZALES<br/>materno: <br/>ci: 4444<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 777777<br/>tipo: ANALISTA DEPORTIVO<br/>foto: <br/>acceso: 1<br/>fecha_registro: 2024-04-01 00:00:00<br/>created_at: 2024-04-01 12:00:53<br/>updated_at: 2024-04-01 12:00:54<br/>', NULL, 'USUARIOS', '2024-04-01', '12:00:54', '2024-04-01 16:00:54', '2024-04-01 16:00:54'),
(148, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA PREDICCIÓN DE PARTIDO', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 2<br/>g_local: 2<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:53<br/>', 'id: 1<br/>local_id: 2<br/>alineacion_local_id: 2<br/>visitante_id: 1<br/>alineacion_visitante_id: 1<br/>p_ganador_id: 2<br/>ganador_id: 2<br/>g_local: 2<br/>g_visitante: 1<br/>fecha_registro: 2024-03-31<br/>created_at: 2024-03-31 20:33:59<br/>updated_at: 2024-04-01 10:13:53<br/>', 'PREDICCIÓN DE PARTIDOS', '2024-04-01', '12:38:48', '2024-04-01 16:38:48', '2024-04-01 16:38:48');

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
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

--
-- Volcado de datos para la tabla `jugadors`
--

INSERT INTO `jugadors` (`id`, `nombre`, `paterno`, `materno`, `nacionalidad`, `ci`, `fecha_nac`, `posicion`, `altura`, `peso`, `pie`, `valoracion_actual`, `correo`, `fono`, `dir`, `foto`, `nro_convocado`, `nro_alineaciones`, `minutos_jugados`, `nro_goles`, `nro_asistencias`, `nro_gol_penalti`, `nro_penalti_cometido`, `nro_tiro_palo`, `nro_sustitucion`, `nro_tarjeta_amarilla`, `nro_tarjeta_roja`, `nro_lesiones`, `puntuacion_valorada`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'CARLOS', 'CORTEZ', '', 'BOLIVIANO', '322323', '2001-01-01', 'PORTERO', '1.98 M', '97 KG', 'DERECHO', '100000', 'CARLOS@GMAIL.COM', '7777777', 'LOS OLIVOS', '1711728620_1.png', 2, 2, 300, 0, 0, 0, 0, 0, 0, 2, 0, 0, 91, '2024-03-29', '2024-03-29 16:10:20', '2024-03-29 16:32:58'),
(2, 'MARCOS', 'MAMANI', 'MAMANI', 'BOLIVIANO', '54454', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:26:37'),
(3, 'JUAN', 'CHOQUE', 'MAMANI', 'BOLIVIANO', '4444322', '2000-03-03', 'DELANTERO', '1,76', '74', 'DERECHO', '9000', '', '', '', NULL, 2, 3, 150, 30, 14, 3, 2, 1, 2, 1, 1, 1, 50, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:23:31'),
(4, 'ALEX', 'CAMPOS', '', 'BOLIVIANO', '655656', '2000-03-03', 'MEDIO CAMPO', '1,8', '81', 'IZQUIERDO', '9000', '', '', '', NULL, 6, 3, 300, 20, 14, 3, 2, 1, 2, 1, 1, 1, 65, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:26:45'),
(5, 'LEONEL', 'CARVAJAL', '', 'BOLIVIANO', '65565', '2000-03-03', 'DEFENSA', '1,9', '92', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 65, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:27:43'),
(6, 'LUIS', 'JAUREGUI', '', 'BOLIVIANO', '43433', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '10000', '', '', '', NULL, 10, 7, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 93, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:27:53'),
(7, 'GUILLERMO', 'VISCARRA', '', 'BOLIVIANO', '8777', '2000-03-03', 'VOLANTE DERECHO', '1,77', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:28:01'),
(8, 'JOSE', 'SAUCEDO', 'MAMANI', 'BOLIVIANO', '454454', '2000-03-03', 'DEFENSA CENTRAL', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:28:08'),
(9, 'JAIME', 'BAUTISTA', '', 'BOLIVIANO', '676767', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:29:23'),
(10, 'DANIEL', 'FERNANDEZ', '', 'BOLIVIANO', '65656', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:30:07'),
(11, 'ROBERTO', 'LINO', '', 'BOLIVIANO', '656556', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:29:40'),
(12, 'MARCELO', 'SUAREZ', 'MAMANI', 'BOLIVIANO', '67676', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:29:50'),
(13, 'PABLO', 'VILLAROEL', 'MAMANI', 'BOLIVIANO', '77878', '2000-03-03', 'PORTERO', '1,93', '88', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:42:54'),
(14, 'MOISES', 'VILLAMIL', '', 'BOLIVIANO', '78777', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:30:40'),
(15, 'GABRIEL', 'SAUCEDO', '', 'BOLIVIANO', '76655', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:30:59'),
(16, 'RODRIGO', 'GONZALES', '', 'BOLIVIANO', '66555', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:31:10'),
(17, 'BRUNO', 'MARQUEZ', '', 'BOLIVIANO', '7666776', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:31:22'),
(18, 'JUAN', 'CARTAJENA', '', 'BOLIVIANO', '676676', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:31:36'),
(19, 'KEVIN', 'CUELLAR', '', 'BOLIVIANO', '6766755', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:33:08'),
(20, 'GARRY', 'RAMAYO', '', 'BOLIVIANO', '676633', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:33:28'),
(21, 'LUIS ALFONSO', 'GONZALES', '', 'BOLIVIANO', '676622', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:33:43'),
(22, 'JAIRO', 'QUINTEROS', '', 'BOLIVIANO', '556676', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:33:59'),
(23, 'LEONEL', 'MARTINEZ', '', 'BOLIVIANO', '555444', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:34:11'),
(24, 'JOSE', 'SAGREDO', '', 'BOLIVIANO', '55666', '2000-03-03', 'DELANTERO', '1,76', '78', 'DIESTRO', '9000', '', '', '', NULL, 5, 3, 300, 30, 14, 3, 2, 1, 2, 1, 1, 1, 80, '2024-03-31', '2024-03-31 16:22:09', '2024-03-31 16:34:27');

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

--
-- Volcado de datos para la tabla `jugador_titulos`
--

INSERT INTO `jugador_titulos` (`id`, `jugador_id`, `titulo`, `anio`, `fecha`, `descripcion`, `tipo`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'TITULO #1', '2013', '2013-01-01', '', 'NACIONAL', '2024-03-29', '2024-03-29 16:50:19', '2024-03-29 16:50:19');

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
  `p_ganador_id` bigint UNSIGNED DEFAULT NULL,
  `ganador_id` bigint UNSIGNED DEFAULT NULL,
  `g_local` int DEFAULT NULL,
  `g_visitante` int DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `prediccion_partidos`
--

INSERT INTO `prediccion_partidos` (`id`, `local_id`, `alineacion_local_id`, `visitante_id`, `alineacion_visitante_id`, `p_ganador_id`, `ganador_id`, `g_local`, `g_visitante`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 1, 1, 2, 2, 2, 1, '2024-03-31', '2024-04-01 00:33:59', '2024-04-01 14:13:53');

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

--
-- Volcado de datos para la tabla `tabla_posicions`
--

INSERT INTO `tabla_posicions` (`id`, `equipo_id`, `tipo_torneo`, `temporada`, `pj`, `g`, `e`, `p`, `gf`, `gc`, `dg`, `pts`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'APERTURA', 2023, 20, 10, 5, 5, 20, 13, 7, 35, '2024-03-29', '2024-03-29 21:23:17', '2024-03-29 21:23:52'),
(2, 2, 'APERTURA', 2023, 20, 7, 13, 0, 20, 20, 0, 34, '2024-04-01', '2024-04-01 15:36:43', '2024-04-01 15:53:16');

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
(2, 'JPERES', '$2y$12$bi41OPTk65mY/ifmWga7J.1RERadX6tXsXbKh5mzytmMk2/g29pmu', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', 'LOS OLIVOS', 'JUAN@GMAIL.COM', '7777777', 'PERIODISTA', '1710777252_JPERES.jpg', 1, '2024-03-18', '2024-03-18 15:54:12', '2024-03-18 15:54:54'),
(3, 'MMAMANI', '$2y$12$J.21aLLDSTyAyqFR/4Mz2u.GvMke0EVGfzP/XwaInHI1BeUeQSihm', 'MARIA', 'MAMANI', 'MAMANI', '3333', 'LP', 'LOS OLIVOS', '', '77777', 'ANALISTA DE VIDEO', '1711987237_MMAMANI.png', 1, '2024-04-01', '2024-04-01 16:00:37', '2024-04-01 16:00:37'),
(4, 'MGONZALES', '$2y$12$3Eno6A.rM5f3k1zcgBvxYOFOle6NIOl/tH6CZL/HJGm/seuIk5yMW', 'MARCOS', 'GONZALES', '', '4444', 'LP', 'LOS OLIVOS', '', '777777', 'ANALISTA DEPORTIVO', NULL, 1, '2024-04-01', '2024-04-01 16:00:53', '2024-04-01 16:00:54');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alineacion_detalles`
--
ALTER TABLE `alineacion_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alineacion_detalles_alineacion_equipo_id_foreign` (`alineacion_equipo_id`),
  ADD KEY `alineacion_detalles_jugador_id_foreign` (`jugador_id`),
  ADD KEY `fichaje_id` (`fichaje_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `local_id` (`local_id`),
  ADD KEY `alineacion_local_id` (`alineacion_local_id`),
  ADD KEY `visitante_id` (`visitante_id`),
  ADD KEY `alineacion_visitante_id` (`alineacion_visitante_id`),
  ADD KEY `p_ganador_id` (`p_ganador_id`),
  ADD KEY `ganador_id` (`ganador_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `alineacion_equipos`
--
ALTER TABLE `alineacion_equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `equipo_titulos`
--
ALTER TABLE `equipo_titulos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `fichajes`
--
ALTER TABLE `fichajes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT de la tabla `institucions`
--
ALTER TABLE `institucions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `jugadors`
--
ALTER TABLE `jugadors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `jugador_titulos`
--
ALTER TABLE `jugador_titulos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tabla_posicions`
--
ALTER TABLE `tabla_posicions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alineacion_detalles`
--
ALTER TABLE `alineacion_detalles`
  ADD CONSTRAINT `alineacion_detalles_alineacion_equipo_id_foreign` FOREIGN KEY (`alineacion_equipo_id`) REFERENCES `alineacion_equipos` (`id`),
  ADD CONSTRAINT `alineacion_detalles_ibfk_1` FOREIGN KEY (`fichaje_id`) REFERENCES `fichajes` (`id`),
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
-- Filtros para la tabla `prediccion_partidos`
--
ALTER TABLE `prediccion_partidos`
  ADD CONSTRAINT `prediccion_partidos_ibfk_1` FOREIGN KEY (`local_id`) REFERENCES `equipos` (`id`),
  ADD CONSTRAINT `prediccion_partidos_ibfk_2` FOREIGN KEY (`alineacion_local_id`) REFERENCES `alineacion_equipos` (`id`),
  ADD CONSTRAINT `prediccion_partidos_ibfk_3` FOREIGN KEY (`visitante_id`) REFERENCES `equipos` (`id`),
  ADD CONSTRAINT `prediccion_partidos_ibfk_4` FOREIGN KEY (`alineacion_visitante_id`) REFERENCES `alineacion_equipos` (`id`),
  ADD CONSTRAINT `prediccion_partidos_ibfk_5` FOREIGN KEY (`p_ganador_id`) REFERENCES `equipos` (`id`),
  ADD CONSTRAINT `prediccion_partidos_ibfk_6` FOREIGN KEY (`ganador_id`) REFERENCES `equipos` (`id`);

--
-- Filtros para la tabla `tabla_posicions`
--
ALTER TABLE `tabla_posicions`
  ADD CONSTRAINT `tabla_posicions_equipo_id_foreign` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
