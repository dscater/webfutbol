<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useJugadorTitulos } from "@/composables/jugador_titulos/useJugadorTitulos";
import { useJugadors } from "@/composables/jugadors/useJugadors";
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

const { oJugadorTitulo, limpiarJugadorTitulo } = useJugadorTitulos();
const { getJugadors } = useJugadors();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);

const listJugadors = ref([]);
const listTipos = ref([
    { value: "INTERNACIONAL", label: "INTERNACIONAL" },
    { value: "NACIONAL", label: "NACIONAL" },
]);

let form = useForm(oJugadorTitulo.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oJugadorTitulo.value);
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
    return accion.value == 0 ? `Agregar Título de Jugador` : `Editar Título de Jugador`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("jugador_titulos.store")
            : route("jugador_titulos.update", form.id);

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
            limpiarJugadorTitulo();
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
    listJugadors.value = await getJugadors();
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
                                            form.errors?.jugador_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.jugador_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.jugador_id
                                                ? form.errors?.jugador_id
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listJugadors"
                                        label="Seleccionar Jugador*"
                                        item-value="id"
                                        item-title="full_name"
                                        v-model="form.jugador_id"
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
