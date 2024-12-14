USE libreria;

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
BEGIN
    DECLARE v_libro_id BIGINT;
    DECLARE v_categoria_id BIGINT;
    DECLARE v_autor_id BIGINT;

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
