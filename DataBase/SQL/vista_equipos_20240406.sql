CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vista_equipos` AS
    SELECT 
        `equipos`.`nombre_del_equipo` AS `nombre_del_equipo`,
        `equipos`.`numero_de_serie` AS `numero_de_serie`,
        `equipos`.`marca` AS `marca`,
        `equipos`.`modelo` AS `modelo`
    FROM
        `equipos`