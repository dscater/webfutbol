<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useEquipoTitulos } from "@/composables/equipo_titulos/useEquipoTitulos";
import { useEquipos } from "@/composables/equipos/useEquipos";
import { watch, ref, computed, defineEmits, onMounted } from "vue";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oEquipoTitulo, limpiarEquipoTitulo } = useEquipoTitulos();
const { getEquipos } = useEquipos();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);

const listEquipos = ref([]);
const listTipos = ref([
    { value: "INTERNACIONAL", label: "INTERNACIONAL" },
    { value: "NACIONAL", label: "NACIONAL" },
]);

let form = useForm(oEquipoTitulo.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oEquipoTitulo.value);
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash } = usePage().props;

const logo = ref(null);
function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Agregar EquipoTitulo` : `Editar EquipoTitulo`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("equipo_titulos.store")
            : route("equipo_titulos.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarEquipoTitulo();
            emits("envio-formulario");
        },
        onError: (err) => {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
    });
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
};

const cargarListas = async () => {
    listEquipos.value = await getEquipos();
};

onMounted(() => {
    cargarListas();
});
</script>

<template>
    <v-row justify="center">
        <v-dialog v-model="dialog" width="1024" persistent scrollable>
            <v-card>
                <v-card-title class="border-b bg-primary pa-5">
                    <v-icon
                        icon="mdi-close"
                        class="float-right"
                        @click="cerrarDialog"
                    ></v-icon>

                    <v-icon
                        :icon="accion == 0 ? 'mdi-plus' : 'mdi-pencil'"
                    ></v-icon>
                    <span class="text-h5" v-html="tituloDialog"></span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <form>
                            <v-row>
                                <v-col cols="12" sm="6" md="4">
                                    <v-select
                                        :hide-details="
                                            form.errors?.equipo_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.equipo_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.equipo_id
                                                ? form.errors?.equipo_id
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listEquipos"
                                        label="Seleccionar Equipo*"
                                        item-value="id"
                                        item-title="nombre"
                                        v-model="form.equipo_id"
                                        required
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.titulo ? false : true
                                        "
                                        :error="
                                            form.errors?.titulo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.titulo
                                                ? form.errors?.titulo
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Nombre del Título*"
                                        required
                                        density="compact"
                                        v-model="form.titulo"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.anio ? false : true
                                        "
                                        :error="
                                            form.errors?.anio ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.anio
                                                ? form.errors?.anio
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Año*"
                                        v-model="form.anio"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha ? false : true
                                        "
                                        :error="
                                            form.errors?.fecha ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha
                                                ? form.errors?.fecha
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Fecha"
                                        v-model="form.fecha"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.descripcion
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.descripcion
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.descripcion
                                                ? form.errors?.descripcion
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Descripción"
                                        v-model="form.descripcion"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-select
                                        :hide-details="
                                            form.errors?.tipo ? false : true
                                        "
                                        :error="
                                            form.errors?.tipo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.tipo
                                                ? form.errors?.tipo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listTipos"
                                        label="Tipo de Título*"
                                        item-value="value"
                                        item-title="label"
                                        v-model="form.tipo"
                                        required
                                    ></v-select>
                                </v-col>
                            </v-row>
                        </form>
                    </v-container>
                </v-card-text>
                <v-card-actions class="border-t">
                    <v-spacer></v-spacer>
                    <v-btn
                        color="grey-darken-4"
                        variant="text"
                        @click="cerrarDialog"
                    >
                        Cancelar
                    </v-btn>
                    <v-btn
                        class="bg-primary"
                        prepend-icon="mdi-content-save"
                        @click="enviarFormulario"
                    >
                        Guardar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>
