-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-10-2024 a las 02:23:38
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aramedic`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `idmedico` bigint(20) NOT NULL,
  `funcion` text DEFAULT NULL,
  `inicio_servicio` date DEFAULT NULL,
  `tipo_contrato` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico_servicio`
--

CREATE TABLE `medico_servicio` (
  `idmedico` bigint(20) NOT NULL,
  `idservicio` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `idpacientes` bigint(20) NOT NULL,
  `edad` int(11) DEFAULT NULL,
  `estado_civil` text DEFAULT NULL,
  `ocupacion` text DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `motivo_principal` text DEFAULT NULL,
  `enfermedades_previas` text DEFAULT NULL,
  `alergia` text DEFAULT NULL,
  `medicamentos_actuales` text DEFAULT NULL,
  `cirugias_previas` text DEFAULT NULL,
  `fuma` text DEFAULT NULL,
  `consume_alcohol` text DEFAULT NULL,
  `enfermedades_hereditarias` text DEFAULT NULL,
  `peso` text DEFAULT NULL,
  `altura` decimal(5,2) DEFAULT NULL,
  `indice_de_masa_corporal_mic` double DEFAULT NULL,
  `descripcion_fisica` text DEFAULT NULL,
  `cirugia` text DEFAULT NULL,
  `descripcion_del_procedimiento` text DEFAULT NULL,
  `riesgos_y_complicaciones` text DEFAULT NULL,
  `cuidado_preoperatorio` text DEFAULT NULL,
  `cuidado_postoperatorio` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente_servicio`
--

CREATE TABLE `paciente_servicio` (
  `idpaciente` bigint(20) NOT NULL,
  `idservicio` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idrol` bigint(20) NOT NULL,
  `nombre` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idrol`, `nombre`) VALUES
(1, 'paciente'),
(2, 'medico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `idservicio` bigint(20) NOT NULL,
  `nombre_servicio` text NOT NULL,
  `tipo_procedimiento` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `detalles_precio` varchar(30) NOT NULL,
  `tiempo_estimado` text DEFAULT NULL,
  `permanencia_postoperatoria` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` bigint(20) NOT NULL,
  `dni` varchar(255) NOT NULL,
  `nombres` text NOT NULL,
  `apellidos` text NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `num_telefonico` varchar(255) NOT NULL,
  `genero` text NOT NULL,
  `correo` text NOT NULL,
  `contrasena` text NOT NULL,
  `idrol` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `dni`, `nombres`, `apellidos`, `fecha_nacimiento`, `num_telefonico`, `genero`, `correo`, `contrasena`, `idrol`) VALUES
(7, '', '', '', NULL, '', 'Masculino', '', '', 1),
(8, '', '', '', NULL, '', 'Masculino', '', '', 1),
(10, '74733226', 'DERECK', 'FERNANDO', NULL, '999999999', 'Masculino', 'dereckmunoz07@gmail.com', '123', 2),
(11, '72666946', 'Dean Ayrton', 'Reyes Vallejos', NULL, '974617857', 'Masculino', 'deanreyesvallejos@gmail.com', 'fVC8Kn5Vr6v4TY5', 1);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `role_change_trigger` AFTER UPDATE ON `usuario` FOR EACH ROW BEGIN
    IF OLD.idrol <> NEW.idrol THEN
        IF NEW.idrol = (SELECT idrol FROM roles WHERE nombre = 'Paciente') THEN
            -- Eliminar datos del médico
            DELETE FROM medicos WHERE idusuario = NEW.idusuario;
        END IF;
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`idmedico`);

--
-- Indices de la tabla `medico_servicio`
--
ALTER TABLE `medico_servicio`
  ADD PRIMARY KEY (`idmedico`,`idservicio`),
  ADD KEY `idservicio` (`idservicio`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`idpacientes`);

--
-- Indices de la tabla `paciente_servicio`
--
ALTER TABLE `paciente_servicio`
  ADD PRIMARY KEY (`idpaciente`,`idservicio`),
  ADD KEY `idservicio` (`idservicio`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idrol`),
  ADD UNIQUE KEY `nombre` (`nombre`) USING HASH;

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`idservicio`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `fk_rol_usuario` (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `idmedico` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `idpacientes` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idrol` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `idservicio` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `fk_usuario_medico` FOREIGN KEY (`idmedico`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `medico_servicio`
--
ALTER TABLE `medico_servicio`
  ADD CONSTRAINT `medico_servicio_ibfk_1` FOREIGN KEY (`idmedico`) REFERENCES `medicos` (`idmedico`),
  ADD CONSTRAINT `medico_servicio_ibfk_2` FOREIGN KEY (`idservicio`) REFERENCES `servicios` (`idservicio`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `fk_usuario_paciente` FOREIGN KEY (`idpacientes`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `paciente_servicio`
--
ALTER TABLE `paciente_servicio`
  ADD CONSTRAINT `paciente_servicio_ibfk_1` FOREIGN KEY (`idpaciente`) REFERENCES `pacientes` (`idpacientes`),
  ADD CONSTRAINT `paciente_servicio_ibfk_2` FOREIGN KEY (`idservicio`) REFERENCES `servicios` (`idservicio`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_rol_usuario` FOREIGN KEY (`idrol`) REFERENCES `roles` (`idrol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
