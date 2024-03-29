<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useJugadors } from "@/composables/jugadors/useJugadors";
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

const { oJugador, limpiarJugador } = useJugadors();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oJugador.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oJugador.value);
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

const foto = ref(null);
function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Agregar Jugador` : `Editar Jugador`;
});

const enviando = ref(false);

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form["_method"] == "POST"
            ? route("jugadors.store")
            : route("jugadors.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            enviando.value = false;
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarJugador();
            emits("envio-formulario");
        },
        onError: (err) => {
            enviando.value = false;
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
        <v-dialog v-model="dialog" fullscreen persistent scrollable>
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
                                <v-col cols="12" class="pt-0 pb-0">
                                    <h4>Información Personal</h4>
                                </v-col>
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
                                        label="Nombre(s)*"
                                        required
                                        density="compact"
                                        v-model="form.nombre"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.paterno ? false : true
                                        "
                                        :error="
                                            form.errors?.paterno ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.paterno
                                                ? form.errors?.paterno
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Apellido Paterno*"
                                        v-model="form.paterno"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.materno ? false : true
                                        "
                                        :error="
                                            form.errors?.materno ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.materno
                                                ? form.errors?.materno
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Apellido Materno"
                                        v-model="form.materno"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nacionalidad
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nacionalidad
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nacionalidad
                                                ? form.errors?.nacionalidad
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Nacionalidad*"
                                        v-model="form.nacionalidad"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.ci ? false : true
                                        "
                                        :error="form.errors?.ci ? true : false"
                                        :error-messages="
                                            form.errors?.ci
                                                ? form.errors?.ci
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Número CI/DNI*"
                                        v-model="form.ci"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_nac
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_nac
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_nac
                                                ? form.errors?.fecha_nac
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Fecha de Nacimiento*"
                                        v-model="form.fecha_nac"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.posicion ? false : true
                                        "
                                        :error="
                                            form.errors?.posicion ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.posicion
                                                ? form.errors?.posicion
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Posición de Juego*"
                                        v-model="form.posicion"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.altura ? false : true
                                        "
                                        :error="
                                            form.errors?.altura ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.altura
                                                ? form.errors?.altura
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Altura*"
                                        v-model="form.altura"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.peso ? false : true
                                        "
                                        :error="
                                            form.errors?.peso ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.peso
                                                ? form.errors?.peso
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Peso*"
                                        v-model="form.peso"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.pie ? false : true
                                        "
                                        :error="form.errors?.pie ? true : false"
                                        :error-messages="
                                            form.errors?.pie
                                                ? form.errors?.pie
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Pie*"
                                        v-model="form.pie"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.valoracion_actual
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.valoracion_actual
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.valoracion_actual
                                                ? form.errors?.valoracion_actual
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Valoración de Mercado Actual*"
                                        v-model="form.valoracion_actual"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.correo ? false : true
                                        "
                                        :error="
                                            form.errors?.correo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.correo
                                                ? form.errors?.correo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Correo Electrónico"
                                        v-model="form.correo"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fono ? false : true
                                        "
                                        :error="
                                            form.errors?.fono ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.fono
                                                ? form.errors?.fono
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Teléfono"
                                        v-model="form.fono"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.dir ? false : true
                                        "
                                        :error="form.errors?.dir ? true : false"
                                        :error-messages="
                                            form.errors?.dir
                                                ? form.errors?.dir
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Dirección"
                                        v-model="form.dir"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input
                                        :hide-details="
                                            form.errors?.foto ? false : true
                                        "
                                        :error="
                                            form.errors?.foto ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.foto
                                                ? form.errors?.foto
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        accept="image/png, image/jpeg, image/bmp"
                                        placeholder="Logo"
                                        prepend-icon="mdi-camera"
                                        label="Fotografía"
                                        @change="cargaArchivo($event, 'foto')"
                                        ref="foto"
                                    ></v-file-input>
                                </v-col>
                                <v-col cols="12" class="pt-0 pb-0">
                                    <h4>Datos de Rendimiento</h4>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_convocado
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_convocado
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_convocado
                                                ? form.errors?.nro_convocado
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Veces Convocado*"
                                        required
                                        density="compact"
                                        v-model="form.nro_convocado"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_alineaciones
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_alineaciones
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_alineaciones
                                                ? form.errors?.nro_alineaciones
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Alineaciones*"
                                        required
                                        density="compact"
                                        v-model="form.nro_alineaciones"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.minutos_jugados
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.minutos_jugados
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.minutos_jugados
                                                ? form.errors?.minutos_jugados
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Minutos Jugados*"
                                        required
                                        density="compact"
                                        v-model="form.minutos_jugados"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_goles
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_goles
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_goles
                                                ? form.errors?.nro_goles
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Goles*"
                                        required
                                        density="compact"
                                        v-model="form.nro_goles"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_asistencias
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_asistencias
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_asistencias
                                                ? form.errors?.nro_asistencias
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Asistencias*"
                                        required
                                        density="compact"
                                        v-model="form.nro_asistencias"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_gol_penalti
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_gol_penalti
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_gol_penalti
                                                ? form.errors?.nro_gol_penalti
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Gol Penalti*"
                                        required
                                        density="compact"
                                        v-model="form.nro_gol_penalti"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_penalti_cometido
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_penalti_cometido
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_penalti_cometido
                                                ? form.errors
                                                      ?.nro_penalti_cometido
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Penalti cometido*"
                                        required
                                        density="compact"
                                        v-model="form.nro_penalti_cometido"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_tiro_palo
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_tiro_palo
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_tiro_palo
                                                ? form.errors?.nro_tiro_palo
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Tiro al Palo*"
                                        required
                                        density="compact"
                                        v-model="form.nro_tiro_palo"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_sustitucion
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_sustitucion
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_sustitucion
                                                ? form.errors?.nro_sustitucion
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Sustitución*"
                                        required
                                        density="compact"
                                        v-model="form.nro_sustitucion"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_tarjeta_amarilla
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_tarjeta_amarilla
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_tarjeta_amarilla
                                                ? form.errors
                                                      ?.nro_tarjeta_amarilla
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Tarjeta Amarilla*"
                                        required
                                        density="compact"
                                        v-model="form.nro_tarjeta_amarilla"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_tarjeta_roja
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_tarjeta_roja
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_tarjeta_roja
                                                ? form.errors?.nro_tarjeta_roja
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Tarjeta Roja*"
                                        required
                                        density="compact"
                                        v-model="form.nro_tarjeta_roja"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nro_lesiones
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nro_lesiones
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nro_lesiones
                                                ? form.errors?.nro_lesiones
                                                : ''
                                        "
                                        type="Number"
                                        step="1"
                                        variant="outlined"
                                        label="Número de Lesiones*"
                                        required
                                        density="compact"
                                        v-model="form.nro_lesiones"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.puntuacion_valorada
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.puntuacion_valorada
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.puntuacion_valorada
                                                ? form.errors
                                                      ?.puntuacion_valorada
                                                : ''
                                        "
                                        type="Number"
                                        step="0.01"
                                        variant="outlined"
                                        label="Puntuación Valorada Actual*"
                                        required
                                        density="compact"
                                        v-model="form.puntuacion_valorada"
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
                        :disabled="enviando"
                        @click="enviarFormulario"
                    >
                        Guardar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>
