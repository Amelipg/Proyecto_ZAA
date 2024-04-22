<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useContactStore } from '@/stores/apps/contact';
import contact from '@/_mockApis/apps/contact';

const rules = ref([
    (value: { size: number }) =>
        !value || value.size < 2000000 || "¡El tamaño de la imagen debe ser menor a 2 MB!",
]);

const items = ref(["Disponible", "Mantenimiento"]);

const store = useContactStore();

onMounted(() => {
    store.fetchContacts();
});
const getContacts: any = computed(() => {
    return store.contacts;
});

const valid = ref(true);
const dialog = ref(false);
const dialogEdit = ref(false);
const search = ref('');
const rolesbg = ref(['primary', 'secondary', 'error', 'success', 'warning']);
const desserts = ref(contact);
const editedIndex = ref(-1);
const datos_equipo = ref({
    id: '',
    nombre: '',
    descripción: '',
    marca: '',
    modelo: '',
    especificaciones: '',
    total_existencia: 0,
    fotografía: '',
    estatus: '',
});

const validarNumero = (event) => {
    let value = parseInt(event.target.value.replace('e', ''));
    if (value < 0) {
        datos_equipo.value.total_existencia = 0;
    }
    datos_equipo.value.total_existencia = value
}

const handleFileChange = (event) => {
    const fileList = event.target.files;
    // Supongamos que solo estás interesado en la primera imagen seleccionada
    if (fileList.length > 0) {
        const file = fileList[0];

        datos_equipo.value.fotografía = file;
    }
};

const defaultItem = ref({
    id: '',
    nombre: '',
    descripción: '',
    marca: '',
    modelo: '',
    especificaciones: '',
    total_existencia: 0,
    fotografía: '',
    estatus: '',
});

//Methods
const filteredList = computed(() => {
    return desserts.value.filter((user: any) => {
        return user.nombre.toLowerCase().includes(search.value.toLowerCase());
    });
});

function editItem(item: any) {
    editedIndex.value = desserts.value.indexOf(item);
    datos_equipo.value = Object.assign({}, item);
    dialogEdit.value = true;
}

async function deleteItem(item: any) {
    const index = desserts.value.indexOf(item);
    datos_equipo.value = Object.assign({}, item);
    confirm('¿Estas seguro que quiere eliminar este Equipo?') &&
        console.log(datos_equipo.value)
    await fetch('http://localhost:8000/gimnasio/api/v1Equipo/' + datos_equipo.value.id + '/', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Error al eliminar el recurso');
            }
            return response.json();
        })
        .then(data => {
            console.log('Recurso eliminado correctamente:', data);
        })
        .catch(error => {
            console.error('Error al enviar la solicitud DELETE:', error);
        });
    desserts.value.splice(index, 1);
}

function close(option) {
    if (option == 1) {
        dialog.value = false;
    } else {
        dialogEdit.value = false;
    }
    setTimeout(() => {
        datos_equipo.value = Object.assign({}, defaultItem.value);
        editedIndex.value = -1;
    }, 300);
}
async function save(option) {
    if (editedIndex.value > -1) {
        Object.assign(desserts.value[editedIndex.value], datos_equipo.value);
    } else {
        if (option == 1) {
            const formData = new FormData();
            formData.append('nombre', datos_equipo.value.nombre);
            formData.append('descripción', datos_equipo.value.descripción);
            formData.append('marca', datos_equipo.value.marca);
            formData.append('modelo', datos_equipo.value.modelo);
            formData.append('especificaciones', datos_equipo.value.especificaciones);
            formData.append('total_existencia', datos_equipo.value.total_existencia);
            formData.append('estatus', datos_equipo.value.estatus);
            formData.append('fotografía', datos_equipo.value.fotografía);

            await fetch('http://localhost:8000/gimnasio/upload/', {
                method: 'POST',
                body: formData,
            }).then(res => {
                if (!res.ok) {
                    throw new Error('Error al insertar los datos al servidor: ' + res.statusText);
                }
                // No necesitas analizar la respuesta como JSON, ya que es simplemente un mensaje de texto
                return res.json();
            }).then(data => {
                // Verificar si la respuesta contiene el ID del último registro insertado
                if (data && data.last_inserted_id) {
                    datos_equipo.value.id = data.last_inserted_id;
                    desserts.value.push(datos_equipo.value);
                    // Hacer algo con el ID, como mostrarlo en la interfaz de usuario
                } else {
                    console.error('La respuesta del servidor no contiene el ID del último registro insertado.');
                }
            }).catch(error => {
                console.error('Error al enviar los datos al servidor: ' + error);
                return error;
            });
        } else {
            await fetch('http://localhost:8000/gimnasio/api/v1Equipo/' + datos_equipo.value.id + '/', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(datos_equipo.value),
            }).then(res => {
                if (!res.ok) {
                    throw new Error('Error al insertar los datos al servidor: ' + res.json());
                }

                return res.json();
            }).then(data => {
                // Verificar si la respuesta contiene el ID del último registro insertado
                if (data && data.last_inserted_id) {
                    datos_equipo.value.id = data.last_inserted_id;
                    desserts.value.push(datos_equipo.value);
                    // Hacer algo con el ID, como mostrarlo en la interfaz de usuario
                } else {
                    console.error('La respuesta del servidor no contiene el ID del último registro insertado.');
                }
            })
                .catch(error => {
                    console.error('Error al enviar los datos al servidor: ' + error.message);
                    return error.message
                });

        }
    }

    close(option);
}

