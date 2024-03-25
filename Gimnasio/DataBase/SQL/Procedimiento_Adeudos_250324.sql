DELIMITER //

CREATE PROCEDURE llenar_tabla_adeudos_auto()
BEGIN
    -- Insertar datos en la tabla adeudos con valores predeterminados
    INSERT INTO adeudos (nombre_cliente, recurso_prestado, fecha_prestamo, fecha_devolucion_estimada, cantidad_prestada, estado_devolucion, observaciones)
    VALUES ('Juan Pérez', 'Máquina de pesas', CURDATE(), CURDATE() + INTERVAL 7 DAY, 1, 'Pendiente', 'Préstamo de máquina de pesas para entrenamiento personal');
    
    INSERT INTO adeudos (nombre_cliente, recurso_prestado, fecha_prestamo, fecha_devolucion_estimada, cantidad_prestada, estado_devolucion, observaciones)
    VALUES ('María García', 'Cinta de correr', CURDATE(), CURDATE() + INTERVAL 5 DAY, 1, 'Pendiente', 'Préstamo de cinta de correr para entrenamiento cardiovascular');
    
    INSERT INTO adeudos (nombre_cliente, recurso_prestado, fecha_prestamo, fecha_devolucion_estimada, cantidad_prestada, estado_devolucion, observaciones)
    VALUES ('Pedro Martínez', 'Banco de abdominales', CURDATE(), CURDATE() + INTERVAL 10 DAY, 1, 'Pendiente', 'Préstamo de banco de abdominales para ejercicios de abdomen');
END //

DELIMITER ;
