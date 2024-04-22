from django.urls import path,include
from rest_framework import routers
from api import views 
# from .views import sucursalviewset, miembroviewset, miembros_adeudosserializer, mantenimientoviewset, prestamoviewset, consumibleviewset, equipo_existenciaviewset, equipoviewset

router = routers.DefaultRouter()
router.register(r'Sucursal', views.sucursalviewset)
router.register(r'MiembroAdeudos', views.miembro_adeudosviewset)
router.register(r'Mantenimiento', views.mantenimientoviewset)
router.register(r'Prestamo', views.prestamoviewset)
router.register(r'Consumible', views.consumibleviewset)
router.register(r'Equipo', views.equipoviewset)
router.register(r'EquipoExistencia', views.equipo_existenciaviewset)

urlpatterns = [
	path('api/v1',include(router.urls)),
    path('upload/', views.image_upload_view)
]