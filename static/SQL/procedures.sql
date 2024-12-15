USE libreria;

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
--             p_niveles_educativos,
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