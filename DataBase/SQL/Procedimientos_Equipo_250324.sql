DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenar_tabla_equipos`()
BEGIN
    -- Insertar datos en la tabla equipos
    INSERT INTO equipos (nombre_del_equipo, numero_de_serie, marca, modelo)
    VALUES 
        ('Caminadora', 'SER123', 'MarcaX', 'ModeloA'),
        ('Bicicleta estática', 'SER456', 'MarcaY', 'ModeloB'),
        ('Máquina de pesas', 'SER789', 'MarcaZ', 'ModeloC');
END