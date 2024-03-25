DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenar_tabla_mantenimiento`()
BEGIN
    -- Insertar datos en la tabla mantenimiento con valores predeterminados o funciones
    INSERT INTO mantenimiento (descripcion_del_trabajo_realizado, fecha_de_mantenimiento, estado_del_equipo_despues_del_mantenimiento)
    VALUES ('Trabajo realizado automáticamente', CURRENT_DATE(), 'Excelente');
END