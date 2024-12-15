USE libreria;

ALTER TABLE `empleado` DROP FOREIGN KEY `empleado_fk4`;
ALTER TABLE `gerente` DROP FOREIGN KEY `gerente_fk0`;
ALTER TABLE `supervisor` DROP FOREIGN KEY `supervisor_fk0`;
ALTER TABLE `vendedor` DROP FOREIGN KEY `vendedor_fk0`;
ALTER TABLE `sucursal` DROP FOREIGN KEY `sucursal_fk6`;
ALTER TABLE `pedido` DROP FOREIGN KEY `pedido_fk3`;
ALTER TABLE `pedido` DROP FOREIGN KEY `pedido_fk4`;

ALTER TABLE `libro_categoria` DROP FOREIGN KEY `libro_categoria_fk0`;
ALTER TABLE `libro_categoria` DROP FOREIGN KEY `libro_categoria_fk1`;
ALTER TABLE `libro_autor` DROP FOREIGN KEY `libro_autor_fk0`;
ALTER TABLE `libro_autor` DROP FOREIGN KEY `libro_autor_fk1`;
ALTER TABLE `detalle_pedido` DROP FOREIGN KEY `detalle_pedido_fk2`;
ALTER TABLE `detalle_pedido` DROP FOREIGN KEY `detalle_pedido_fk3`;

ALTER TABLE `cliente_telefono` DROP FOREIGN KEY `cliente_telefono_fk0`;
ALTER TABLE `cliente_email` DROP FOREIGN KEY `cliente_email_fk1`;
ALTER TABLE `colegio` DROP FOREIGN KEY `colegio_fk3`;
ALTER TABLE `individual` DROP FOREIGN KEY `individual_fk0`;
ALTER TABLE `compra` DROP FOREIGN KEY `compra_fk2`;
ALTER TABLE `compra` DROP FOREIGN KEY `compra_fk3`;
ALTER TABLE `detalle_compra` DROP FOREIGN KEY `detalle_compra_fk1`;
ALTER TABLE `detalle_compra` DROP FOREIGN KEY `detalle_compra_fk3`;

DROP TABLE IF EXISTS `empleado`;
DROP TABLE IF EXISTS `gerente`;
DROP TABLE IF EXISTS `supervisor`;
DROP TABLE IF EXISTS `vendedor`;
DROP TABLE IF EXISTS `sucursal`;
DROP TABLE IF EXISTS `pedido`;
DROP TABLE IF EXISTS `proveedor`;
DROP TABLE IF EXISTS `libro`;
DROP TABLE IF EXISTS `categoria`;
DROP TABLE IF EXISTS `autor`;
DROP TABLE IF EXISTS `libro_categoria`;
DROP TABLE IF EXISTS `libro_autor`;
DROP TABLE IF EXISTS `detalle_pedido`;
DROP TABLE IF EXISTS `cliente`;
DROP TABLE IF EXISTS `cliente_telefono`;
DROP TABLE IF EXISTS `cliente_email`;
DROP TABLE IF EXISTS `colegio`;
DROP TABLE IF EXISTS `individual`;
DROP TABLE IF EXISTS `compra`;
DROP TABLE IF EXISTS `detalle_compra`;

