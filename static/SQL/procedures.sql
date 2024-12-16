USE libreria;



-- ******************************************************************************************
-- Cliente
-- ******************************************************************************************

DELIMITER $$
DROP PROCEDURE IF EXISTS LoginCliente;
CREATE PROCEDURE LoginCliente(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT c.id, c.password
    FROM cliente c
    INNER JOIN cliente_email ce ON ce.id_cliente = c.id
    WHERE ce.email = p_email
    AND c.password = p_password;
END$$
DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS RegistrarCliente;
CREATE PROCEDURE RegistrarCliente(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_tipo_cliente ENUM('individual', 'colegio'),
    IN p_departamento VARCHAR(255),  -- Nuevo parámetro
    IN p_ciudad VARCHAR(255),        -- Nuevo parámetro
    IN p_calle VARCHAR(255),         -- Nuevo parámetro
    IN p_numero VARCHAR(255),        -- Nuevo parámetro
    IN p_telefono BIGINT,
    IN p_nombres VARCHAR(255),       -- Solo para 'individual'
    IN p_apellido1 VARCHAR(255),     -- Solo para 'individual'
    IN p_apellido2 VARCHAR(255),     -- Solo para 'individual'
    IN p_nacionalidad VARCHAR(255),  -- Solo para 'individual'
    IN p_nombre_colegio VARCHAR(255),-- Solo para 'colegio'
    IN p_niveles_educativos BIGINT,  -- Solo para 'colegio'
    IN p_tipo_colegio VARCHAR(255)   -- Solo para 'colegio'
)
BEGIN
    DECLARE nuevo_id BIGINT;

    -- Insertar el cliente principal en la tabla `cliente`
    INSERT INTO cliente (departamento, ciudad, calle, numero, password)
    VALUES (p_departamento, p_ciudad, p_calle, p_numero, p_password);
    SET nuevo_id = LAST_INSERT_ID();

    -- Insertar el email asociado al cliente
    INSERT INTO cliente_email (id_cliente, email)
    VALUES (nuevo_id, p_email);

    -- Insertado de telefono
    INSERT INTO cliente_telefono(id_cliente, telefono)
    VALUES (nuevo_id, p_telefono);

    -- Manejar inserciones según el tipo de cliente
    IF p_tipo_cliente = 'colegio' THEN
        INSERT INTO colegio (id, nombre, niveles_educativos, tipo)
        VALUES (
            nuevo_id,
            p_nombre_colegio,
            p_niveles_educativos,
            p_tipo_colegio
        );
    ELSE
        INSERT INTO individual (id, nombres, apellido1, apellido2, nacionalidad)
        VALUES (
            nuevo_id,
            p_nombres,
            p_apellido1,
            p_apellido2,
            p_nacionalidad
        );
    END IF;
END$$

DELIMITER ;



-- ******************************************************************************************
-- Empleado
-- ******************************************************************************************


DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerCredencialesEmpleado$$
CREATE PROCEDURE ObtenerCredencialesEmpleado(
	IN p_id BIGINT
)
BEGIN
    SELECT id, password FROM empleado WHERE id = p_id;
END$$
DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerTipoEmpleado$$
CREATE PROCEDURE ObtenerTipoEmpleado(
	IN p_id BIGINT
)
BEGIN
    SELECT 'vendedor' AS ROL FROM vendedor v WHERE v.id = p_id
    UNION
    SELECT 'supervisor' AS ROL FROM supervisor s WHERE s.id = p_id
    UNION
    SELECT 'gerente' AS ROL FROM gerente g WHERE g.id = p_id;
END$$
DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS RegistrarEmpleado$$
CREATE PROCEDURE RegistrarEmpleado(
    IN p_nombres VARCHAR(255),
    IN p_apellido1 VARCHAR(255),
    IN p_apellido2 VARCHAR(255),
    IN p_id_sucursal BIGINT,
    IN p_password VARCHAR(255),
    IN p_tipo_empleado ENUM('vendedor', 'supervisor', 'gerente'),
    IN p_meta_mensual BIGINT, -- Solo para vendedores
    IN p_id_supervisor BIGINT -- Solo para vendedores
)
label:BEGIN
    START TRANSACTION;

    -- Sucursal debe existir
    IF NOT EXISTS (SELECT 1 FROM sucursal WHERE id = p_id_sucursal) THEN
    	LEAVE label;
    END IF;

    -- Insertar en la tabla empleado
    INSERT INTO empleado (nombres, apellido1, apellido2, id_sucursal, password)
    VALUES (p_nombres, p_apellido1, p_apellido2, p_id_sucursal, p_password);

    -- ID empleado recién insertado
    SET @new_employee_id = LAST_INSERT_ID();

    -- Verificar el tipo de empleado y registrar en la tabla correspondiente
    IF p_tipo_empleado = 'vendedor' THEN
        -- Validar que el supervisor exista
        IF NOT EXISTS (SELECT 1 FROM supervisor WHERE id = p_id_supervisor) THEN
            ROLLBACK;
	        LEAVE label;
        END IF;

        -- Insertar en la tabla vendedor
        INSERT INTO vendedor (id, meta_mensual, id_supervisor)
        VALUES (@new_employee_id, p_meta_mensual, p_id_supervisor);

    ELSEIF p_tipo_empleado = 'supervisor' THEN
        -- Insertar en la tabla supervisor
        INSERT INTO supervisor (id)
        VALUES (@new_employee_id);

    ELSEIF p_tipo_empleado = 'gerente' THEN
        -- Insertar en la tabla gerente
        INSERT INTO gerente (id)
        VALUES (@new_employee_id);

        UPDATE sucursal s SET s.id_gerente = @new_employee_id WHERE s.id = p_id_sucursal;
    ELSE
        -- Tipo empleado inválido
        ROLLBACK;
        LEAVE label;
    END IF;

    COMMIT;
END$$

DELIMITER ;





-- ******************************************************************************************
-- Sucursal
-- ******************************************************************************************

DELIMITER $$

DROP PROCEDURE IF EXISTS RegistrarSucursal$$
CREATE PROCEDURE RegistrarSucursal(
    IN p_nombre VARCHAR(255),
    IN p_departamento VARCHAR(255),
    IN p_ciudad VARCHAR(255),
    IN p_calle VARCHAR(255),
    IN p_numero VARCHAR(255),
    IN p_id_gerente BIGINT
)
label:BEGIN
    -- Validar que el gerente exista si se especifica
    IF p_id_gerente IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM gerente WHERE id = p_id_gerente) THEN
            LEAVE label;
        END IF;
    END IF;

    -- Insertar la sucursal con el gerente especificado o NULL
    INSERT INTO sucursal (nombre, departamento, ciudad, calle, numero, id_gerente)
    VALUES (p_nombre, p_departamento, p_ciudad, p_calle, p_numero, p_id_gerente);
