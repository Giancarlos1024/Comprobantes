-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-10-2024 a las 11:24:11
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `contaxmvcfin`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conceptooperacion`
--

CREATE TABLE `conceptooperacion` (
  `idAsiento` int(11) NOT NULL,
  `numeroasiento` varchar(15) NOT NULL,
  `fechaAsiento` date NOT NULL,
  `conceptoOperacion` varchar(500) NOT NULL,
  `tipocomprobante` varchar(45) NOT NULL,
  `estadotransaccion` int(11) NOT NULL,
  `idUsuarios` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `conceptooperacion`
--

INSERT INTO `conceptooperacion` (`idAsiento`, `numeroasiento`, `fechaAsiento`, `conceptoOperacion`, `tipocomprobante`, `estadotransaccion`, `idUsuarios`, `status`) VALUES
(3, '10240001', '2024-10-24', 'Venta de productos Lacteos', 'INGRESO', 1, 0, 1),
(4, '10240002', '2024-10-25', 'Compra de Productos Lacteos', 'EGRESO', 1, 0, 1),
(5, '10240003', '2024-10-26', 'Compra a credito Productos Varios', 'TRASPASO', 1, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuraempresa`
--

CREATE TABLE `configuraempresa` (
  `idconfigura` int(11) NOT NULL,
  `nit` int(11) NOT NULL,
  `razonsocial` varchar(120) NOT NULL,
  `nombrereplegal` varchar(120) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `fechainiciofiscal` date NOT NULL DEFAULT current_timestamp(),
  `fechafinfiscal` date NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuraempresa`
--

INSERT INTO `configuraempresa` (`idconfigura`, `nit`, `razonsocial`, `nombrereplegal`, `direccion`, `fechainiciofiscal`, `fechafinfiscal`, `status`) VALUES
(1, 102543260, 'CONTAX S.R.L.', 'Mariano Vicente Cuellar', 'Av. Ayacucho Nro. 4785', '2024-01-01', '2024-12-31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contaxmvcfin`
--

CREATE TABLE `contaxmvcfin` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `importe` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dblicomprasiva`
--

CREATE TABLE `dblicomprasiva` (
  `iddbComprasiva` int(11) NOT NULL,
  `nro` int(11) NOT NULL,
  `especificacion` tinyint(2) NOT NULL DEFAULT 1,
  `ciNit` int(11) NOT NULL,
  `razonsocial` varchar(255) NOT NULL,
  `codautorizacion` varchar(100) NOT NULL,
  `nrofactura` bigint(20) NOT NULL,
  `nroduidim` varchar(15) DEFAULT NULL,
  `fecha` date NOT NULL,
  `totalcompra` decimal(14,2) NOT NULL,
  `ice` decimal(14,2) DEFAULT NULL,
  `iehd` decimal(14,2) DEFAULT NULL,
  `ipj` decimal(14,2) DEFAULT NULL,
  `tasas` decimal(14,2) DEFAULT NULL,
  `otronosujetoacf` decimal(14,2) DEFAULT NULL,
  `importesexentos` decimal(14,2) DEFAULT NULL,
  `importesgravadostasacero` decimal(14,2) DEFAULT NULL,
  `subtotal` decimal(14,2) DEFAULT NULL,
  `descuentosCompras` decimal(14,2) DEFAULT NULL,
  `importegifcard` decimal(14,2) DEFAULT NULL,
  `importebasecf` decimal(14,2) NOT NULL,
  `creditoFiscal` decimal(14,2) NOT NULL,
  `tipodecompra` tinyint(2) NOT NULL,
  `codigodecontrol` varchar(17) NOT NULL,
  `status` int(11) NOT NULL,
  `fechaderegistro` timestamp NULL DEFAULT current_timestamp(),
  `fechaactualizacion` timestamp NULL DEFAULT NULL,
  `idusuario` tinyint(4) NOT NULL,
  `idccontables` int(11) NOT NULL,
  `idlidiario` int(11) DEFAULT NULL,
  `idempresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dblicomprasiva`
--

INSERT INTO `dblicomprasiva` (`iddbComprasiva`, `nro`, `especificacion`, `ciNit`, `razonsocial`, `codautorizacion`, `nrofactura`, `nroduidim`, `fecha`, `totalcompra`, `ice`, `iehd`, `ipj`, `tasas`, `otronosujetoacf`, `importesexentos`, `importesgravadostasacero`, `subtotal`, `descuentosCompras`, `importegifcard`, `importebasecf`, `creditoFiscal`, `tipodecompra`, `codigodecontrol`, `status`, `fechaderegistro`, `fechaactualizacion`, `idusuario`, `idccontables`, `idlidiario`, `idempresa`) VALUES
(1, 1, 1, 1020255020, 'TELEFONICA CELULAR DE BOLIVIA S.A.', '45CF05BCD9788DFE4F6C79AAA0BEB6AE9D50D092E05992C343BB2FD74', 231195, '0', '2023-01-02', 212.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 212.00, 0.00, 0.00, 212.00, 27.56, 1, '7D-32-B7-0D-A6', 0, '2024-10-14 03:11:49', NULL, 0, 0, NULL, 0),
(2, 2, 1, 1023151020, 'IMPORTADORA CAMPERO S.R.L.', '4601BFD9CF775CB5289C3F2CFFA095DC55EDD967811A7209C22C2FD74', 6604, '0', '2023-01-04', 48198.56, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 48198.56, 1.00, 0.00, 47.00, 6.00, 1, '2D-29-C7-0D-FF', 0, '2024-10-14 03:50:06', NULL, 0, 0, NULL, 0),
(3, 3, 1, 1023069029, 'DISMAT S.R.L.', '46005030C222FE5F57090E1DDA174D24815F4B83291FFE5C536C2FD74', 4309, '0', '2023-01-05', 7121.60, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 7121.60, 0.00, 0.00, 7.00, 925.81, 1, '10-30-BB-D1-F4', 0, '2024-10-14 03:55:32', NULL, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dbliventasiva`
--

CREATE TABLE `dbliventasiva` (
  `iddbVentasiva` int(11) NOT NULL,
  `nro` int(11) NOT NULL,
  `especificacion` int(11) NOT NULL,
  `fechaFactura` date NOT NULL,
  `nrofactura` bigint(15) NOT NULL,
  `codigoautorizacion` varchar(100) NOT NULL,
  `ciNit` int(20) NOT NULL,
  `complemento` varchar(2) DEFAULT NULL,
  `razonsocial` varchar(240) NOT NULL,
  `totalVenta` decimal(14,2) NOT NULL,
  `ice` decimal(14,2) NOT NULL,
  `iehd` decimal(14,2) NOT NULL,
  `ipj` decimal(14,2) NOT NULL,
  `tasas` decimal(14,2) NOT NULL,
  `otronosujetoadf` decimal(14,2) NOT NULL,
  `ventasTasacero` decimal(14,2) NOT NULL,
  `subtotal` decimal(14,2) NOT NULL,
  `descuentosVentas` decimal(14,2) NOT NULL,
  `gifCardVentas` decimal(14,2) NOT NULL,
  `importeBasedf` decimal(14,2) NOT NULL,
  `debitoFiscal` decimal(14,2) NOT NULL,
  `estado` char(1) NOT NULL,
  `codigodecontrol` varchar(17) NOT NULL,
  `tipoVenta` int(1) NOT NULL,
  `idccontables` int(11) NOT NULL,
  `idlidiario` int(11) NOT NULL,
  `idempresa` int(11) NOT NULL,
  `fechaderegistro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechaactualizacion` timestamp NULL DEFAULT NULL,
  `idUsuario` tinyint(4) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dbliventasiva`
--

INSERT INTO `dbliventasiva` (`iddbVentasiva`, `nro`, `especificacion`, `fechaFactura`, `nrofactura`, `codigoautorizacion`, `ciNit`, `complemento`, `razonsocial`, `totalVenta`, `ice`, `iehd`, `ipj`, `tasas`, `otronosujetoadf`, `ventasTasacero`, `subtotal`, `descuentosVentas`, `gifCardVentas`, `importeBasedf`, `debitoFiscal`, `estado`, `codigodecontrol`, `tipoVenta`, `idccontables`, `idlidiario`, `idempresa`, `fechaderegistro`, `fechaactualizacion`, `idUsuario`, `status`) VALUES
(1, 1, 2, '2023-04-04', 3, '1B6BD30A7586BA682848B4A01D6EE4CC34B4D7113E04E6DFA36027FD74', 123715026, NULL, 'GOBIERNO AUTONOMO MUNICIPAL DE GOBIERNO AUTONOMO MUNICIPAL DE QUILLACOLLO', 403150.86, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 403150.86, 0.00, 0.00, 403150.86, 52409.61, 'V', '', 0, 0, 0, 0, '2024-10-14 14:56:18', NULL, 0, 1),
(2, 2, 2, '2023-05-04', 10, '1B6BD30A7586BB9C22BB7B280D0698E979C317BC2419FF8B56B498FD74', 122021029, NULL, 'GOBIERNO AUTONOMO MUNICIPAL DE VINTO', 278108.34, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 278108.34, 0.00, 0.00, 278108.34, 36154.08, 'V', '', 0, 0, 0, 0, '2024-10-14 15:27:51', NULL, 0, 1),
(3, 3, 2, '2023-08-18', 14, '1B6BD30A7586BF63AE16051CC3E4EA04E920D81DCC98E094D6662DFD74', 1023121025, NULL, 'UNIVERSIDAD ADVENTISTA DE BOLIVIA - UAB', 2940.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2940.00, 0.00, 0.00, 2940.00, 382.20, 'V', '', 0, 0, 0, 0, '2024-10-14 15:27:51', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `idEmpresa` int(11) NOT NULL,
  `ciNit` int(20) NOT NULL,
  `complemento` varchar(2) DEFAULT NULL,
  `razonsocial` varchar(240) NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechaactualizacion` timestamp NULL DEFAULT NULL,
  `IdUsuario` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licomprasiva`
--

CREATE TABLE `licomprasiva` (
  `idComprasiva` int(11) NOT NULL,
  `nro` int(11) NOT NULL,
  `especificacion` tinyint(2) NOT NULL DEFAULT 1,
  `codautorizacion` varchar(100) NOT NULL,
  `nrofactura` bigint(20) NOT NULL,
  `nroduidim` varchar(15) DEFAULT NULL,
  `fecha` date NOT NULL,
  `totalcompra` decimal(14,2) NOT NULL,
  `ice` decimal(14,2) DEFAULT NULL,
  `iehd` decimal(14,2) DEFAULT NULL,
  `ipj` decimal(14,2) DEFAULT NULL,
  `tasas` decimal(14,2) DEFAULT NULL,
  `otronosujetoacf` decimal(14,2) DEFAULT NULL,
  `importesexentos` decimal(14,2) DEFAULT NULL,
  `importesgravadostasacero` decimal(14,2) DEFAULT NULL,
  `subtotal` decimal(14,2) DEFAULT NULL,
  `descuentosCompras` decimal(14,2) DEFAULT NULL,
  `importegifcard` decimal(14,2) DEFAULT NULL,
  `importebasecf` decimal(14,2) NOT NULL,
  `creditoFiscal` decimal(14,2) NOT NULL,
  `tipodecompra` tinyint(2) NOT NULL,
  `codigodecontrol` varchar(17) NOT NULL,
  `fechaderegistro` timestamp NULL DEFAULT current_timestamp(),
  `fechaactualizacion` timestamp NULL DEFAULT NULL,
  `idusuario` tinyint(4) NOT NULL,
  `idccontables` int(11) NOT NULL,
  `idlidiario` int(11) DEFAULT NULL,
  `idempresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lidiario`
--

CREATE TABLE `lidiario` (
  `idLidiario` int(11) NOT NULL,
  `idAsiento` int(11) NOT NULL,
  `idCcontables` int(11) NOT NULL,
  `codigoCuenta` int(11) NOT NULL,
  `debe` decimal(20,2) DEFAULT NULL,
  `haber` decimal(20,2) DEFAULT NULL,
  `descripcion` longtext NOT NULL,
  `estado` int(11) NOT NULL,
  `fechacreacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaactualizado` datetime DEFAULT NULL,
  `idUsuario` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `liventasiva`
--

CREATE TABLE `liventasiva` (
  `idVentasiva` int(11) NOT NULL,
  `nro` int(11) NOT NULL,
  `especificacion` int(11) NOT NULL,
  `fechaFactura` date NOT NULL,
  `nrofactura` bigint(15) NOT NULL,
  `codigoautorizacion` varchar(100) NOT NULL,
  `totalVenta` decimal(14,2) NOT NULL,
  `ice` decimal(14,2) NOT NULL,
  `iehd` decimal(14,2) NOT NULL,
  `ipj` decimal(14,2) NOT NULL,
  `tasas` decimal(14,2) NOT NULL,
  `otronosujetoadf` decimal(14,2) NOT NULL,
  `ventasTasacero` decimal(14,2) NOT NULL,
  `subtotal` decimal(14,2) NOT NULL,
  `descuentosVentas` decimal(14,2) NOT NULL,
  `gifCardVentas` decimal(14,2) NOT NULL,
  `importeBasedf` decimal(14,2) NOT NULL,
  `debitoFiscal` decimal(14,2) NOT NULL,
  `estado` char(1) NOT NULL,
  `codigodecontrol` varchar(17) NOT NULL,
  `tipoVenta` int(1) NOT NULL,
  `idccontables` int(11) NOT NULL,
  `idlidiario` int(11) NOT NULL,
  `idempresa` int(11) NOT NULL,
  `fechaderegistro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechaactualizacion` timestamp NULL DEFAULT NULL,
  `idUsuario` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `idmodulo` bigint(20) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`idmodulo`, `titulo`, `descripcion`, `status`) VALUES
(1, 'Dashboard', 'Dashboard', 1),
(2, 'Usuarios', 'Usuarios del sistema', 1),
(3, 'Configuracion', 'Datos de la Empresa', 1),
(4, 'Libros-IVA', 'Cargado de Libros IVA del SIN', 1),
(5, 'Contabilidad', 'Registro de Transacciones', 1),
(6, 'Reportes', 'Informes de contabiliad', 1),
(7, 'Cuentas Contables', 'Cuenrtas contables del Sistema', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `idpermiso` bigint(20) NOT NULL,
  `rolid` bigint(20) NOT NULL,
  `moduloid` bigint(20) NOT NULL,
  `r` int(11) NOT NULL DEFAULT 0,
  `w` int(11) NOT NULL DEFAULT 0,
  `u` int(11) NOT NULL DEFAULT 0,
  `d` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`idpermiso`, `rolid`, `moduloid`, `r`, `w`, `u`, `d`) VALUES
(66, 4, 1, 0, 0, 0, 0),
(67, 4, 2, 1, 1, 0, 0),
(68, 4, 3, 0, 0, 0, 0),
(69, 4, 4, 0, 0, 0, 0),
(70, 4, 5, 0, 0, 0, 0),
(71, 4, 6, 0, 0, 0, 0),
(72, 5, 1, 0, 0, 0, 0),
(73, 5, 2, 0, 0, 0, 0),
(74, 5, 3, 0, 0, 0, 0),
(75, 5, 4, 0, 0, 0, 0),
(76, 5, 5, 0, 0, 0, 0),
(77, 5, 6, 1, 0, 0, 0),
(96, 2, 1, 0, 0, 0, 0),
(97, 2, 2, 1, 0, 0, 0),
(98, 2, 3, 1, 0, 0, 0),
(99, 2, 4, 0, 0, 0, 0),
(100, 2, 5, 0, 0, 0, 0),
(101, 2, 6, 0, 0, 0, 0),
(114, 3, 1, 0, 0, 0, 0),
(115, 3, 2, 0, 0, 0, 0),
(116, 3, 3, 1, 0, 0, 0),
(117, 3, 4, 1, 0, 0, 0),
(118, 3, 5, 0, 0, 0, 0),
(119, 3, 6, 0, 0, 0, 0),
(216, 1, 1, 1, 1, 1, 1),
(217, 1, 2, 1, 1, 1, 1),
(218, 1, 3, 1, 0, 1, 0),
(219, 1, 4, 1, 1, 1, 1),
(220, 1, 5, 1, 1, 1, 1),
(221, 1, 6, 1, 1, 1, 1),
(222, 1, 7, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` bigint(20) NOT NULL,
  `identificacion` varchar(30) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `email_user` varchar(100) NOT NULL,
  `password` varchar(75) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `nombrefiscal` varchar(80) NOT NULL,
  `direccionfiscal` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `rolid` bigint(20) NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `identificacion`, `nombres`, `apellidos`, `telefono`, `email_user`, `password`, `nit`, `nombrefiscal`, `direccionfiscal`, `token`, `rolid`, `datecreated`, `status`) VALUES
(1, '31308454', 'Julio Cesar', 'Vasquez Rocabado', 72251168, 'vasquez.julio.3130@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'CF', 'Julio Cesar Vasquez Rocabdo', 'Calama Nro.264', '789125b76f545c778025-0a0e06a1f39c0bcc00a0-a57a4cf127f39984cd34-ade1a1409a3fa86b0582', 1, '2024-10-08 02:28:53', 1),
(2, '15932020', 'Cesar', 'Vasquez', 78451210, 'sedecon3@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', '', '', '', 2, '2024-09-03 02:31:07', 1),
(3, '78986454', 'Pedro Francisco', 'Vargas Tellerina', 72565463, 'pedrotellerina@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', '', '', '', 2, '2024-09-19 17:59:59', 1),
(4, '79879875', 'Mario Ricardo', 'Montes', 789878458, 'mariomontes@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', '', '', '', 3, '2024-09-19 18:46:06', 1),
(5, '45678946', 'Ricardo', 'Morales', 78965412, 'ricardo@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', '', '', '', 3, '2024-09-20 23:53:02', 1),
(6, '789783121', 'Benjamin', 'Blanco', 698547852, 'benjamin@gmail.com', '6640c229fc9b530fa5c1bff5ce188abbdb2d16ade0d3630b0436e1ce50a80dfd', '', '', '', '', 3, '2024-09-20 23:55:40', 1),
(7, '456879', 'Carlos', 'Lopez', 77789854, 'carlos@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', '', '', '', 3, '2024-09-25 17:25:27', 1),
(8, '4654654654', 'Efraincito', 'Meneses', 78945632, 'efrain@gmai.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', '', '', '', 2, '2024-09-25 18:29:10', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plancuentas`
--

CREATE TABLE `plancuentas` (
  `idCcontables` int(11) NOT NULL,
  `codigocuenta` int(11) NOT NULL,
  `codigopuc` int(11) NOT NULL,
  `descripcion` varchar(90) NOT NULL,
  `rubro` varchar(30) NOT NULL,
  `fechaderegistro` varchar(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  `fechaactualizacion` varchar(45) DEFAULT NULL,
  `idUsuario` tinyint(4) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plancuentas`
--

INSERT INTO `plancuentas` (`idCcontables`, `codigocuenta`, `codigopuc`, `descripcion`, `rubro`, `fechaderegistro`, `fechaactualizacion`, `idUsuario`, `status`) VALUES
(1, 1, 1, 'ACTIVOS                                                                             ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(2, 1, 11, 'ACTIVOS CORRIENTES                                                                        ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(3, 1, 111, 'EFECTIVO Y EQUIVALENTES DE EFECTIVO                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(4, 1, 111001, 'CAJA                                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(5, 1, 111001, 'Caja moneda nacional                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(6, 1, 111001, 'Caja moneda extranjera                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(7, 1, 111002, 'FONDO FIJO                                                                                ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(8, 1, 111003, 'BANCOS                                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(9, 1, 111003, 'Banco mercantil caja de ahorro 4029949563                                                 ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(10, 1, 111003, 'Banco mercantil cta cte 4010891854                                                        ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(11, 1, 111003, 'Banco Mercantil cta cte 4011050669                                                        ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(12, 1, 111003, 'Banco Union M/N 1-20185860                                                                ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(13, 1, 111003, 'Banco Union M/N 1-45235997                                                                ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(14, 1, 111004, 'INVERSIONES TEMPORALES (A CORTO PLAZO)                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(15, 1, 111004, 'Depositos a plazo fijo                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(16, 1, 111004, 'Inversion en letras del TGN                                                               ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(17, 1, 112, 'ACTIVO EXIGIBLE                                                                           ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(18, 1, 112001, 'CUENTAS POR COBRAR COMERCIALES                                                            ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(19, 1, 112001, 'Cuentas por Cobrar Clientes                                                               ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(20, 1, 112002, 'OTRAS CUENTAS POR COBRAR                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(21, 1, 112002, 'Depositos en garantia                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(22, 1, 112002, 'Alquileres por cobrar                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(23, 1, 112002, 'Intereses por cobrar                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(24, 1, 112002, 'Comisiones por cobrar                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(25, 1, 112002, 'Cuentas incobrables                                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(26, 1, 112002, 'Consignatarios                                                                            ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(27, 1, 112002, 'Arrendatarios por cobrar                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(28, 1, 112002, 'Otras cuentas por cobrar                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(29, 1, 112003, 'CUENTAS POR COBRAR A EMPRESAS RELACIONADAS                                                ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(30, 1, 112004, 'ANTICIPO A PROVEEDORES                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(31, 1, 112004, 'Anticipo a Proveedores                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(32, 1, 112005, 'PROVISIÓN PARA CUENTAS INCOBRABLES                                                        ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(33, 1, 112006, 'CUENTAS DEL PERSONAL                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(34, 1, 112006, 'Prestamos al personal                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(35, 1, 112006, 'Anticipos al personal                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(36, 1, 112006, 'Fondos con cargos a rendición de cuentas                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(37, 1, 112007, 'CUENTAS SOCIOS                                                                            ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(38, 1, 112007, 'Prestamos a socios/accionistas                                                            ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(39, 1, 112007, 'Anticipo de utilidades                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(40, 1, 112007, 'Aporte de capital por cobrar                                                              ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(41, 1, 113, 'INVENTARIOS                                                                               ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(42, 1, 113001, 'Inventario Final de Obras Terminadas                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(43, 1, 113002, 'INVENTARIOS DE PRODUCTOS EN PROCESO                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(44, 1, 113002, 'Materiales y Suministros de Construccion                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(45, 1, 113002, 'MANO DE OBRA  DIRECTA                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(46, 1, 113002, 'GASTOS INDIRECTOS DE FABRICACION                                                          ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(47, 1, 113003, 'Inventario Inicial de Materia Prima                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(48, 1, 113004, 'INVENTARIO EN TRANSITO                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(49, 1, 113005, 'PROVISIÓN PARA OBSOLESCENCIAS                                                             ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(50, 1, 114, 'OTROS ACTIVOS CORRIENTES                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(51, 1, 114001, 'Credito Fiscal - IVA                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(52, 1, 114002, 'IMPUESTOS POR RECUPERAR                                                                   ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(53, 1, 114002, 'IUE por compensar                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(54, 1, 114002, 'Certificado de devolución impositiva (CEDEIM)                                             ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(55, 1, 114002, 'Credito Fiscal Diferido                                                                   ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(56, 1, 114003, 'PAGOS ANTICIPADOS                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(57, 1, 114003, 'Seguros pagados por adelantado                                                            ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(58, 1, 114003, 'Alquileres pagados por adelantado                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(59, 1, 114003, 'Comisiones pagadas por adelantado                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(60, 1, 114003, 'Intereses pagados por adelantado                                                          ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(61, 1, 114004, 'OTROS ACTIVOS                                                                             ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(62, 1, 12, 'ACTIVOS NO CORRIENTES                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(63, 1, 121, 'CUENTAS POR COBRAR A LARGO PLAZO                                                          ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(64, 1, 121001, 'CUENTAS COMERCIALES POR COBRAR A LARGO PLAZO                                              ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(65, 1, 121002, 'OTRAS CUENTAS POR COBRAR                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(66, 1, 121003, 'CUENTAS POR COBRAR A EMPRESAS RELACIONADAS                                                ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(67, 1, 122, 'INVENTARIOS NO CORRIENTES                                                                 ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(68, 1, 122001, 'INVENTARIOS DE REPUESTOS                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(69, 1, 122002, 'OTROS INVENTARIOS                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(70, 1, 122005, 'SISTEMAS COMPUTARIZADOS                                                                   ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(71, 1, 122006, 'AMORTIZACION ACUMULADA SISTEMA COMPUTARIZADO                                              ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(72, 1, 123, 'PROPIEDAD PLANTA Y EQUIPO (ACTIVO FIJO)                                                   ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(73, 1, 123001, 'TERRENOS                                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(74, 1, 123002, 'EDIFICIOS                                                                                 ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(75, 1, 123003, 'DEPRECIACIÓN ACUMULADA EDIFICIO                                                           ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(76, 1, 123004, 'Maquinaria y Equipo                                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(77, 1, 123005, 'Depreciacion Acumulada Maquinaria y Equipo                                                ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(78, 1, 123006, 'Vehiculos                                                                                 ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(79, 1, 123007, 'Depreciacion Acumulada Vehiculos                                                          ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(80, 1, 123008, 'Muebles y Enseres                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(81, 1, 123009, 'Depreciacion acumulada Muebles y enseres                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(82, 1, 123010, 'Equipo de Computacion                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(83, 1, 123011, 'Depreciacion Acumulada Equipo de Computacion                                              ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(84, 1, 123010, 'Herramientas                                                                              ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(85, 1, 123011, 'Depreciacion Acumulada Herramientas                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(86, 1, 124, 'PROPIEDADES DE INVERSIÓN                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(87, 1, 124001, 'PROPIEDADES DE INVERSIÓN                                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(88, 1, 125, 'ACTIVOS INTANGIBLES                                                                       ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(89, 1, 125001, 'PATENTES Y MARCAS                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(90, 1, 125002, 'AMORTIZACIÓN ACUMULADA PATENTES Y MARCAS                                                  ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(91, 1, 125003, 'DERECHOS DE LLAVE                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(92, 1, 125004, 'AMORTIZACIÓN ACUMULADA DERECHO DE LLAVE                                                   ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(93, 1, 126, 'INVERSIONES PERMANENTES                                                                   ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(94, 1, 126001, 'ACCIONES TELEFÓNICAS                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(95, 1, 126002, 'OBRAS EN CONSTRUCCIÓN                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(96, 1, 126003, 'INVERSIONES EN BONOS                                                                      ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(97, 1, 126004, 'INVERSIONES EN SAFI´S                                                                     ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(98, 1, 127, 'ACTIVOS DIFERIDOS                                                                         ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(99, 1, 127001, 'GASTOS DE ORGANIZACIÓN                                                                    ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(100, 1, 127002, 'AMORTIZACIÓN ACUMULADA GASTOS DE ORGANIZACIÓN                                             ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(101, 1, 128, 'OTROS ACTIVOS NO CORRIENTES                                                               ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(102, 1, 128001, 'OTROS ACTIVOS NO CORRIENTES                                                               ', 'Activo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(103, 2, 2, 'P A S I V O S                                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(104, 2, 21, 'PASIVOS CORRIENTES                                                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(105, 2, 211, 'OBLIGACIONES BANCARIAS Y FINANCIERAS                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(106, 2, 211001, 'PRÉSTAMOS BANCARIOS                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(107, 2, 211001, 'Prestamo Bancario C/plazo                                                                 ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(108, 2, 211002, 'OTROS PASIVOS FINANCIEROS                                                                 ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(109, 2, 211003, 'INTERESES POR PAGAR                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(110, 2, 212, 'CUENTAS POR PAGAR                                                                         ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(111, 2, 212001, 'CUENTAS POR PAGAR COMERCIALES                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(112, 2, 212001, 'Cuentas por Pagar proveedores                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(113, 2, 212001, 'Cuentas por pagar                                                                         ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(114, 2, 212002, 'DOCUMENTOS POR PAGAR                                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(115, 2, 212003, 'CUENTAS POR PAGAR A EMPRESAS RELACIONADAS                                                 ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(116, 2, 212005, 'SERVICIOS BASICOS POR PAGAR                                                               ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(117, 2, 212005, 'Servicio de Energia Electrica por pagar                                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(118, 2, 212005, 'Servicio de Agua Potable y Alcantarillado por pagar                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(119, 2, 212005, 'Servicio Telefonico por pagar                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(120, 2, 212005, 'Servicio de Internet y Telecomunicaciones por pagar                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(121, 2, 212005, 'Servicio de Transporte y Fletes por Pagar                                                 ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(122, 2, 212010, 'OTRAS CUENTAS POR PAGAR                                                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(123, 2, 212010, 'Alquileres por Pagar                                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(124, 2, 212010, 'Comisiones por Pagar                                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(125, 2, 212010, 'Intereses por Pagar                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(126, 2, 212010, 'Seguro por Pagar                                                                          ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(127, 2, 212010, 'Dividendo por Pagar                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(128, 2, 213, 'OBLIGACIONES SOCIALES Y FISCALES                                                          ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(129, 2, 213001, 'SUELDOS POR PAGAR                                                                         ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(130, 2, 213001, 'Sueldos y Salarios por Pagar                                                              ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(131, 2, 213001, 'Honorarios por Pagar                                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(132, 2, 213002, 'BENEFICIOS SOCIALES POR PAGAR                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(133, 2, 213002, 'Subsidios por Pagar                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(134, 2, 213002, 'Aguinaldos por Pagar                                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(135, 2, 213002, 'Indemnización por pagar                                                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(136, 2, 213002, 'Finiquito por pagar                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(137, 2, 213003, 'CARGAS SOCIALES                                                                           ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(138, 2, 213003, 'Aporte Patronal                                                                           ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(139, 2, 213003, 'Aporte Laboral                                                                            ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(140, 2, 213004, 'DEBITO FISCAL - IVA                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(141, 2, 213005, 'Impuestos a las Transacciones Por Pagar                                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(142, 2, 213006, 'IMPUESTO SOBRE LAS UTILIDADES DE LAS EMPRESAS POR PAGAR                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(143, 2, 213007, 'RETENCIONES POR PAGAR                                                                     ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(144, 2, 213008, 'OTROS IMPUESTOS POR PAGAR                                                                 ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(145, 2, 213008, 'FAP Por Pagar                                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(146, 2, 213008, 'ICE por Pagar                                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(147, 2, 213010, 'TASAS Y PATENTES MUNICIPALES POR PAGAR                                                    ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(148, 2, 213010, 'Patentes Municipales por pagar                                                            ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(149, 2, 213010, 'Impuesto Inmuebles por pagar                                                              ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(150, 2, 213010, 'Impuesto Vehiculos por pagar                                                              ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(151, 2, 213010, 'Codigos de Barra por pagar                                                                ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(152, 2, 213010, 'Servicio Sanitario SENASAG por pagar                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(153, 2, 213020, 'IVA Por Pagar                                                                             ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(154, 2, 214, 'PROVISIONES                                                                               ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(155, 2, 214001, 'Provision aguinaldo                                                                       ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(156, 2, 215, 'INGRESOS DIFERIDOS                                                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(157, 2, 215001, 'ANTICIPO DE CLIENTES                                                                      ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(158, 2, 215002, 'ALQUILERES COBRADOS POR ANTICIPADO                                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(159, 2, 215003, 'INTERES COBRADOS POR ANTICIPADO                                                           ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(160, 2, 215004, 'COMISIONES COBRADAS POR ANTICIPADO                                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(161, 2, 216, 'OTROS PASIVOS CORRIENTES                                                                  ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(162, 2, 216001, 'OTROS PASIVOS CORRIENTES                                                                  ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(163, 2, 22, 'PASIVOS NO CORRIENTES                                                                     ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(164, 2, 221, 'OBLIGACIONES BANCARIAS Y FINANCIERAS A LARGO PLAZO                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(165, 2, 221001, 'Prestamos Bancarios por Pagar C.P.                                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(166, 2, 221002, 'OTROS PASIVOS FINANCIEROS A LARGO PLAZO                                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(167, 2, 222, 'CUENTAS POR PAGAR A LARGO PLAZO                                                           ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(168, 2, 222001, 'DOCUMENTOS POR PAGAR A LARGO PLAZO                                                        ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(169, 2, 222002, 'CUENTAS POR PAGAR A EMPRESAS RELACIONADAS A LARGO PLAZO                                   ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(170, 2, 223, 'PREVISIÓN PARA BENEFICIOS SOCIALES (INDEMNIZACIONES AL PERSONAL)                          ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(171, 2, 223001, 'Prevision para Indemnizaciones                                                            ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(172, 2, 224, 'OTROS PASIVOS NO CORRIENTES                                                               ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(173, 2, 224001, 'OTROS PASIVOS NO CORRIENTES                                                               ', 'Pasivo', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(174, 3, 3, 'P A T R I M O N I O                                                                       ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(175, 3, 31, 'CAPITAL                                                                                   ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(176, 3, 310, 'CAPITAL                                                                                   ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(177, 3, 310001, 'Capital                                                                                   ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(178, 3, 310002, 'APORTES POR CAPITALIZAR                                                                   ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(179, 3, 310003, 'AJUSTE DE CAPITAL                                                                         ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(180, 3, 310003, 'Ajuste de Capital                                                                         ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(181, 3, 32, 'RESERVAS                                                                                  ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(182, 3, 320, 'RESERVAS                                                                                  ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(183, 3, 320001, 'RESERVA LEGAL                                                                             ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(184, 3, 320002, 'OTRAS RESERVAS                                                                            ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(185, 3, 320002, 'Reserva por revaluo tecnico                                                               ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(186, 3, 320002, 'Reserva constitutaria                                                                     ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(187, 3, 320003, 'AJUSTE DE RESERVAS PATRIMONIALES                                                          ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(188, 3, 33, 'RESULTADOS ACUMULADOS                                                                     ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(189, 3, 330, 'RESULTADOS ACUMULADOS                                                                     ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(190, 3, 330001, 'Resultados Acumulados                                                                     ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(191, 3, 330002, 'Resultado de la Gestión                                                                   ', 'Patrimonio', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(192, 4, 4, 'I N G R E S O S                                                                           ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(193, 4, 41, 'INGRESOS NETOS                                                                            ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(194, 4, 410, 'INGRESOS NETOS                                                                            ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(195, 4, 410001, 'INGRESOS                                                                                  ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(196, 4, 410001, 'Venta de Mercaderia                                                                       ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(197, 4, 410001, 'Ingreso por Servicios  de Construccion                                                    ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(198, 4, 410001, 'Ingreso por Alquiler de Maquinaria                                                        ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(199, 4, 410001, 'Ingresos por Refaccion y Mantenimiento                                                    ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(200, 4, 410001, 'Otras ventas                                                                              ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(201, 4, 410001, 'Recargos en ventas                                                                        ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(202, 4, 410002, 'DEVOLUCIONES, REBAJAS Y DESCUENTOS DE BIENES Y/O SERVICIOS                                ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(203, 4, 410002, 'Descuentos y rebajas en Ventas                                                            ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(204, 4, 410002, 'Devolucion en ventas                                                                      ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(205, 4, 42, 'INGRESOS FINANCIEROS                                                                      ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(206, 4, 420, 'INGRESOS FINANCIEROS                                                                      ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(207, 4, 420001, 'INTERES SOBRE PRESTAMOS BANCARIOS                                                         ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(208, 4, 420002, 'INTERESES DE INVERSIONES TEMPORALES                                                       ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(209, 4, 420003, 'OTROS INGRESOS FINANCIEROS                                                                ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(210, 4, 43, 'OTROS INGRESOS                                                                            ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(211, 4, 430, 'OTROS INGRESOS                                                                            ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(212, 4, 430001, 'AJUSTE POR INFLACIÓN Y TENENCIA DE BIENES                                                 ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(213, 4, 430002, 'INGRESOS POR VENTA DE VALORES                                                             ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(214, 4, 430003, 'OTROS INGRESOS                                                                            ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(215, 4, 430003, 'Alquileres percibidos                                                                     ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(216, 4, 430003, 'Comisiones percibidos                                                                     ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(217, 4, 430003, 'Mantenimiento de Valor                                                                    ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(218, 4, 430003, 'Diferencia de cambio                                                                      ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(219, 4, 430003, 'Diferencia por Redondeo                                                                   ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(220, 4, 430003, 'Excedentes en caja                                                                        ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(221, 4, 430003, 'Donaciones recibidas                                                                      ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(222, 4, 430003, 'Ganancia en Ventas de Activo Fijo                                                         ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(223, 4, 430003, 'Gastos recuperados                                                                        ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(224, 4, 430003, 'Reexpresion de cuentas de ingresos                                                        ', 'Ingresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(225, 5, 5, 'E G R E S O S                                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(226, 5, 51, 'COSTO POR SERVICIOS                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(227, 5, 510, 'COSTO DE SERVICIOS                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(228, 5, 510001, 'COSTO DE PRODUCTOS                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(229, 5, 510001, 'Inventario inicial                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(230, 5, 510001, 'Compras                                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(231, 5, 510001, 'Recargo en compras                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(232, 5, 510001, 'Inventario final                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(233, 5, 510001, 'Mano de obra Directa                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(234, 5, 510001, 'Costo de servicios                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(235, 5, 510001, 'Costos indirectos                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(236, 5, 510001, 'Inventario final de obras terminadas                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(237, 5, 510001, 'Costo de Construcción                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(238, 5, 510002, 'FLETES Y TRANSPORTES DE PRODUCTOS                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(239, 5, 510003, 'DEVOLUCIÓN EN COMPRAS                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(240, 5, 510004, 'DESCUENTOS SOBRE COMPRAS                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(241, 5, 510005, 'COSTO DE PRODUCTOS DAÑADOS                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(242, 5, 52, 'GASTOS DE COMERCIALIZACIÓN                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(243, 5, 520, 'GASTOS DE COMERCIALIZACIÓN                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(244, 5, 520001, 'Sueldos y salarios                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(245, 5, 520002, 'Beneficios sociales                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(246, 5, 520003, 'Aguinaldos                                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(247, 5, 520004, 'Indemnizaciones                                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(248, 5, 520005, 'PASAJES                                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(249, 5, 520006, 'PUBLICIDAD                                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(250, 5, 520006, 'Gastos de Publicidad y Propaganda                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(251, 5, 520006, 'Gastos por Promociones y Campañas                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(252, 5, 520007, 'DEPRECIACIÓN DE BIENES DE USO                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(253, 5, 520008, 'PÉRDIDA EN CUENTAS INCOBRABLES                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(254, 5, 520009, 'OTROS GASTOS DE COMERCIALIZACIÓN                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(255, 5, 53, 'GASTOS GENERALES DE ADMINISTRACIÓN                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(256, 5, 530, 'GASTOS GENERALES DE ADMINISTRACIÓN                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(257, 5, 530001, 'SUELDOS Y SALARIOS                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(258, 5, 530001, 'Personal permanente                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(259, 5, 530001, 'Personal Eventual                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(260, 5, 530001, 'Honorarios profesionales                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(261, 5, 530002, 'BENEFICIOS SOCIALES                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(262, 5, 530002, 'Cargas Sociales                                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(263, 5, 530002, 'Aporte patronal a la AFP                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(264, 5, 530002, 'Aporte patronal al Fondo Solidario                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(265, 5, 530002, 'Aporte patronal a INFOCAL                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(266, 5, 530002, 'Programa nacional de subsidio de vivienda (PNSV)                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(267, 5, 530002, 'Subsidio                                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(268, 5, 530002, 'Prima                                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(269, 5, 530002, 'Vacacion                                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(270, 5, 530002, 'Otros beneficios al personal                                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(271, 5, 530003, 'PROVISIÓN AGUINALDOS                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(272, 5, 530003, 'Aguinaldo                                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(273, 5, 530004, 'PREVISIÓN INDEMNIZACIONES                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(274, 5, 530004, 'Finiquito                                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(275, 5, 530004, 'Indemnizacion                                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(276, 5, 530005, 'VÍATICOS                                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(277, 5, 530006, 'PASAJES                                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(278, 5, 530007, 'SERVICIOS BÁSICOS                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(279, 5, 530007, 'Energia Electrica                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(280, 5, 530007, 'Agua Potable y Alcantarillado                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(281, 5, 530007, 'Telefonia                                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(282, 5, 530007, 'Internet y Telecomunicaciones                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(283, 5, 530008, 'MATERIALES Y SUMINISTROS                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(284, 5, 530008, 'Material de escritorio y fotocopias                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(285, 5, 530008, 'Material de limpieza e higiene                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(286, 5, 530009, 'FLETES Y TRANSPORTE                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(287, 5, 530009, 'Fletes y almacenamiento                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(288, 5, 530009, 'Transporte del personal                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(289, 5, 530010, 'MANTENIMIENTO Y REPARACIÓN                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(290, 5, 530010, 'Mantenimiento edificio                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(291, 5, 530010, 'Mantenimiento muebles y enseres                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(292, 5, 530010, 'Mantenimiento vehículos                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(293, 5, 530010, 'Mantenimiento maquinaria y equipo                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(294, 5, 530010, 'Mantenimiento herramientas                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(295, 5, 530010, 'Mantenimiento equipo de computación                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(296, 5, 530011, 'DEPRECIACIÓN DE BIENES DE USO                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(297, 5, 530011, 'Depreciación edificio                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(298, 5, 530011, 'Depreciación muebles y enseres                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(299, 5, 530011, 'Depreciación vehículos                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(300, 5, 530011, 'Depreciación maquinaria y equipo                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(301, 5, 530011, 'Depreciación herramientas                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(302, 5, 530011, 'Depreciación equipo de computación                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(303, 5, 530011, 'Amortizacion sistemas computarizados                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(304, 5, 530011, 'Amortizacion gastos de organizacion                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(305, 5, 530011, 'Amortizacion gastos de Instalación                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(306, 5, 530011, 'Amortizacion gastos anticipados                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(307, 5, 530011, 'Amortizacion investigacion y desarrollo                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(308, 5, 530012, 'ALQUILERES                                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(309, 5, 530012, 'Alquileres de equipo y maquinaria                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(310, 5, 530012, 'Alquileres edificios y oficinas                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(311, 5, 530012, 'Otros alquileres                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(312, 5, 530013, 'SEGUROS                                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(313, 5, 530013, 'Seguro de automotores                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(314, 5, 530013, 'Seguro contra incendios                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(315, 5, 530013, 'Seguro de salud                                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(316, 5, 530013, 'Seguros contra robo y asalto                                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(317, 5, 530013, 'Seguros de transporte                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(318, 5, 530014, 'SERVICIO DE SEGURIDAD                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(319, 5, 530015, 'GASTOS GENERALES                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(320, 5, 530015, 'Gastos jurídicos y legales                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(321, 5, 530015, 'Suscripciones                                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(322, 5, 530015, 'Asociaciones                                                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(323, 5, 530015, 'Correos                                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(324, 5, 530015, 'Atencion medica y sociales                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(325, 5, 530015, 'Servicio de té y refrigerio                                                               ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1);
INSERT INTO `plancuentas` (`idCcontables`, `codigocuenta`, `codigopuc`, `descripcion`, `rubro`, `fechaderegistro`, `fechaactualizacion`, `idUsuario`, `status`) VALUES
(326, 5, 530015, 'Capacitacion, estudio e investigacion                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(327, 5, 530015, 'Gastos de representacion                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(328, 5, 530015, 'Propinas                                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(329, 5, 530015, 'Combustibles y lubricantes                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(330, 5, 530015, 'Gastos Generales                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(331, 5, 530016, 'OTROS GASTOS DE ADMINISTRACIÓN                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(332, 5, 54, 'GASTOS FINANCIEROS                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(333, 5, 540, 'GASTOS FINANCIEROS                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(334, 5, 540001, 'Intereses  sobre Prestamos Bancarios                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(335, 5, 540002, 'INTERESES SOBRE OTRAS OBLIGACIONES FINANCIERAS                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(336, 5, 540003, 'OTROS INTERESES                                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(337, 5, 540004, 'Comisiones Bancarias                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(338, 5, 540005, 'OTROS GASTOS FINANCIEROS                                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(339, 5, 540005, 'Gastos bancarios                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(340, 5, 540005, 'Seguros                                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(341, 5, 540005, 'Multas                                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(342, 5, 55, 'OTROS GASTOS DE OPERACIÓN                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(343, 5, 550, 'OTROS GASTOS DE OPERACIÓN                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(344, 5, 550001, 'Impuesto a las Transacciones                                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(345, 5, 550002, 'OTROS IMPUESTOS Y TASAS                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(346, 5, 550002, 'IT - IUE Retenciones                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(347, 5, 550002, 'ICE Impuesto al consumo especifico                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(348, 5, 550002, 'Salidas al Exterior                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(349, 5, 550002, 'Multas y Accesorios                                                                       ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(350, 5, 550002, 'Intereses y mantenimiento de valor                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(351, 5, 550002, 'Patentes Municipales                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(352, 5, 550002, 'Impuesto Inmuebles                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(353, 5, 550002, 'Impuesto Vehiculos                                                                        ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(354, 5, 550002, 'Codigos de Barra                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(355, 5, 550002, 'Servicio Sanitario SENASAG                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(356, 5, 550002, 'Tasa de alumbrado publico(HAM)                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(357, 5, 550002, 'Tasa de aseo(HAM)                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(358, 5, 56, 'OTROS GASTOS NO OPERATIVOS                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(359, 5, 560, 'OTROS GASTOS NO OPERATIVOS                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(360, 5, 560001, 'AJUSTE POR INFLACIÓN Y TENENCIA DE BIENES                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(361, 5, 560002, 'DIFERENCIA DE CAMBIO                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(362, 5, 560003, 'OTROS GASTOS                                                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(363, 5, 560003, 'Perdida en Venta de Activos fijos                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(364, 5, 560003, 'Perdida en Baja de Bienes de Uso                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(365, 5, 560003, 'Perdida en Baja de Inventarios                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(366, 5, 560003, 'Mermas y Fallas en Inventarios                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(367, 5, 560003, 'Diferencia de inventarios                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(368, 5, 560003, 'Pérdida por obsolescencia de inventarios                                                  ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(369, 5, 560003, 'Perdida por Siniestros                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(370, 5, 560003, 'Perdida en Cuentas Incobrables                                                            ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(371, 5, 560003, 'Mantenimiento de Valor                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(372, 5, 560003, 'Diferencia por Redondeo                                                                   ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(373, 5, 560003, 'Faltantes en caja                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(374, 5, 560003, 'Reexpresion de cuentas de egreso                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(375, 5, 560004, 'GASTOS NO DEDUCIBLES                                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(376, 5, 560004, 'Alquileres                                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(377, 5, 560004, 'Servicios                                                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(378, 5, 560004, 'Gastos no respaldados                                                                     ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(379, 5, 560004, 'Gastos refrigerio                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(380, 5, 560004, 'Gastos movilidad                                                                          ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(381, 5, 560004, 'Gastos carguios                                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(382, 5, 560004, 'Gastos parqueo y peaje                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(383, 5, 560004, 'Gastos alimentación viaticos                                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(384, 5, 560004, 'Canaston navideño                                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(385, 5, 560004, 'Comisiones por importacion                                                                ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(386, 5, 560004, 'Donaciones y obsequios                                                                    ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(387, 5, 560004, 'Honorarios por servicios ocasionales                                                      ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(388, 5, 560004, 'IT Compensado                                                                             ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(389, 5, 560004, 'ITF Impuesto a las Transacciones Financieras                                              ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(390, 5, 560004, 'IVA - Credito Fiscal NO Utilizado                                                         ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(391, 5, 560004, 'IVA - Credito Fiscal NO Gravado                                                           ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(392, 5, 57, 'IMPUESTO A LAS UTILIDADES DE LAS EMPRESAS                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(393, 5, 570, 'IMPUESTO A LAS UTILIDADES DE LAS EMPRESAS                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1),
(394, 5, 570001, 'IMPUESTO A LAS UTILIDADES DE LAS EMPRESAS                                                 ', 'Egresos', 'CURRENT_TIMESTAMP', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` bigint(20) NOT NULL,
  `nombrerol` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nombrerol`, `descripcion`, `status`) VALUES
(1, 'Administrador', 'Acceso a todo el sistema', 1),
(2, 'Contador', 'Registra transacciones economicas', 1),
(3, 'Auxiliar Contable', 'Asistente del Contador', 1),
(4, 'Recursos Humanos', 'Registra un nuevo usuario con los roles existentes en lista', 1),
(5, 'Chofer', 'Conductor de vehiculos', 0),
(6, 'Mensajero', 'Distribuye Sobres a todas las instituciones', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `conceptooperacion`
--
ALTER TABLE `conceptooperacion`
  ADD PRIMARY KEY (`idAsiento`);

--
-- Indices de la tabla `configuraempresa`
--
ALTER TABLE `configuraempresa`
  ADD PRIMARY KEY (`idconfigura`);

--
-- Indices de la tabla `contaxmvcfin`
--
ALTER TABLE `contaxmvcfin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `dblicomprasiva`
--
ALTER TABLE `dblicomprasiva`
  ADD PRIMARY KEY (`iddbComprasiva`);

--
-- Indices de la tabla `dbliventasiva`
--
ALTER TABLE `dbliventasiva`
  ADD PRIMARY KEY (`iddbVentasiva`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`idEmpresa`);

--
-- Indices de la tabla `licomprasiva`
--
ALTER TABLE `licomprasiva`
  ADD PRIMARY KEY (`idComprasiva`),
  ADD KEY `idempresa` (`idempresa`);

--
-- Indices de la tabla `lidiario`
--
ALTER TABLE `lidiario`
  ADD PRIMARY KEY (`idLidiario`),
  ADD KEY `idAsiento` (`idAsiento`),
  ADD KEY `idCcontables` (`idCcontables`);

--
-- Indices de la tabla `liventasiva`
--
ALTER TABLE `liventasiva`
  ADD PRIMARY KEY (`idVentasiva`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`idmodulo`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idpermiso`),
  ADD KEY `rolid` (`rolid`),
  ADD KEY `moduloid` (`moduloid`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`),
  ADD KEY `rolid` (`rolid`);

--
-- Indices de la tabla `plancuentas`
--
ALTER TABLE `plancuentas`
  ADD PRIMARY KEY (`idCcontables`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `conceptooperacion`
--
ALTER TABLE `conceptooperacion`
  MODIFY `idAsiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `configuraempresa`
--
ALTER TABLE `configuraempresa`
  MODIFY `idconfigura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `contaxmvcfin`
--
ALTER TABLE `contaxmvcfin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dblicomprasiva`
--
ALTER TABLE `dblicomprasiva`
  MODIFY `iddbComprasiva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `dbliventasiva`
--
ALTER TABLE `dbliventasiva`
  MODIFY `iddbVentasiva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `idEmpresa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `licomprasiva`
--
ALTER TABLE `licomprasiva`
  MODIFY `idComprasiva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lidiario`
--
ALTER TABLE `lidiario`
  MODIFY `idLidiario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `liventasiva`
--
ALTER TABLE `liventasiva`
  MODIFY `idVentasiva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulo`
--
ALTER TABLE `modulo`
  MODIFY `idmodulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `idpermiso` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `plancuentas`
--
ALTER TABLE `plancuentas`
  MODIFY `idCcontables` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=395;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `licomprasiva`
--
ALTER TABLE `licomprasiva`
  ADD CONSTRAINT `licomprasiva_ibfk_1` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `lidiario`
--
ALTER TABLE `lidiario`
  ADD CONSTRAINT `lidiario_ibfk_1` FOREIGN KEY (`idAsiento`) REFERENCES `conceptooperacion` (`idAsiento`),
  ADD CONSTRAINT `lidiario_ibfk_2` FOREIGN KEY (`idCcontables`) REFERENCES `plancuentas` (`idCcontables`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`rolid`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permisos_ibfk_2` FOREIGN KEY (`moduloid`) REFERENCES `modulo` (`idmodulo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`rolid`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
