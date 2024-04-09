CREATE DEFINER=`root`@`localhost` FUNCTION `buscar_equipo_por_numero_serie`(num_serie VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT nombre_del_equipo, numero_de_serie, marca, modelo
        FROM equipos
        WHERE numero_de_serie = num_serie
    );
END