END$$

DELIMITER ;




-- ******************************************************************************************
-- Libro/Categoria/Autor
-- ******************************************************************************************

DELIMITER $$

DROP PROCEDURE IF EXISTS InsertarLibroConAutorYCategoria;
CREATE PROCEDURE InsertarLibroConAutorYCategoria(
    IN p_anio_publicacion YEAR,
    IN p_precio DECIMAL(12,2),
    IN p_ISBN VARCHAR(255),
    IN p_titulo VARCHAR(255),
    IN p_descripcion TEXT,
    IN p_paginas SMALLINT,
    IN p_editorial VARCHAR(255),
    IN p_path_img VARCHAR(255),
    IN p_categoria_nombre VARCHAR(255),
    IN p_autor_nombre VARCHAR(255)
)
label:BEGIN
    DECLARE v_libro_id BIGINT;
    DECLARE v_categoria_id BIGINT;
    DECLARE v_autor_id BIGINT;
    DECLARE existe INT;

    START TRANSACTION;

    SELECT id INTO v_categoria_id
    FROM categoria
    WHERE nombre = p_categoria_nombre
    LIMIT 1;

    IF v_categoria_id IS NULL THEN
        INSERT INTO categoria(nombre) VALUES (p_categoria_nombre);
        SET v_categoria_id = LAST_INSERT_ID();
    END IF;

    SELECT id INTO v_autor_id
    FROM autor
    WHERE nombre = p_autor_nombre
    LIMIT 1;

    IF v_autor_id IS NULL THEN
        INSERT INTO autor(nombre) VALUES (p_autor_nombre);
        SET v_autor_id = LAST_INSERT_ID();
    END IF;

    -- Verificar si ya existe el libro

    SELECT count(*) INTO existe
    FROM libro
    WHERE ISBN = p_ISBN
    LIMIT 1;

    -- Si existe se cancela el insert
    IF (existe > 0) THEN
        ROLLBACK;
        LEAVE label;
    END IF;

    INSERT INTO libro (anio_publicacion, precio, ISBN, titulo, descripcion, paginas, editorial, path_img) 
    VALUES (p_anio_publicacion, p_precio, p_ISBN, p_titulo, p_descripcion, p_paginas, p_editorial, p_path_img);
    SET v_libro_id = LAST_INSERT_ID();

    INSERT INTO libro_categoria (id_categoria, id_libro) 
    VALUES (v_categoria_id, v_libro_id);

    INSERT INTO libro_autor (id_autor, id_libro) 
    VALUES (v_autor_id, v_libro_id);

    COMMIT;
    
