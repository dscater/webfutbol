<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useEquipos } from "@/composables/equipos/useEquipos";
import { watch, ref, computed, defineEmits } from "vue";
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

const { oEquipo, limpiarEquipo } = useEquipos();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oEquipo.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oEquipo.value);
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
    return accion.value == 0 ? `Agregar Equipo` : `Editar Equipo`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("equipos.store")
            : route("equipos.update", form.id);

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
            limpiarEquipo();
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
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nombre ? false : true
                                        "
                                        :error="
                                            form.errors?.nombre ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.nombre
                                                ? form.errors?.nombre
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Nombre del Equipo*"
                                        required
                                        density="compact"
                                        v-model="form.nombre"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nombre_p ? false : true
                                        "
                                        :error="
                                            form.errors?.nombre_p ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.nombre_p
                                                ? form.errors?.nombre_p
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Nombre completo del Presidente*"
                                        v-model="form.nombre_p"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nombre_e ? false : true
                                        "
                                        :error="
                                            form.errors?.nombre_e ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.nombre_e
                                                ? form.errors?.nombre_e
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Nombre completo del Entrenador*"
                                        v-model="form.nombre_e"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.colores ? false : true
                                        "
                                        :error="
                                            form.errors?.colores ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.colores
                                                ? form.errors?.colores
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Colores"
                                        v-model="form.colores"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.ubicacion
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.ubicacion
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.ubicacion
                                                ? form.errors?.ubicacion
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Ubicación"
                                        v-model="form.ubicacion"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input
                                        :hide-details="
                                            form.errors?.logo ? false : true
                                        "
                                        :error="
                                            form.errors?.logo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.logo
                                                ? form.errors?.logo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        accept="image/png, image/jpeg, image/bmp"
                                        placeholder="Logo"
                                        prepend-icon="mdi-camera"
                                        label="Logo"
                                        @change="cargaArchivo($event, 'logo')"
                                        ref="logo"
                                    ></v-file-input>
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