//Computed Property
const formTitle = computed(() => {
    if (dialog.value) {
        datos_equipo.value = {
            id: '',
            nombre: '',
            descripción: '',
            marca: '',
            modelo: '',
            especificaciones: '',
            total_existencia: 0,
            fotografía: '',
            estatus: '',
        }
        return 'Agregar Equipo'
    } else {
        return 'Editar Equipo'
    }
});
</script>
<template>
    <v-row>
        <v-col cols="12" lg="4" md="6">
            <v-text-field density="compact" v-model="search" label="Buscar Equipos" hide-details
                variant="outlined"></v-text-field>
        </v-col>
        <v-col cols="12" lg="8" md="6" class="text-right">
            <v-dialog v-model="dialog" max-width="500">
                <template v-slot:activator="{ props }">
                    <v-btn color="secondary" v-bind="props" flat class="ml-auto">
                        <v-icon class="mr-2">mdi-account-multiple-plus</v-icon>Agregar Equipo
                    </v-btn>
                </template>
                <v-card>
                    <v-card-title class="pa-4 bg-secondary">
                        <span class="title text-white">{{ formTitle }}</span>
                    </v-card-title>

                    <v-card-text>
                        <v-form ref="form" v-model="valid" lazy-validation>
                            <v-row>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.nombre"
                                        label="Nombre Equipo" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.descripción"
                                        label="Descripcion" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.marca"
                                        label="Marca" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.modelo"
                                        label="Modelo" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details
                                        v-model="datos_equipo.especificaciones" label="Especificaciones"
                                        type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details
                                        v-model="datos_equipo.total_existencia" label="Cantidad" type="number"
                                        @input="validarNumero"></v-text-field>
                                </v-col>
                                <v-col>
                                    <div>
                                        <v-file-input :rules="rules"
                                            accept="image/png, image/jpeg, image/jpg, image/bmp"
                                            placeholder="Escoge una imagen" prepend-icon="mdi-camera" variant="outlined"
                                            label="Imagen" hide-details @change="handleFileChange"></v-file-input>
                                    </div>
                                </v-col>
                                <v-col>
                                    <v-select v-model="datos_equipo.estatus" :items="items" label="Select Item"
                                        hide-details></v-select>
                                </v-col>
                            </v-row>
                        </v-form>
                    </v-card-text>

                    <v-card-actions class="pa-4">
                        <v-spacer></v-spacer>
                        <v-btn color="error" @click="close(1)">Cancelar</v-btn>
                        <v-btn color="secondary" :disabled="datos_equipo.nombre == '' ||
                datos_equipo.descripción == '' ||
                datos_equipo.descripción == '' ||
                datos_equipo.marca == '' ||
                datos_equipo.modelo == '' ||
                datos_equipo.especificaciones == '' ||
                datos_equipo.total_existencia == 0 ||
                datos_equipo.fotografía == ''" variant="flat" @click="save(1)">Guardar</v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
            <v-dialog v-model="dialogEdit" max-width="500">
                <v-card>
                    <v-card-title class="pa-4 bg-secondary">
                        <span class="title text-white">{{ formTitle }}</span>
                    </v-card-title>

                    <v-card-text>
                        <v-form ref="form" v-model="valid" lazy-validation>
                            <v-row>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.nombre"
                                        label="Nombre Equipo" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.descripción"
                                        label="Descripcion" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.marca"
                                        label="Marca" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="datos_equipo.modelo"
                                        label="Modelo" type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details
                                        v-model="datos_equipo.especificaciones" label="Especificaciones"
                                        type="text"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details
                                        v-model="datos_equipo.total_existencia" label="Cantidad" type="number"
                                        @input="validarNumero"></v-text-field>
                                </v-col>
                                <v-col>
                                    <div>
                                        <v-file-input :rules="rules" accept="image/png, image/jpeg, image/bmp"
                                            placeholder="Escoge una imagen" prepend-icon="mdi-camera" variant="outlined"
                                            label="Imagen" hide-details @change="handleFileChange"></v-file-input>
                                    </div>
                                </v-col>
                                <v-col>
                                    <v-select v-model="datos_equipo.estatus" :items="items" label="Select Item"
                                        hide-details></v-select>
                                </v-col>
                            </v-row>
                        </v-form>
                    </v-card-text>

                    <v-card-actions class="pa-4">
                        <v-spacer></v-spacer>
                        <v-btn color="error" @click="close(2)">Cancelar</v-btn>
                        <v-btn color="secondary" :disabled="datos_equipo.nombre == '' ||
                datos_equipo.descripción == '' ||
                datos_equipo.descripción == '' ||
                datos_equipo.marca == '' ||
                datos_equipo.modelo == '' ||
                datos_equipo.especificaciones == '' ||
                datos_equipo.total_existencia == 0 ||
                datos_equipo.fotografía == ''" variant="flat" @click="save(2)">Guardar</v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-col>
    </v-row>
    <v-table class="mt-5">
        <thead>
            <tr>
                <th class="text-subtitle-1 font-weight-semibold">Id</th>
                <th class="text-subtitle-1 font-weight-semibold">Equipo</th>
                <th class="text-subtitle-1 font-weight-semibold">Descripcion</th>
                <th class="text-subtitle-1 font-weight-semibold">Marca</th>
                <th class="text-subtitle-1 font-weight-semibold">Modelo</th>
                <th class="text-subtitle-1 font-weight-semibold">Especificaciones</th>
                <th class="text-subtitle-1 font-weight-semibold">Cantidad</th>
                <th class="text-subtitle-1 font-weight-semibold">Estatus</th>
                <th class="text-subtitle-1 font-weight-semibold">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="item in filteredList" :key="item.id">
                <td class="text-subtitle-1">{{ item.id }}</td>
                <td class="text-subtitle-1">{{ item.nombre }}</td>
                <td class="text-subtitle-1">{{ item.descripción }}</td>
                <td class="text-subtitle-1">{{ item.marca }}</td>
                <td class="text-subtitle-1">{{ item.modelo }}</td>
                <td class="text-subtitle-1">{{ item.especificaciones }}</td>
                <td class="text-subtitle-1">{{ item.total_existencia }}</td>
                <td class="text-subtitle-1">{{ item.estatus }}</td>
                <td>
                    <div class="d-flex align-center">
                        <v-tooltip text="Editar">
                            <template v-slot:activator="{ props }">
                                <v-btn icon flat @click="editItem(item)" v-bind="props">
                                    <PencilIcon stroke-width="1.5" size="20" class="text-primary" />
                                </v-btn>
                            </template>
                        </v-tooltip>
                        <v-tooltip text="Eliminar">
                            <template v-slot:activator="{ props }">
                                <v-btn icon flat @click="deleteItem(item)" v-bind="props">
                                    <TrashIcon stroke-width="1.5" size="20" class="text-error" />
                                </v-btn>
                            </template>
                        </v-tooltip>
                    </div>
                </td>
            </tr>
        </tbody>
    </v-table>
</template>