

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Base de datos: `contaxmvcfin`
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


CREATE TABLE `contaxmvcfin` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `importe` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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


CREATE TABLE `empresa` (
  `idEmpresa` int(11) NOT NULL,
  `ciNit` int(20) NOT NULL,
  `complemento` varchar(2) DEFAULT NULL,
  `razonsocial` varchar(240) NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fechaactualizacion` timestamp NULL DEFAULT NULL,
  `IdUsuario` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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


CREATE TABLE `modulo` (
  `idmodulo` bigint(20) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;


CREATE TABLE `permisos` (
  `idpermiso` bigint(20) NOT NULL,
  `rolid` bigint(20) NOT NULL,
  `moduloid` bigint(20) NOT NULL,
  `r` int(11) NOT NULL DEFAULT 0,
  `w` int(11) NOT NULL DEFAULT 0,
  `u` int(11) NOT NULL DEFAULT 0,
  `d` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;


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

CREATE TABLE `rol` (
  `idrol` bigint(20) NOT NULL,
  `nombrerol` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;


ALTER TABLE `conceptooperacion`
  ADD PRIMARY KEY (`idAsiento`);

ALTER TABLE `configuraempresa`
  ADD PRIMARY KEY (`idconfigura`);

ALTER TABLE `contaxmvcfin`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `dblicomprasiva`
  ADD PRIMARY KEY (`iddbComprasiva`);


ALTER TABLE `dbliventasiva`
  ADD PRIMARY KEY (`iddbVentasiva`);

ALTER TABLE `empresa`
  ADD PRIMARY KEY (`idEmpresa`);

ALTER TABLE `licomprasiva`
  ADD PRIMARY KEY (`idComprasiva`),
  ADD KEY `idempresa` (`idempresa`);

ALTER TABLE `lidiario`
  ADD PRIMARY KEY (`idLidiario`),
  ADD KEY `idAsiento` (`idAsiento`),
  ADD KEY `idCcontables` (`idCcontables`);

ALTER TABLE `liventasiva`
  ADD PRIMARY KEY (`idVentasiva`);

ALTER TABLE `modulo`
  ADD PRIMARY KEY (`idmodulo`);


ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idpermiso`),
  ADD KEY `rolid` (`rolid`),
  ADD KEY `moduloid` (`moduloid`);

ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`),
  ADD KEY `rolid` (`rolid`);

ALTER TABLE `plancuentas`
  ADD PRIMARY KEY (`idCcontables`);


ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

ALTER TABLE `conceptooperacion`
  MODIFY `idAsiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


ALTER TABLE `configuraempresa`
  MODIFY `idconfigura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;


ALTER TABLE `contaxmvcfin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `dblicomprasiva`
  MODIFY `iddbComprasiva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `dbliventasiva`
  MODIFY `iddbVentasiva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


ALTER TABLE `empresa`
  MODIFY `idEmpresa` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `licomprasiva`
  MODIFY `idComprasiva` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `lidiario`
  MODIFY `idLidiario` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `liventasiva`
  MODIFY `idVentasiva` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `modulo`
  MODIFY `idmodulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `permisos`
  MODIFY `idpermiso` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

ALTER TABLE `persona`
  MODIFY `idpersona` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `plancuentas`
  MODIFY `idCcontables` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=395;

ALTER TABLE `rol`
  MODIFY `idrol` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `licomprasiva`
  ADD CONSTRAINT `licomprasiva_ibfk_1` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `lidiario`
  ADD CONSTRAINT `lidiario_ibfk_1` FOREIGN KEY (`idAsiento`) REFERENCES `conceptooperacion` (`idAsiento`),
  ADD CONSTRAINT `lidiario_ibfk_2` FOREIGN KEY (`idCcontables`) REFERENCES `plancuentas` (`idCcontables`);

ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`rolid`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permisos_ibfk_2` FOREIGN KEY (`moduloid`) REFERENCES `modulo` (`idmodulo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`rolid`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

