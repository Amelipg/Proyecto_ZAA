CREATE DEFINER=`root`@`localhost` FUNCTION `buscar_recurso_prestable_por_nombre`(nombre_recurso VARCHAR(100)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT id, nombre, descripcion, cantidad_disponible, cantidad_total, estado, fecha_adquisicion, proveedor
        FROM recursos_prestables
        WHERE nombre = nombre_recurso
    );
END