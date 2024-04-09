CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vista_recursos_prestables` AS
    SELECT 
        `recursos_prestables`.`id` AS `id`,
        `recursos_prestables`.`nombre` AS `nombre`,
        `recursos_prestables`.`descripcion` AS `descripcion`,
        `recursos_prestables`.`cantidad_disponible` AS `cantidad_disponible`,
        `recursos_prestables`.`cantidad_total` AS `cantidad_total`,
        `recursos_prestables`.`estado` AS `estado`,
        `recursos_prestables`.`fecha_adquisicion` AS `fecha_adquisicion`,
        `recursos_prestables`.`proveedor` AS `proveedor`
    FROM
        `recursos_prestables`