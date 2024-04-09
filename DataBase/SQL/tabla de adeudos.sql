CREATE TABLE adeudos(
id int primary key auto_increment not null ,
nombre_cliente varchar(100),
recurso_prestado varchar(100),
fecha_prestamo date,
fecha_devolucion_estimada date,
cantidad_prestada int,
estado_devolucion varchar(50),
observaciones text);
