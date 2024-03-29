-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 29-03-2024 a las 21:25:39
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
(1, 1, 1, 1, '2024-02-01', '2024-12-31', 'DESC. FICHAJE #1', '2024-03-29', '2024-03-29 17:25:14', '2024-03-29 17:25:14');

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
(48, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA TABLA DE POSICION', 'id: 2<br/>equipo_id: 1<br/>tipo_torneo: CLAUSURA<br/>temporada: 2023<br/>pj: 20<br/>g: 2<br/>e: 2<br/>p: 2<br/>gf: 2<br/>gc: 2<br/>dg: 2<br/>pts: 2<br/>fecha_registro: 2024-03-29<br/>created_at: 2024-03-29 17:24:55<br/>updated_at: 2024-03-29 17:24:55<br/>', NULL, 'TABLA DE POSICIONES', '2024-03-29', '17:24:58', '2024-03-29 21:24:58', '2024-03-29 21:24:58');

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
(1, 'CARLOS', 'CORTEZ', '', 'BOLIVIANO', '322323', '2001-01-01', 'PORTERO', '1.98 M', '97 KG', 'DERECHO', '100000', 'CARLOS@GMAIL.COM', '7777777', 'LOS OLIVOS', '1711728620_1.png', 2, 2, 300, 0, 0, 0, 0, 0, 0, 2, 0, 0, 91, '2024-03-29', '2024-03-29 16:10:20', '2024-03-29 16:32:58');

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

--
-- Volcado de datos para la tabla `tabla_posicions`
--

INSERT INTO `tabla_posicions` (`id`, `equipo_id`, `tipo_torneo`, `temporada`, `pj`, `g`, `e`, `p`, `gf`, `gc`, `dg`, `pts`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'APERTURA', 2023, 20, 10, 5, 5, 20, 13, 7, 35, '2024-03-29', '2024-03-29 21:23:17', '2024-03-29 21:23:52');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `institucions`
--
ALTER TABLE `institucions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `jugadors`
--
ALTER TABLE `jugadors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tabla_posicions`
--
ALTER TABLE `tabla_posicions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
