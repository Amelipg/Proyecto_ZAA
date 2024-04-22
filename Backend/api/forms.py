from django import forms
from .models import Equipo

class EquipoForm(forms.ModelForm):
    """Form for the image model"""
    class Meta:
        model = Equipo
        fields = ('nombre','descripción','marca','modelo','especificaciones','fotografía','total_existencia','estatus')