DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenar_tabla_equipos_existentes`()
BEGIN
    -- Insertar datos en la tabla equipos_existentes
    INSERT INTO equipos_existentes (nombre_del_equipo, descripcion_del_equipo, ubicacion_fisica, fecha_de_compra, fecha_de_instalacion)
    VALUES 
        ('Máquina de pesas', 'Descripción de la máquina de pesas', 'Gimnasio 1', '2024-03-24', '2024-03-25'),
        ('Cinta de correr', 'Descripción de la cinta de correr', 'Gimnasio 2', '2024-03-25', '2024-03-26'),
        ('Banco de abdominales', 'Descripción del banco de abdominales', 'Gimnasio 1', '2024-03-26', '2024-03-27');
END