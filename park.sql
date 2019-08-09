-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-08-2019 a las 14:49:32
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `park`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cierre`
--

CREATE TABLE `cierre` (
  `id_cierre` int(5) NOT NULL,
  `fecha_cierre` datetime NOT NULL,
  `mensdia_cierre` decimal(10,0) NOT NULL,
  `regdia_cierre` decimal(10,0) NOT NULL,
  `totaldia_cierre` decimal(11,0) NOT NULL COMMENT 'totalentre mensualidad y registro alojados en el sistema',
  `dinerocaja_cierre` decimal(10,0) NOT NULL COMMENT 'dinero en caja fisica',
  `verificacion_cierre` tinyint(1) NOT NULL COMMENT '0- Total es igual a caja\n1- Existe diferencia',
  `id_sede` int(3) NOT NULL,
  `id_usuario` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id_ciudad` int(3) NOT NULL,
  `nombre_ciudad` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Ciudades de Colombia';

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id_ciudad`, `nombre_ciudad`) VALUES
(1, 'Bogota DC'),
(2, 'Cali');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(4) NOT NULL COMMENT 'Cedula del cliente',
  `documento_cliente` varchar(15) NOT NULL,
  `nombre_cliente` varchar(45) NOT NULL,
  `apellido_cliente` varchar(45) NOT NULL,
  `correo_cliente` varchar(60) NOT NULL,
  `telefono_cliente` varchar(15) NOT NULL,
  `direccion_cliente` varchar(60) DEFAULT NULL,
  `id_vehiculo` int(5) NOT NULL,
  `id_ciudad` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Clientes referentes a mensuañlidades o convenios';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensualidad`
--

