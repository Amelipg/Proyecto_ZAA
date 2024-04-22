from rest_framework import viewsets
from .serializer import *
from .models import Equipo
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .forms import EquipoForm
import os
from django.core.files.storage import FileSystemStorage

class sucursalviewset(viewsets.ModelViewSet):
	queryset = Sucursal.objects.all()
	serializer_class = sucursalesserializer
 

 
class miembro_adeudosviewset(viewsets.ModelViewSet):
	queryset = MiembroAdeudos.objects.all()
	serializer_class = miembros_adeudosserializer
 
class mantenimientoviewset(viewsets.ModelViewSet):
	queryset = Mantenimiento.objects.all()
	serializer_class = mantenimientosserializer
 
class prestamoviewset(viewsets.ModelViewSet):
	queryset = Prestamo.objects.all()
	serializer_class = prestamosserializer
 
class consumibleviewset(viewsets.ModelViewSet):
	queryset = Consumible.objects.all()
	serializer_class = consumiblesserializer
 
class equipoviewset(viewsets.ModelViewSet):
	queryset = Equipo.objects.all()
	serializer_class = equiposserializer
 
class equipo_existenciaviewset(viewsets.ModelViewSet):
	queryset = EquipoExistencia.objects.all()
	serializer_class = equipos_existenciaserializer

@csrf_exempt
def image_upload_view(req):
	if req.method == 'POST':
		if 'fotografía' in req.FILES:
			form = EquipoForm(req.POST, req.FILES)
			if form.is_valid():
				# Guarda el archivo en una ubicación específica
				archivo = req.FILES['fotografía']
				fs = FileSystemStorage(location=os.path.join(os.path.dirname(os.path.dirname(_file_)), '..', 'Frontend', 'Gym-ZAA', 'src', 'assets', 'images','products'))
				nombre_archivo = fs.save(archivo.name, archivo)

				# Guarda los datos del formulario, incluida la URL del archivo guardado
				equipo = form.save(commit=False)
				equipo.fotografía = os.path.join('assets', 'images','products', nombre_archivo)
				equipo.save()
				last_inserted_id = Equipo.objects.latest('id').id
				return JsonResponse({'last_inserted_id': last_inserted_id})
			else:
    	    	# Manejar el caso en el que no se proporciona ningún archivo
				return HttpResponse("No se proporcionó ningún archivo para cargar.")
		else:
			return HttpResponse("El campo 'fotografía' no está presente en la solicitud.")
	else:
		return HttpResponse('Este endpoint solo acepta peticiones POST.')