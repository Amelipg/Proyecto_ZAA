DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenar_tabla_consumibles`()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 10 DO 
        INSERT INTO consumibles (nombre, cantidad, unidad_medida, fecha_de_vencimiento, proveedor, precio_unitario)
        VALUES (
            CONCAT('Producto', i),
            FLOOR(RAND() * 100) + 1, -- Genera una cantidad aleatoria entre 1 y 100
            CASE FLOOR(RAND() * 3)  -- Genera una unidad de medida aleatoria
                WHEN 0 THEN 'Unidades'
                WHEN 1 THEN 'Litros'
                WHEN 2 THEN 'Kilos'
            END,
            CURDATE() + INTERVAL FLOOR(RAND() * 365) DAY, -- Fecha de vencimiento aleatoria dentro del próximo año
            CONCAT('Proveedor', i),
            ROUND(RAND() * 100, 2)  -- Precio unitario aleatorio entre 0 y 100
        );
        SET i = i + 1;
    END WHILE;
END