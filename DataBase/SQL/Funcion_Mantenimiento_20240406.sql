CREATE DEFINER=`root`@`localhost` FUNCTION `buscar_mantenimiento_por_fecha`(fecha_mantenimiento DATE) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT descripcion_del_trabajo_realizado, fecha_de_mantenimiento, estado_del_equipo_despues_del_mantenimiento
        FROM mantenimiento
        WHERE fecha_de_mantenimiento = fecha_mantenimiento
    );
END