<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useFichajes } from "@/composables/fichajes/useFichajes";
import { useEquipos } from "@/composables/equipos/useEquipos";
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

const { oFichaje, limpiarFichaje } = useFichajes();
const { getEquipos } = useEquipos();
const { getJugadors } = useJugadors();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);

const listEquipos = ref([]);
const listJugadors = ref([]);

let form = useForm(oFichaje.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oFichaje.value);
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
        cargarListas();
    }
);

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Agregar Fichaje` : `Editar Fichaje`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("fichajes.store")
            : route("fichajes.update", form.id);

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
            limpiarFichaje();
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
    if (form.id != "" && form.id != 0) {
        console.log("AA");
        listJugadors.value = await getJugadors({
            sin_fichaje: true,
            id: form.jugador_id,
        });
    } else {
        console.log("BBB");
        listJugadors.value = await getJugadors({
            sin_fichaje: true,
        });
    }
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
                                            form.errors?.nro_polera
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_polera
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_polera
                                                ? form.errors?.nro_polera
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        min="1"
                                        variant="outlined"
                                        label="Número de Polera*"
                                        required
                                        density="compact"
                                        v-model="form.nro_polera"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_fichaje
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_fichaje
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_fichaje
                                                ? form.errors?.fecha_fichaje
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Fecha de Fichaje*"
                                        v-model="form.fecha_fichaje"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.contrato_hasta
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.contrato_hasta
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.contrato_hasta
                                                ? form.errors?.contrato_hasta
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Contrato Hasta*"
                                        v-model="form.contrato_hasta"
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
