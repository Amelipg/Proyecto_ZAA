-- TRIGGERS DE LA TABLA equipos
-- insert
DELIMITER $$
CREATE TRIGGER after_insert_equipos
AFTER INSERT ON equipos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_equipos (accion, detalle, fecha) 
    VALUES ('Inserción', CONCAT('Se insertó un nuevo registro en la tabla equipos con nombre: ', NEW.nombre_del_equipo), NOW());
END$$

-- update
DELIMITER $$
CREATE TRIGGER after_update_equipos
AFTER UPDATE ON equipos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_equipos (accion, detalle, fecha) 
    VALUES ('Actualización', CONCAT('Se actualizó un registro en la tabla equipos con nombre: ', OLD.nombre_del_equipo), NOW());
END $$

-- delete 
DELIMITER $$
CREATE TRIGGER after_delete_equipos
AFTER DELETE ON equipos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_equipos (accion, detalle, fecha) 
    VALUES ('Eliminación', CONCAT('Se eliminó un registro en la tabla equipos con nombre: ', OLD.nombre_del_equipo), NOW());
END$$

-- ------------------------------------------------------------------------------
-- TRIGGERS DE LA TABLA Adeudos
-- insert
DELIMITER $$
CREATE TRIGGER tr_insert_adeudos
AFTER INSERT ON adeudos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (tipo_operacion, nombre_cliente, recurso_prestado, fecha_prestamo, fecha_devolucion_estimada, cantidad_prestada, estado_devolucion, observaciones)
    VALUES ('INSERT', NEW.nombre_cliente, NEW.recurso_prestado, NEW.fecha_prestamo, NEW.fecha_devolucion_estimada, NEW.cantidad_prestada, NEW.estado_devolucion, NEW.observaciones);
END$$

-- delete
DELIMITER $$
CREATE TRIGGER tr_delete_adeudos
AFTER DELETE ON adeudos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (tipo_operacion, nombre_cliente, recurso_prestado, fecha_prestamo, fecha_devolucion_estimada, cantidad_prestada, estado_devolucion, observaciones)
    VALUES ('DELETE', OLD.nombre_cliente, OLD.recurso_prestado, OLD.fecha_prestamo, OLD.fecha_devolucion_estimada, OLD.cantidad_prestada, OLD.estado_devolucion, OLD.observaciones);
END$$

-- update
DELIMITER $$
CREATE TRIGGER tr_update_adeudos
AFTER UPDATE ON adeudos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (tipo_operacion, nombre_cliente, recurso_prestado, fecha_prestamo, fecha_devolucion_estimada, cantidad_prestada, estado_devolucion, observaciones)
    VALUES ('UPDATE', NEW.nombre_cliente, NEW.recurso_prestado, NEW.fecha_prestamo, NEW.fecha_devolucion_estimada, NEW.cantidad_prestada, NEW.estado_devolucion, NEW.observaciones);
END $$
-- ----------------------------------------------------------------------
-- TRIGGERS DE LA TABLA consumibles
-- insert
DELIMITER $$
CREATE TRIGGER tr_insert_consumibles
AFTER INSERT ON consumibles
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, tabla_afectada, fecha)
    VALUES ('Inserción', 'consumibles', NOW());
END$$

-- delete
DELIMITER $$
CREATE TRIGGER tr_delete_consumibles
AFTER DELETE ON consumibles
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, tabla_afectada, fecha)
    VALUES ('Eliminación', 'consumibles', NOW());
END$$

-- update
DELIMITER $$
CREATE TRIGGER tr_update_consumibles
AFTER UPDATE ON consumibles
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, tabla_afectada, fecha)
    VALUES ('Actualización', 'consumibles', NOW());
END$$
-- -----------------------------------------------------------------
-- TRIGGERS DE LA TABLA equipos_existentes 
-- insert
DELIMITER $$
CREATE TRIGGER equipos_insert_trigger AFTER INSERT ON equipos_existentes
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, descripcion, fecha)
    VALUES ('INSERCIÓN', CONCAT('Se insertó un nuevo equipo con nombre: ', NEW.nombre_del_equipo), NOW());
END$$

-- delete
DELIMITER $$
CREATE TRIGGER equipos_delete_trigger AFTER DELETE ON equipos_existentes
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, descripcion, fecha)
    VALUES ('ELIMINACIÓN', CONCAT('Se eliminó un equipo con nombre: ', OLD.nombre_del_equipo), NOW());
END$$

-- update 
DELIMITER $$
CREATE TRIGGER equipos_update_trigger AFTER UPDATE ON equipos_existentes
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, descripcion, fecha)
    VALUES ('ACTUALIZACIÓN', CONCAT('Se actualizó un equipo con nombre: ', OLD.nombre_del_equipo), NOW());
END$$

-- --------------------------------------------

-- TRIGGERS DE LA TABLA mantenimiento
-- insert
DELIMITER $$
CREATE TRIGGER insertar_mantenimiento_bitacora AFTER INSERT ON mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, tabla_afectada, fecha) VALUES ('Inserción', 'mantenimiento', NOW());
END$$

-- delete
DELIMITER $$
CREATE TRIGGER eliminar_mantenimiento_bitacora AFTER DELETE ON mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, tabla_afectada, fecha) VALUES ('Eliminación', 'mantenimiento', NOW());
END$$

-- update
DELIMITER $$
CREATE TRIGGER actualizar_mantenimiento_bitacora AFTER UPDATE ON mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (accion, tabla_afectada, fecha) VALUES ('Actualización', 'mantenimiento', NOW());
END$$

-- --------------------------------------
-- TRIGGERS DE LA TABLA  recursos_prestables
DELIMITER $$
-- insert
CREATE TRIGGER after_insert_recursos_prestables
AFTER INSERT ON recursos_prestables
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (tipo_operacion, tabla_afectada)
    VALUES ('INSERT', 'recursos_prestables');
END$$

-- delete
DELIMITER $$
CREATE TRIGGER after_delete_recursos_prestables
AFTER DELETE ON recursos_prestables
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (tipo_operacion, tabla_afectada)
    VALUES ('DELETE', 'recursos_prestables');
END$$

-- update
DELIMITER $$
CREATE TRIGGER after_update_recursos_prestables
AFTER UPDATE ON recursos_prestables
FOR EACH ROW
BEGIN
    INSERT INTO bitacora (tipo_operacion, tabla_afectada)
    VALUES ('UPDATE', 'recursos_prestables');
END$$


