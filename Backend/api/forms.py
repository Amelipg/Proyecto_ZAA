from django import forms
from .models import Equipo

class EquipoForm(forms.ModelForm):
    """Form for the image model"""
    class Meta:
        model = Equipo
        fields = ('nombre','descripcion','marca','modelo','especificaciones','fotografia','total_existencia','estatus')