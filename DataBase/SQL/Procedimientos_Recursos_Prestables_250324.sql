DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenar_tabla_recursos_prestables`()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 10 DO  -- Cambia 10 por la cantidad de filas que deseas insertar
        INSERT INTO recursos_prestables (nombre, descripcion, cantidad_disponible, cantidad_total, estado, fecha_adquisicion, proveedor, precio_unitario)
        VALUES (
            CONCAT('Recurso', i),
            CONCAT('Descripción del recurso ', i),
            FLOOR(RAND() * 100) + 1, -- Cantidad disponible aleatoria entre 1 y 100
            FLOOR(RAND() * 200) + 100, -- Cantidad total aleatoria entre 100 y 300
            CASE FLOOR(RAND() * 3)  -- Estado aleatorio
                WHEN 0 THEN 'Buen estado'
                WHEN 1 THEN 'Estado regular'
                WHEN 2 THEN 'Necesita reparación'
            END,
            CURDATE() - INTERVAL FLOOR(RAND() * 365) DAY, -- Fecha de adquisición aleatoria en el último año
            CONCAT('Proveedor', i),
            ROUND(RAND() * 100, 2)  -- Precio unitario aleatorio entre 0 y 100
        );
        SET i = i + 1;
    END WHILE;
END