CREATE TABLE `mensualidad` (
  `id_mensualidad` int(5) NOT NULL,
  `fechaini_mensualidad` date NOT NULL,
  `fechafin_mensualidad` date NOT NULL,
  `estado_mensualidad` tinyint(1) NOT NULL,
  `id_cliente` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL,
  `id_tarifa` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parqueadero`
--

CREATE TABLE `parqueadero` (
  `id_parqueadero` int(2) NOT NULL,
  `nit_parqueadero` varchar(13) NOT NULL,
  `nombre_parqueadero` varchar(45) NOT NULL,
  `logo_parqueadero` varchar(125) DEFAULT NULL,
  `iva_parqueadero` int(3) NOT NULL COMMENT 'Si el establecimiento maneja iva o no'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Datos del establecimiento';

--
-- Volcado de datos para la tabla `parqueadero`
--

INSERT INTO `parqueadero` (`id_parqueadero`, `nit_parqueadero`, `nombre_parqueadero`, `logo_parqueadero`, `iva_parqueadero`) VALUES
(1, '10101010-5', 'Parqueadero Camaleon Pruebas', NULL, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE `registro` (
  `id_registro` int(11) NOT NULL,
  `fecha_registro` date NOT NULL,
  `horaini_registro` time DEFAULT NULL,
  `horafin_registro` time DEFAULT NULL,
  `estado_registro` tinyint(1) NOT NULL COMMENT '0-Ingreso\\n1-Salida',
  `costo_registro` varchar(10) DEFAULT NULL,
  `placa_registro` varchar(8) NOT NULL,
  `id_tarifa` int(2) NOT NULL,
  `id_usuario` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`id_registro`, `fecha_registro`, `horaini_registro`, `horafin_registro`, `estado_registro`, `costo_registro`, `placa_registro`, `id_tarifa`, `id_usuario`) VALUES
(16, '2018-12-14', '08:22:44', '11:52:41', 1, '12,600', 'XYZ123', 1, 1),
(17, '2018-12-14', '09:35:42', '11:46:53', 1, '6,550', 'bat007', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(2) NOT NULL,
  `nombre_rol` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Roles predeterminados del sistema';

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES
(1, 'Dueño Vehiculo'),
(2, 'Dueño Garaje');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sede`
--

CREATE TABLE `sede` (
  `id_sede` int(2) NOT NULL,
  `nombre_sede` varchar(45) NOT NULL,
  `direccion_sede` varchar(60) DEFAULT NULL,
  `estado_sede` tinyint(1) DEFAULT NULL,
  `id_parqueadero` int(2) NOT NULL,
  `id_ciudad` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sede`
--

INSERT INTO `sede` (`id_sede`, `nombre_sede`, `direccion_sede`, `estado_sede`, `id_parqueadero`, `id_ciudad`) VALUES
(1, 'Sede Norte', 'Av 1234567 Norte', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `slot`
--

CREATE TABLE `slot` (
  `id_slot` int(2) NOT NULL,
  `nombre_slot` varchar(45) NOT NULL,
  `capacidad_slot` int(5) DEFAULT NULL,
  `id_sede` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa`
--

CREATE TABLE `tarifa` (
  `id_tarifa` int(2) NOT NULL,
  `nombre_tarifa` varchar(60) NOT NULL,
  `valor_tarifa` decimal(10,0) DEFAULT NULL,
  `mensualidad_tarifa` tinyint(1) DEFAULT NULL,
  `estado_tarifa` tinyint(1) NOT NULL,
  `id_tiempo` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tarifa`
--

INSERT INTO `tarifa` (`id_tarifa`, `nombre_tarifa`, `valor_tarifa`, `mensualidad_tarifa`, `estado_tarifa`, `id_tiempo`) VALUES
(1, 'Carro', '60', 0, 1, 1),
(2, 'Carro', '3000', 0, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiempo`
--

CREATE TABLE `tiempo` (
  `id_tiempo` int(11) NOT NULL,
  `nombre_tiempo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tiempo`
--

INSERT INTO `tiempo` (`id_tiempo`, `nombre_tiempo`) VALUES
(1, 'Minuto'),
(2, 'Hora');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(4) NOT NULL,
  `documento_usuario` varchar(15) NOT NULL,
  `nombre_usuario` varchar(60) NOT NULL,
  `apellido_usuario` varchar(60) NOT NULL,
  `correo_usuario` varchar(60) NOT NULL,
  `password_usuario` varchar(45) NOT NULL,
  `telefono_usuario` varchar(15) DEFAULT NULL,
  `direccion_usuario` varchar(60) DEFAULT NULL,
  `estado_usuario` tinyint(1) NOT NULL,
  `id_rol` int(2) NOT NULL,
  `id_ciudad` int(4) NOT NULL,
  `id_sede` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Miembros del establecimiento';

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `documento_usuario`, `nombre_usuario`, `apellido_usuario`, `correo_usuario`, `password_usuario`, `telefono_usuario`, `direccion_usuario`, `estado_usuario`, `id_rol`, `id_ciudad`, `id_sede`) VALUES
(1, '1023975709', 'Ana', 'Morales', 'a@a.a', '12345', NULL, NULL, 1, 1, 1, 1),
(4, '123456', 'Juan', 'Perez', 'admin@admin.com', '123', '324568', 'Cra 123#', 1, 1, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cierre`
--
ALTER TABLE `cierre`
  ADD PRIMARY KEY (`id_cierre`),
  ADD KEY `idsede` (`id_sede`),
  ADD KEY `idusuario` (`id_usuario`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id_ciudad`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `idvehiculo` (`id_vehiculo`),
  ADD KEY `idciudad` (`id_ciudad`);

--
-- Indices de la tabla `mensualidad`
--
ALTER TABLE `mensualidad`
  ADD PRIMARY KEY (`id_mensualidad`),
  ADD KEY `idcliente` (`id_cliente`),
  ADD KEY `idusuario` (`id_usuario`),
  ADD KEY `idtarifa` (`id_tarifa`);

--
-- Indices de la tabla `parqueadero`
--
ALTER TABLE `parqueadero`
  ADD PRIMARY KEY (`id_parqueadero`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `idvehiculo` (`placa_registro`),
  ADD KEY `idtarifa` (`id_tarifa`),
  ADD KEY `idusuario` (`id_usuario`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `sede`
--
ALTER TABLE `sede`
  ADD PRIMARY KEY (`id_sede`),
  ADD KEY `idparqueadero` (`id_parqueadero`),
  ADD KEY `idciudad` (`id_ciudad`);

--
-- Indices de la tabla `slot`
--
ALTER TABLE `slot`
  ADD PRIMARY KEY (`id_slot`),
  ADD KEY `idesede` (`id_sede`);

--
-- Indices de la tabla `tarifa`
--
ALTER TABLE `tarifa`
  ADD PRIMARY KEY (`id_tarifa`),
  ADD KEY `idtiempo` (`id_tiempo`);

--
-- Indices de la tabla `tiempo`
--
ALTER TABLE `tiempo`
  ADD PRIMARY KEY (`id_tiempo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `idrol` (`id_rol`),
  ADD KEY `idciudad` (`id_ciudad`),
  ADD KEY `id_sede` (`id_sede`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cierre`
--
ALTER TABLE `cierre`
  MODIFY `id_cierre` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parqueadero`
--
ALTER TABLE `parqueadero`
  MODIFY `id_parqueadero` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `registro`
--
ALTER TABLE `registro`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `sede`
--
ALTER TABLE `sede`
  MODIFY `id_sede` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `slot`
--
ALTER TABLE `slot`
  MODIFY `id_slot` int(2) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarifa`
--
ALTER TABLE `tarifa`
  MODIFY `id_tarifa` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tiempo`
--
ALTER TABLE `tiempo`
  MODIFY `id_tiempo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cierre`
--
ALTER TABLE `cierre`
  ADD CONSTRAINT `cierre_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `idsede_bfk` FOREIGN KEY (`id_sede`) REFERENCES `sede` (`id_sede`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `idciudfk` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `mensualidad`
--
ALTER TABLE `mensualidad`
  ADD CONSTRAINT `idcliefk` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `mensualidad_ibfk_1` FOREIGN KEY (`id_tarifa`) REFERENCES `tarifa` (`id_tarifa`),
  ADD CONSTRAINT `mensualidad_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `registro_ibfk_1` FOREIGN KEY (`id_tarifa`) REFERENCES `tarifa` (`id_tarifa`),
  ADD CONSTRAINT `registro_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `sede`
--
ALTER TABLE `sede`
  ADD CONSTRAINT `sede_ibfk_1` FOREIGN KEY (`id_parqueadero`) REFERENCES `parqueadero` (`id_parqueadero`),
  ADD CONSTRAINT `sede_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`);

--
-- Filtros para la tabla `slot`
--
ALTER TABLE `slot`
  ADD CONSTRAINT `idesedefk` FOREIGN KEY (`id_sede`) REFERENCES `sede` (`id_sede`);

--
-- Filtros para la tabla `tarifa`
--
ALTER TABLE `tarifa`
  ADD CONSTRAINT `tarifa_ibfk_1` FOREIGN KEY (`id_tiempo`) REFERENCES `tiempo` (`id_tiempo`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`),
  ADD CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`id_sede`) REFERENCES `sede` (`id_sede`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