CREATE TABLE IF NOT EXISTS `empleado` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`nombres` varchar(255) NOT NULL,
	`apellido1` varchar(255) NOT NULL,
	`apellido2` varchar(255) NOT NULL,
	`id_sucursal` bigint NOT NULL,
	`password` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `gerente` (
	`id` bigint NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `supervisor` (
	`id` bigint NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `vendedor` (
	`id` bigint NOT NULL,
	`meta_mensual` bigint NOT NULL,
    `id_supervisor` bigint,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `sucursal` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`nombre` varchar(255) NOT NULL,
	`departamento` varchar(255) NOT NULL,
	`ciudad` varchar(255) NOT NULL,
	`calle` varchar(255) NOT NULL,
	`numero` varchar(255) NOT NULL,
	`id_gerente` bigint,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `pedido` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`fecha` date NOT NULL,
	`estado` varchar(255) NOT NULL,
	`id_gerente` bigint NOT NULL,
	`id_proveedor` bigint NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `proveedor` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`nombres` varchar(255) NOT NULL,
	`apellido1` varchar(255) NOT NULL,
	`apellido2` varchar(255) NOT NULL,
	`direccion` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `libro` (
	`anio_publicacion` year NOT NULL,
	`precio` decimal(12,2) NOT NULL,
	`ISBN` varchar(255) NOT NULL,
	`titulo` varchar(255) NOT NULL,
	`descripcion` text NOT NULL,
	`paginas` smallint NOT NULL,
	`editorial` varchar(255) NOT NULL,
	`path_img` varchar(255) NOT NULL,
	`id` bigint AUTO_INCREMENT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `categoria` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`nombre` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `autor` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`nombre` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `libro_categoria` (
	`id_categoria` bigint NOT NULL,
	`id_libro` bigint NOT NULL,
	PRIMARY KEY (`id_categoria`, `id_libro`)
);

CREATE TABLE IF NOT EXISTS `libro_autor` (
	`id_autor` bigint NOT NULL,
	`id_libro` bigint NOT NULL,
	PRIMARY KEY (`id_autor`, `id_libro`)
);

CREATE TABLE IF NOT EXISTS `detalle_pedido` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`cantidad` bigint NOT NULL,
	`id_libro` bigint NOT NULL,
	`id_pedido` bigint NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `cliente` (
	`id` bigint AUTO_INCREMENT NOT NULL,
	`departamento` varchar(255) NOT NULL,
	`ciudad` varchar(255) NOT NULL,
	`calle` varchar(255) NOT NULL,
	`numero` varchar(255) NOT NULL,
	`password` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `cliente_telefono` (
	`id_cliente` bigint NOT NULL,
	`telefono` bigint NOT NULL,
	PRIMARY KEY (`id_cliente`, `telefono`)
);

CREATE TABLE IF NOT EXISTS `cliente_email` (
	`email` varchar(255) NOT NULL,
	`id_cliente` bigint NOT NULL,
	PRIMARY KEY (`email`, `id_cliente`)
);

CREATE TABLE IF NOT EXISTS `colegio` (
	`nombre` varchar(255) NOT NULL,
	`niveles_educativos` bigint NOT NULL,
	`tipo` varchar(255) NOT NULL,
	`id` bigint NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `individual` (
	`id` bigint NOT NULL,
	`nombres` varchar(255) NOT NULL,
	`apellido2` varchar(255) NOT NULL,
	`apellido1` varchar(255) NOT NULL,
	`nacionalidad` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `compra` (
	`id` bigint NOT NULL UNIQUE,
	`fecha` timestamp NOT NULL,
	`id_cliente` bigint NOT NULL,
	`id_vendedor` bigint NOT NULL,
	PRIMARY KEY (`id`, `id_cliente`, `id_vendedor`)
);

CREATE TABLE IF NOT EXISTS `detalle_compra` (
	`id` bigint NOT NULL,
	`id_compra` bigint NOT NULL,
	`cantidad` bigint NOT NULL,
	`id_libro` bigint NOT NULL,
	PRIMARY KEY (`id`, `id_compra`, `id_libro`)
);

ALTER TABLE `empleado` ADD CONSTRAINT `empleado_fk4` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal`(`id`);
ALTER TABLE `gerente` ADD CONSTRAINT `gerente_fk0` FOREIGN KEY (`id`) REFERENCES `empleado`(`id`);
ALTER TABLE `supervisor` ADD CONSTRAINT `supervisor_fk0` FOREIGN KEY (`id`) REFERENCES `empleado`(`id`);
ALTER TABLE `vendedor` ADD CONSTRAINT `vendedor_fk0` FOREIGN KEY (`id`) REFERENCES `empleado`(`id`);
ALTER TABLE `sucursal` ADD CONSTRAINT `sucursal_fk6` FOREIGN KEY (`id_gerente`) REFERENCES `gerente`(`id`);
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_fk3` FOREIGN KEY (`id_gerente`) REFERENCES `gerente`(`id`);
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_fk4` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor`(`id`);

ALTER TABLE `libro_categoria` ADD CONSTRAINT `libro_categoria_fk0` FOREIGN KEY (`id_categoria`) REFERENCES `categoria`(`id`);
ALTER TABLE `libro_categoria` ADD CONSTRAINT `libro_categoria_fk1` FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id`);
ALTER TABLE `libro_autor` ADD CONSTRAINT `libro_autor_fk0` FOREIGN KEY (`id_autor`) REFERENCES `autor`(`id`);
ALTER TABLE `libro_autor` ADD CONSTRAINT `libro_autor_fk1` FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id`);
ALTER TABLE `detalle_pedido` ADD CONSTRAINT `detalle_pedido_fk2` FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id`);
ALTER TABLE `detalle_pedido` ADD CONSTRAINT `detalle_pedido_fk3` FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id`);

ALTER TABLE `cliente_telefono` ADD CONSTRAINT `cliente_telefono_fk0` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id`);
ALTER TABLE `cliente_email` ADD CONSTRAINT `cliente_email_fk1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id`);
ALTER TABLE `colegio` ADD CONSTRAINT `colegio_fk3` FOREIGN KEY (`id`) REFERENCES `cliente`(`id`);
ALTER TABLE `individual` ADD CONSTRAINT `individual_fk0` FOREIGN KEY (`id`) REFERENCES `cliente`(`id`);
ALTER TABLE `compra` ADD CONSTRAINT `compra_fk2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id`);
ALTER TABLE `compra` ADD CONSTRAINT `compra_fk3` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedor`(`id`);
ALTER TABLE `detalle_compra` ADD CONSTRAINT `detalle_compra_fk1` FOREIGN KEY (`id_compra`) REFERENCES `compra`(`id`);
ALTER TABLE `detalle_compra` ADD CONSTRAINT `detalle_compra_fk3` FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id`);