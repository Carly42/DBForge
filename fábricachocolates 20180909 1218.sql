﻿--
-- Script was generated by Devart dbForge Studio for MySQL, Version 8.0.40.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 09/09/2018 12:18:42
-- Server version: 5.5.5-10.1.34-MariaDB
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

DROP DATABASE IF EXISTS fábricachocolates;

CREATE DATABASE fábricachocolates
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Set default database
--
USE fábricachocolates;

--
-- Create table `envío`
--
CREATE TABLE envío (
  codEnvío int(11) NOT NULL AUTO_INCREMENT,
  destinatario varchar(30) NOT NULL,
  teléfono int(8) NOT NULL,
  costoAdicional int(5) NOT NULL,
  PRIMARY KEY (codEnvío)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `empleado`
--
CREATE TABLE empleado (
  codEmpleado int(7) NOT NULL AUTO_INCREMENT,
  nombre varchar(30) NOT NULL,
  CI int(7) NOT NULL,
  teléfono int(7) DEFAULT NULL,
  celular int(8) NOT NULL,
  dirección varchar(50) DEFAULT NULL,
  cargo varchar(30) NOT NULL,
  PRIMARY KEY (codEmpleado)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `cliente`
--
CREATE TABLE cliente (
  codCliente int(7) NOT NULL AUTO_INCREMENT,
  nombre varchar(50) NOT NULL,
  CI int(7) NOT NULL,
  teléfono int(7) DEFAULT NULL,
  celular int(8) NOT NULL,
  dirección varchar(50) DEFAULT NULL,
  puntos int(5) NOT NULL,
  PRIMARY KEY (codCliente)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `venta`
--
CREATE TABLE venta (
  numVenta int(11) NOT NULL AUTO_INCREMENT,
  fecha datetime NOT NULL,
  codEnvío int(11) NOT NULL,
  codCliente int(7) NOT NULL,
  codEmpleado int(7) NOT NULL,
  PRIMARY KEY (numVenta)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create foreign key
--
ALTER TABLE venta
ADD CONSTRAINT FK_venta_cliente_codCliente FOREIGN KEY (codCliente)
REFERENCES cliente (codCliente) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE venta
ADD CONSTRAINT FK_venta_empleado_codEmpleado FOREIGN KEY (codEmpleado)
REFERENCES empleado (codEmpleado) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE venta
ADD CONSTRAINT FK_venta_envío_codEnvío FOREIGN KEY (codEnvío)
REFERENCES envío (codEnvío) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `factura`
--
CREATE TABLE factura (
  numVenta int(11) NOT NULL,
  NIT int(11) NOT NULL,
  nombre varchar(30) NOT NULL,
  descripción varchar(255) DEFAULT NULL,
  PRIMARY KEY (numVenta)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create foreign key
--
ALTER TABLE factura
ADD CONSTRAINT FK_factura_venta_numVenta FOREIGN KEY (numVenta)
REFERENCES venta (numVenta) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `categoría`
--
CREATE TABLE categoría (
  codCategoría int(7) NOT NULL AUTO_INCREMENT,
  nombre varchar(30) NOT NULL,
  descripción varchar(255) DEFAULT NULL,
  PRIMARY KEY (codCategoría)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `producto`
--
CREATE TABLE producto (
  codProducto int(7) NOT NULL AUTO_INCREMENT,
  nombre varchar(30) NOT NULL,
  descripción varchar(50) DEFAULT NULL,
  precio decimal(5, 2) NOT NULL,
  codCategoría int(7) NOT NULL,
  codIngrediente int(7) NOT NULL,
  PRIMARY KEY (codProducto)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create foreign key
--
ALTER TABLE producto
ADD CONSTRAINT FK_producto_categoría_codCategoría FOREIGN KEY (codCategoría)
REFERENCES categoría (codCategoría) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `detalleventa`
--
CREATE TABLE detalleventa (
  codVenta int(11) NOT NULL AUTO_INCREMENT,
  numVenta int(11) NOT NULL,
  codProducto int(7) NOT NULL,
  cantidad int(5) NOT NULL,
  PRIMARY KEY (codVenta)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create foreign key
--
ALTER TABLE detalleventa
ADD CONSTRAINT FK_detalleventa_producto_codProducto FOREIGN KEY (codProducto)
REFERENCES producto (codProducto) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE detalleventa
ADD CONSTRAINT FK_detalleventa_venta_numVenta FOREIGN KEY (numVenta)
REFERENCES venta (numVenta) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `ingredientes`
--
CREATE TABLE ingredientes (
  codIngrediente int(7) NOT NULL AUTO_INCREMENT,
  descripción varchar(50) DEFAULT NULL,
  costo decimal(5, 2) NOT NULL,
  numAlmacén int(3) NOT NULL,
  cantidad int(11) NOT NULL,
  PRIMARY KEY (codIngrediente)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `ingredientesproducto`
--
CREATE TABLE ingredientesproducto (
  codProducto int(7) NOT NULL,
  codIngrediente int(11) NOT NULL,
  PRIMARY KEY (codProducto, codIngrediente)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create foreign key
--
ALTER TABLE ingredientesproducto
ADD CONSTRAINT FK_ingredientesproducto_ingredientes_codIngrediente FOREIGN KEY (codIngrediente)
REFERENCES ingredientes (codIngrediente) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE ingredientesproducto
ADD CONSTRAINT FK_ingredientesproducto_producto_codProducto FOREIGN KEY (codProducto)
REFERENCES producto (codProducto) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `compraingrediente`
--
CREATE TABLE compraingrediente (
  codCompraIng int(11) NOT NULL,
  nombre varchar(30) NOT NULL,
  cantidad int(5) NOT NULL,
  factura int(11) NOT NULL,
  proveedor varchar(30) DEFAULT NULL,
  PRIMARY KEY (codCompraIng)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create table `detallecompraingredientes`
--
CREATE TABLE detallecompraingredientes (
  codIngrediente int(7) NOT NULL,
  codCompraIng int(11) NOT NULL,
  PRIMARY KEY (codIngrediente, codCompraIng)
)
ENGINE = INNODB,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

--
-- Create foreign key
--
ALTER TABLE detallecompraingredientes
ADD CONSTRAINT FK_detallecompraingredientes_compraingrediente_codCompraIng FOREIGN KEY (codCompraIng)
REFERENCES compraingrediente (codCompraIng) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE detallecompraingredientes
ADD CONSTRAINT FK_detallecompraingredientes_ingredientes_codIngrediente FOREIGN KEY (codIngrediente)
REFERENCES ingredientes (codIngrediente) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Dumping data for table envío
--
-- Table fábricachocolates.envío does not contain any data (it is empty)

-- 
-- Dumping data for table empleado
--
-- Table fábricachocolates.empleado does not contain any data (it is empty)

-- 
-- Dumping data for table cliente
--
-- Table fábricachocolates.cliente does not contain any data (it is empty)

-- 
-- Dumping data for table categoría
--
-- Table fábricachocolates.categoría does not contain any data (it is empty)

-- 
-- Dumping data for table venta
--
-- Table fábricachocolates.venta does not contain any data (it is empty)

-- 
-- Dumping data for table producto
--
-- Table fábricachocolates.producto does not contain any data (it is empty)

-- 
-- Dumping data for table ingredientes
--
-- Table fábricachocolates.ingredientes does not contain any data (it is empty)

-- 
-- Dumping data for table compraingrediente
--
-- Table fábricachocolates.compraingrediente does not contain any data (it is empty)

-- 
-- Dumping data for table ingredientesproducto
--
-- Table fábricachocolates.ingredientesproducto does not contain any data (it is empty)

-- 
-- Dumping data for table factura
--
-- Table fábricachocolates.factura does not contain any data (it is empty)

-- 
-- Dumping data for table detalleventa
--
-- Table fábricachocolates.detalleventa does not contain any data (it is empty)

-- 
-- Dumping data for table detallecompraingredientes
--
-- Table fábricachocolates.detallecompraingredientes does not contain any data (it is empty)

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;