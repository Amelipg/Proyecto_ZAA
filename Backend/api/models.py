from django.db import models

class MiembroAdeudos(models.Model):
    nombre_cliente = models.CharField(max_length=100)
    recurso_prestado = models.CharField(max_length=100)
    fecha_prestamo = models.DateField()
    fecha_devolucion_estimada = models.DateField()
    cantidad_prestada = models.DecimalField(max_digits=10, decimal_places=2)
    estado_devolucion = models.CharField(max_length=50)
    observaciones = models.TextField()
    class Meta:
        db_table = 'miembros'
    def _str_(self):
        return self.nombre_cliente


class Prestamo(models.Model):
    descripcion = models.TextField()
    cantidad_disponible = models.DecimalField(max_digits=10, decimal_places=2)
    cantidad_total = models.DecimalField(max_digits=10, decimal_places=2)
    estado = models.CharField(max_length=50)
    fecha_adquisicion = models.DateField()
    proveedor = models.CharField(max_length=100)
    class Meta:
        db_table = 'prestamos'
    

class Sucursal(models.Model):
    nombre = models.CharField(max_length=100)
    direccion = models.TextField()
    responsable_id = models.IntegerField()
    total_clientes_atendidos = models.IntegerField()
    promedio_clientes_x_dia = models.DecimalField(max_digits=10, decimal_places=2)
    capacidad_maxima = models.IntegerField()
    total_empleados = models.IntegerField()
    horario_disponibilidad = models.CharField(max_length=100)
    Estatus = models.BooleanField(default=False)
    class Meta:
        db_table = 'sucursales'
    

class EquipoExistencia(models.Model):
    Equipo_ID = models.IntegerField()
    Area_ID = models.IntegerField()
    Color = models.CharField(max_length=50)
    Estatus = models.BooleanField(default=False)
    Fecha_Asignacion = models.DateField()
    class Meta:
        db_table = 'equipos_existencias'

class Mantenimiento(models.Model):
    descripcion_del_trabajo_realizado = models.TextField()
    fecha_de_mantenimiento = models.DateField()
    estado_del_equipo_despues_del_mantenimiento = models.CharField(max_length=50)
    Mantenimiento_ID = models.IntegerField()
    class Meta:
        db_table = 'mantenimiento'

class Consumible(models.Model):
    nombre = models.CharField(max_length=100)
    cantidad = models.DecimalField(max_digits=10, decimal_places=2)
    unidad_medida = models.CharField(max_length=50)
    fecha_de_vencimiento = models.DateField()
    proveedor = models.CharField(max_length=100)
    class Meta:
        db_table = 'consumibles'

class Equipo(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    marca = models.CharField(max_length=100)
    modelo = models.CharField(max_length=100)
    especificaciones = models.TextField()
    fotografia = models.ImageField(upload_to='assets/imagenes/', blank=True, null=True)
    total_existencia = models.IntegerField()
    estatus = models.CharField(max_length=100, choices=(
        ('Disponible', 'Disponible'),
        ('Agotado', 'Agotado'),
        ('Mantenimiento', 'Mantenimiento')
    ), default='Disponible')
    class Meta:
        db_table = 'equipos'