END$$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerLibrosConPaginacion;
CREATE PROCEDURE ObtenerLibrosConPaginacion(
    IN p_categoria VARCHAR(255),
    IN p_limite INT,
    IN p_pagina INT
)
BEGIN
    DECLARE v_offset INT;

    -- Offset por pagina
    SET v_offset = (p_pagina - 1) * p_limite;

    SELECT
        l.titulo,
        l.ISBN,
        l.editorial,
        c.nombre AS categoria,
        l.precio,
        l.paginas,
        l.descripcion,
        l.path_img
    FROM
        libro l
    INNER JOIN libro_categoria lc ON l.id = lc.id_libro
    INNER JOIN categoria c ON lc.id_categoria = c.id
    WHERE c.nombre = p_categoria
--     ORDER BY l.titulo ASC
    LIMIT p_limite OFFSET v_offset;
END$$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerLibroPorISBN;
CREATE PROCEDURE ObtenerLibroPorISBN(
    IN p_ISBN VARCHAR(255)
)
BEGIN
    SELECT
        l.titulo,
        l.ISBN,
        l.editorial,
        c.nombre AS categoria,
        l.precio,
        l.paginas,
        l.descripcion,
        l.path_img
    FROM
        libro l
    INNER JOIN libro_categoria lc ON l.id = lc.id_libro
    INNER JOIN categoria c ON lc.id_categoria = c.id
    WHERE l.ISBN= p_ISBN;
END$$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerCategorias;
CREATE PROCEDURE ObtenerCategorias()
BEGIN
    SELECT
        c.nombre,
        count(*) AS count
    FROM
        categoria c
    INNER JOIN libro_categoria lc ON
        c.id = lc.id_categoria
    GROUP BY
        c.nombre;
END$$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS ContarCategoria;
CREATE PROCEDURE ContarCategoria(IN p_categoria VARCHAR(255))
BEGIN
    SELECT
        count(*) AS count
    FROM
        categoria c
    INNER JOIN libro_categoria lc ON
        c.id = lc.id_categoria
    WHERE c.nombre = p_categoria;
END$$

DELIMITER ;




-- ******************************************************************************************
-- Compra/Detalle_compra
-- ******************************************************************************************

DELIMITER $$

DROP PROCEDURE IF EXISTS RegistrarCompra$$
CREATE PROCEDURE RegistrarCompra(
    IN p_id_cliente BIGINT,
    IN p_id_vendedor BIGINT,
    IN p_fecha TIMESTAMP,
    IN p_detalles JSON
)
label:BEGIN
    DECLARE i INT;
    DECLARE n_items INT;
    DECLARE detail JSON;
    DECLARE new_compra_id BIGINT;

    -- Cliente y vendedor existen
    IF NOT EXISTS (SELECT 1 FROM cliente WHERE id = p_id_cliente) THEN
       LEAVE label;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM vendedor WHERE id = p_id_vendedor) THEN
       LEAVE label;
    END IF;

    INSERT INTO compra (id_cliente, id_vendedor, fecha)
    VALUES (p_id_cliente, p_id_vendedor, p_fecha);

    SET new_compra_id = LAST_INSERT_ID();

    -- Detalles de la compra


    SET i = 0;
    SET n_items = JSON_LENGTH(p_detalles);

    WHILE i < n_items DO
        SET detail = JSON_EXTRACT(p_detalles, CONCAT('$[', i, ']'));

        INSERT INTO detalle_compra (id_compra, id_libro, cantidad)
        VALUES (
            new_compra_id,
            JSON_UNQUOTE(JSON_EXTRACT(detail, '$.id_libro')),
            JSON_UNQUOTE(JSON_EXTRACT(detail, '$.cantidad'))
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
