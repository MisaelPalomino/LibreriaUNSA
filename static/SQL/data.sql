-- Inserts para la tabla 'cliente'
INSERT INTO cliente (id, departamento, ciudad, calle, numero, password) VALUES
(1, 'Lima', 'Miraflores', 'Av. Larco', '123', 'pass123'),
(2, 'Cusco', 'Cusco', 'Av. Sol', '456', 'pass456'),
(3, 'Arequipa', 'Arequipa', 'Calle Mercaderes', '789', 'pass789'),
(4, 'Lima', 'San Isidro', 'Calle Uno', '101', 'pass101'),
(5, 'Piura', 'Piura', 'Av. Grau', '202', 'pass202'),
(6, 'Lima', 'Surco', 'Av. Benavides', '303', 'pass303'),
(7, 'Ica', 'Ica', 'Av. Tacna', '404', 'pass404'),
(8, 'Lima', 'Barranco', 'Calle Dos', '505', 'pass505'),
(9, 'Tacna', 'Tacna', 'Calle Tres', '606', 'pass606'),
(10, 'Trujillo', 'Trujillo', 'Av. Mansiche', '707', 'pass707');

-- Inserts para la tabla 'colegio'
INSERT INTO colegio (id, nombre, niveles_educativos, tipo) VALUES
(1, 'Colegio San Marcos', 5, 'Privado'),
(2, 'Colegio Santa Maria', 6, 'Público'),
(3, 'Colegio Nuestra Señora', 4, 'Privado'),
(4, 'Colegio Nacional', 6, 'Público'),
(5, 'Colegio El Buen Pastor', 5, 'Privado');

-- Inserts para la tabla 'individual'
INSERT INTO individual (id, nombres, apellido1, apellido2, nacionalidad) VALUES
(6, 'Carlos', 'Lopez', 'Perez', 'Peruano'),
(7, 'Maria', 'Gutierrez', 'Sanchez', 'Peruana'),
(8, 'Juan', 'Torres', 'Diaz', 'Chileno'),
(9, 'Luisa', 'Martinez', 'Rojas', 'Ecuatoriana'),
(10, 'Pedro', 'Vargas', 'Flores', 'Boliviano');

-- Inserts para la tabla 'empleado'
INSERT INTO empleado (id, nombres, apellido1, apellido2, id_sucursal, password) VALUES
(1, 'Jose', 'Fernandez', 'Salas', 1, 'emp123'),
(2, 'Ana', 'Martinez', 'Perez', 1, 'emp456'),
(3, 'Miguel', 'Lopez', 'Diaz', 2, 'emp789'),
(4, 'Lucia', 'Gomez', 'Flores', 2, 'emp101'),
(5, 'Carlos', 'Torres', 'Gutierrez', 3, 'emp202'),
(6, 'Sara', 'Diaz', 'Rojas', 3, 'emp303'),
(7, 'Pedro', 'Vargas', 'Salazar', 4, 'emp404'),
(8, 'Julia', 'Ramirez', 'Soto', 4, 'emp505'),
(9, 'Roberto', 'Castro', 'Lopez', 5, 'emp606'),
(10, 'Elena', 'Reyes', 'Fernandez', 5, 'emp707'),
(11, 'Luis', 'Paredes', 'Diaz', 6, 'emp808'),
(12, 'Claudia', 'Chavez', 'Perez', 6, 'emp909'),
(13, 'Victor', 'Fuentes', 'Lopez', 7, 'emp010'),
(14, 'Andrea', 'Suarez', 'Soto', 7, 'emp111'),
(15, 'Diego', 'Ortega', 'Gomez', 8, 'emp121');

-- Inserts para la tabla 'gerente'
INSERT INTO gerente (id) VALUES
(1),
(2),
(3),
(4),
(5);

-- Inserts para la tabla 'supervisor'
INSERT INTO supervisor (id) VALUES
(6),
(7),
(8),
(9),
(10);

-- Inserts para la tabla 'vendedor'
INSERT INTO vendedor (id, meta_mensual) VALUES
(11, 100000),
(12, 120000),
(13, 110000),
(14, 130000),
(15, 125000);

-- Inserts para la tabla 'sucursal'
INSERT INTO sucursal (id, nombre, departamento, ciudad, calle, numero, id_gerente) VALUES
(1, 'Sucursal Centro', 'Lima', 'Lima', 'Av. Central', '101', 1),
(2, 'Sucursal Norte', 'Lima', 'Lima', 'Av. Tupac', '202', 2),
(3, 'Sucursal Sur', 'Arequipa', 'Arequipa', 'Av. Grau', '303', 3),
(4, 'Sucursal Este', 'Cusco', 'Cusco', 'Av. Sol', '404', 4),
(5, 'Sucursal Oeste', 'Piura', 'Piura', 'Av. Grau', '505', 5);

-- Inserts para la tabla 'pedido'
INSERT INTO pedido (id, fecha, estado, id_gerente, id_proveedor) VALUES
(1, '2024-01-15', 'Pendiente', 1, 1),
(2, '2024-02-01', 'Completado', 2, 2),
(3, '2024-03-20', 'Cancelado', 3, 3),
(4, '2024-04-10', 'Pendiente', 4, 4),
(5, '2024-05-05', 'Completado', 5, 5);

-- Inserts para la tabla 'proveedor'
INSERT INTO proveedor (id, nombres, apellido1, apellido2, direccion) VALUES
(1, 'Ricardo', 'Perez', 'Gomez', 'Av. Siempre Viva 123'),
(2, 'Ana', 'Lopez', 'Diaz', 'Calle Falsa 456'),
(3, 'Luis', 'Martinez', 'Rojas', 'Av. Real 789'),
(4, 'Claudia', 'Ramirez', 'Soto', 'Jiron Las Flores 101'),
(5, 'Carlos', 'Fuentes', 'Fernandez', 'Calle Sol Naciente 202');


