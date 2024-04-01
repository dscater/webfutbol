<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { usePrediccionPartidos } from "@/composables/prediccion_partidos/usePrediccionPartidos";
import { useEquipos } from "@/composables/equipos/useEquipos";
import { useAlineacionEquipos } from "@/composables/alineacion_equipos/useAlineacionEquipos";
import { useMenu } from "@/composables/useMenu";
import { watch, ref, reactive, computed, onMounted } from "vue";

const { mobile, cambiarUrl } = useMenu();
const {
    oPrediccionPartido,
    limpiarPrediccionPartido,
    setGanadorPartido,
    setPGanadorPartido,
} = usePrediccionPartidos();
const { getAlineacionEquiposById, getAlineacionEquiposByEquipo } =
    useAlineacionEquipos();

let form = useForm(oPrediccionPartido);

const { flash, auth } = usePage().props;
const user = ref(auth.user);
const { getEquipos } = useEquipos();

const listEquipos = ref([]);
const listAlineacionLocal = ref([]);
const listAlineacionVisitante = ref([]);

const enviando = ref(false);

const tituloDialog = computed(() => {
    return oPrediccionPartido.id == 0
        ? `Agregar Predicción de Partido`
        : `Editar Predicción de Partido`;
});

const enviarFormulario = () => {
    enviando.value = true;
    form["alineacion_detalles"] = oPrediccionPartido.alineacion_detalles;
    form["eliminados"] = oPrediccionPartido.eliminados;

    let url =
        form["_method"] == "POST"
            ? route("prediccion_partidos.store")
            : route("prediccion_partidos.update", form.id);

    setTimeout(() => {
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
                limpiarPrediccionPartido();
                cambiarUrl(route("prediccion_partidos.index"));
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
    }, 400);
};

const getListaAlineacionLocal = (val = 0) => {
    form.alineacion_local_id = null;
    listAlineacionLocal.value = [];
    cargaListaAlineacionLocal(val);
};

const getListaAlneacionVisitante = (val = 0) => {
    form.alineacion_visitante_id = null;
    listAlineacionVisitante.value = [];
    cargaListaAlineacionVisitante(val);
};

const cargarListas = async () => {
    listEquipos.value = await getEquipos({
        order: "desc",
    });
    cargaListaAlineacionLocal();
    cargaListaAlineacionVisitante();
    cargaJugadoresAlineacionLocal();
    cargaJugadoresAlineacionVisitante();
};

const cargaListaAlineacionLocal = async (id = "") => {
    o_alineacion_local.value = null;
    if (form.local_id != "" && id == "") {
        listAlineacionLocal.value = await getAlineacionEquiposByEquipo({
            id: form.local_id,
        });
    } else {
        listAlineacionLocal.value = await getAlineacionEquiposByEquipo({
            id: id,
        });
    }
};

const cargaListaAlineacionVisitante = async (id = "") => {
    o_alineacion_visitante.value = null;
    if (form.visitante_id != "" && id == "") {
        listAlineacionVisitante.value = await getAlineacionEquiposByEquipo({
            id: form.visitante_id,
        });
    } else {
        listAlineacionVisitante.value = await getAlineacionEquiposByEquipo({
            id: id,
        });
    }
};

const o_alineacion_local = ref(null);
const changeAlineacionLocal = (value) => {
    cargaJugadoresAlineacionLocal(value);
};
const changeAlineacionVisitante = (value) => {
    cargaJugadoresAlineacionVisitante(value);
};

const cargaJugadoresAlineacionLocal = async (id = "") => {
    o_alineacion_local.value = null;
    if (form.alineacion_local_id && form.alineacion_local_id != "") {
        o_alineacion_local.value = await getAlineacionEquiposById({
            id: form.alineacion_local_id,
        });
    } else {
        if (id) {
            o_alineacion_local.value = await getAlineacionEquiposById({
                id: id,
            });
        }
    }
};

const o_alineacion_visitante = ref(null);
const cargaJugadoresAlineacionVisitante = async (id = "") => {
    o_alineacion_visitante.value = null;
    if (form.alineacion_visitante_id && form.alineacion_visitante_id != "") {
        o_alineacion_visitante.value = await getAlineacionEquiposById({
            id: form.alineacion_visitante_id,
        });
    } else {
        if (id) {
            o_alineacion_visitante.value = await getAlineacionEquiposById({
                id: id,
            });
        }
    }
};

const muestra_resultado = ref(false);
const loading = ref(false);
const generarPrediccion = () => {
    loading.value = true;
    muestra_resultado.value = false;
    form.p_ganador_id = null;
    setPGanadorPartido(null);
    if (form.alineacion_local_id && form.alineacion_visitante_id) {
        axios
            .post(route("prediccion_partidos.prediccion"), {
                alineacion_local_id: form.alineacion_local_id,
                alineacion_visitante_id: form.alineacion_visitante_id,
            })
            .then((response) => {
                if (response.data.ganador) {
                    form.p_ganador_id = response.data.ganador.id;
                    setPGanadorPartido(response.data.ganador);
                }
                setTimeout(() => {
                    loading.value = false;
                    muestra_resultado.value = true;
                }, 1500);
            })
            .catch((err) => {
                loading.value = false;
                console.log(err);
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    text: "Ocurrió un error al intentar obtener el resultado",
                    confirmButtonColor: "#3085d6",
                    confirmButtonText: `Aceptar`,
                });
            });
    } else {
        loading.value = false;
        Swal.fire({
            icon: "info",
            title: "Error",
            text: `Debes seleccionar la alineación de ambos equipos`,
            confirmButtonColor: "#3085d6",
            confirmButtonText: `Aceptar`,
        });
    }
};

onMounted(() => {
    if (form.id && form.id != "") {
        muestra_resultado.value = true;
    }
    cargarListas();
});
</script>

<template>
    <v-row class="mt-0">
        <v-col cols="12" class="d-flex justify-end">
            <template v-if="mobile">
                <v-btn
                    icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('prediccion_partidos.index'))"
                ></v-btn>
                <v-btn
                    icon="mdi-content-save"
                    color="primary"
                    @click="enviarFormulario"
                    :disalbed="enviando"
                ></v-btn>
            </template>
            <template v-if="!mobile">
                <v-btn
                    prepend-icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('prediccion_partidos.index'))"
                >
                    Volver</v-btn
                >
                <v-btn
                    :prepend-icon="
                        oPrediccionPartido.id != 0
                            ? 'mdi-sync'
                            : 'mdi-content-save'
                    "
                    color="primary"
                    @click="enviarFormulario"
                    :disalbed="enviando"
                >
                    <span
                        v-text="
                            oPrediccionPartido.id != 0
                                ? 'Actualizar Predicción de Partido'
                                : 'Guardar Predicción de Partido'
                        "
                    ></span
                ></v-btn>
            </template>
        </v-col>
    </v-row>
    <v-row>
        <v-col cols="12">
            <v-card>
                <v-card-title class="border-b bg-primary pa-5">
                    <v-icon
                        :icon="form.id == 0 ? 'mdi-plus' : 'mdi-pencil'"
                    ></v-icon>
                    <span class="text-h5" v-html="tituloDialog"></span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <form @submit.prevent="enviarFormulario">
                            <v-row
                                class="contenedor_prediccion"
                                :class="[loading ? 'h-20' : '']"
                            >
                                <div class="loading" v-if="loading">
                                    <div class="loader">
                                        <svg
                                            viewBox="0 0 866 866"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <svg
                                                id="Layer_1"
                                                data-name="Layer 1"
                                                xmlns="http://www.w3.org/2000/svg"
                                                viewBox="0 0 164.83 151.5"
                                            >
                                                <path
                                                    class="path-0"
                                                    d="M117.24,69.24A8,8,0,0,0,115.67,67c-4.88-4-9.8-7.89-14.86-11.62A4.93,4.93,0,0,0,96.93,55c-5.76,1.89-11.4,4.17-17.18,6a4.36,4.36,0,0,0-3.42,4.12c-1,6.89-2.1,13.76-3,20.66a4,4,0,0,0,1,3.07c5.12,4.36,10.39,8.61,15.68,12.76a3.62,3.62,0,0,0,2.92.75c6.29-2.66,12.52-5.47,18.71-8.36a3.49,3.49,0,0,0,1.68-2.19c1.34-7.25,2.54-14.55,3.9-22.58Z"
                                                    fill="#e96f20"
                                                />
                                                <path
                                                    class="path-1"
                                                    d="M97.55,38.68A43.76,43.76,0,0,1,98,33.44c.41-2.36-.5-3.57-2.57-4.64C91.1,26.59,87,24,82.66,21.82a6.18,6.18,0,0,0-4-.71C73.45,22.55,68.32,24.25,63.22,26c-3.63,1.21-6.08,3.35-5.76,7.69a26.67,26.67,0,0,1-.6,4.92c-1.08,8.06-1.08,8.08,5.86,11.92,3.95,2.19,7.82,5.75,11.94,6.08s8.76-2.41,13.12-3.93c9.33-3.29,9.33-3.3,9.78-14Z"
                                                    fill="#e96f20"
                                                />
                                                <path
                                                    class="path-2"
                                                    d="M66.11,126.56c5.91-.91,11.37-1.7,16.81-2.71a3.3,3.3,0,0,0,1.87-2.17c1-4.06,1.73-8.19,2.84-12.24.54-2-.11-3-1.55-4.15-5-4-9.9-8.12-15-12a6.19,6.19,0,0,0-4.15-1.1c-5.35.66-10.7,1.54-16,2.54A4,4,0,0,0,48.34,97a109.13,109.13,0,0,0-3,12.19,4.47,4.47,0,0,0,1.34,3.6c5.54,4.36,11.23,8.53,16.91,12.69a10.84,10.84,0,0,0,2.57,1.11Z"
                                                    fill="#e96f20"
                                                />
                                                <path
                                                    class="path-3"
                                                    d="M127.42,104.12c4.1-2.1,8-3.93,11.72-6a6,6,0,0,0,2.27-3,58.22,58.22,0,0,0,3.18-29.92c-.26-1.7-8-7.28-9.71-6.85A5,5,0,0,0,133,59.65c-2.81,2.49-5.71,4.88-8.33,7.56a9.46,9.46,0,0,0-2.47,4.4c-1.29,6.49-2.38,13-3.35,19.55a5.73,5.73,0,0,0,.83,3.91c2.31,3.08,5,5.88,7.7,9Z"
                                                    fill="#e96f20"
                                                />
                                                <path
                                                    class="path-4"
                                                    d="M52.58,29.89c-2.15-.36-3.78-.54-5.39-.9-2.83-.64-4.92.1-7,2.32A64.1,64.1,0,0,0,26.09,54.64c-2.64,7.92-2.62,7.84,5.15,10.87,1.76.69,2.73.45,3.93-1C39.79,59,44.54,53.65,49.22,48.2a4.2,4.2,0,0,0,1.13-2c.8-5.32,1.49-10.68,2.24-16.34Z"
                                                    fill="#e96f20"
                                                />
                                                <path
                                                    class="path-5"
                                                    fill="#e96f20"
                                                    d="M23,68.13c0,2.51,0,4.7,0,6.87a60.49,60.49,0,0,0,9.75,32.15c1.37,2.13,6.4,3,7,1.2,1.55-5,2.68-10.2,3.82-15.34.13-.58-.58-1.38-.94-2.06-2.51-4.77-5.47-9.38-7.45-14.37C32.94,71,28.22,69.84,23,68.13Z"
                                                />
                                                <path
                                                    class="path-6"
                                                    fill="#e96f20"
                                                    d="M83.91,12.86c-.32.36-.66.71-1,1.07.9,1.13,1.57,2.62,2.73,3.33,4.71,2.84,9.56,5.48,14.39,8.1a9.29,9.29,0,0,0,3.13.83c5.45.69,10.89,1.38,16.35,1.94a10.41,10.41,0,0,0,3.07-.71c-11.48-9.9-24.26-14.61-38.71-14.56Z"
                                                />
                                                <path
                                                    class="path-7"
                                                    fill="#e96f20"
                                                    d="M66.28,132.51c13.36,3.78,25.62,3.5,38-.9C91.68,129.59,79.36,128,66.28,132.51Z"
                                                />
                                                <path
                                                    class="path-8"
                                                    fill="#e96f20"
                                                    d="M127.2,30.66l-1.27.37a18.58,18.58,0,0,0,1,3.08c3,5.52,6.21,10.89,8.89,16.54,1.34,2.83,3.41,3.82,6.49,4.9a60.38,60.38,0,0,0-15.12-24.9Z"
                                                />
                                                <path
                                                    class="bb-9"
                                                    fill="#e96f20"
                                                    d="M117.35,125c5.58-2.32,16.9-13.84,18.1-19.2-2.41,1.46-5.18,2.36-6.78,4.23-4.21,5-7.89,10.37-11.32,15Z"
                                                />
                                            </svg>
                                        </svg>
                                    </div>

                                    <span class="text-body-1 text-white"
                                        >Obteniendo...</span
                                    >
                                </div>
                                <v-col cols="12" sm="12" md="5" xl="5">
                                    <v-card>
                                        <v-card-text>
                                            <v-row>
                                                <v-col cols="12">
                                                    <v-select
                                                        :hide-details="
                                                            form.errors
                                                                ?.local_id
                                                                ? false
                                                                : true
                                                        "
                                                        :error="
                                                            form.errors
                                                                ?.local_id
                                                                ? true
                                                                : false
                                                        "
                                                        :error-messages="
                                                            form.errors
                                                                ?.local_id
                                                                ? form.errors
                                                                      ?.local_id
                                                                : ''
                                                        "
                                                        clearable
                                                        variant="outlined"
                                                        label="Seleccionar Equipo Local*"
                                                        :items="listEquipos"
                                                        item-value="id"
                                                        item-title="nombre"
                                                        required
                                                        density="compact"
                                                        @update:modelValue="
                                                            getListaAlineacionLocal
                                                        "
                                                        v-model="form.local_id"
                                                    ></v-select>
                                                </v-col>
                                                <v-col cols="12">
                                                    <v-select
                                                        :hide-details="
                                                            form.errors
                                                                ?.alineacion_local_id
                                                                ? false
                                                                : true
                                                        "
                                                        :error="
                                                            form.errors
                                                                ?.alineacion_local_id
                                                                ? true
                                                                : false
                                                        "
                                                        :error-messages="
                                                            form.errors
                                                                ?.alineacion_local_id
                                                                ? form.errors
                                                                      ?.alineacion_local_id
                                                                : ''
                                                        "
                                                        clearable
                                                        variant="outlined"
                                                        label="Seleccionar Alineación Equipo Local*"
                                                        :items="
                                                            listAlineacionLocal
                                                        "
                                                        item-value="id"
                                                        item-title="nombre"
                                                        required
                                                        density="compact"
                                                        @update:modelValue="
                                                            changeAlineacionLocal
                                                        "
                                                        v-model="
                                                            form.alineacion_local_id
                                                        "
                                                    ></v-select>
                                                </v-col>
                                                <v-col
                                                    cols="12"
                                                    v-if="
                                                        o_alineacion_local &&
                                                        o_alineacion_local.id
                                                    "
                                                >
                                                    <v-list
                                                        class="bg-green-darken-3 rounded"
                                                    >
                                                        <v-list-item>
                                                            <template
                                                                v-slot:title
                                                            >
                                                                <div
                                                                    class="text-center"
                                                                >
                                                                    <v-avatar
                                                                        color="primary"
                                                                        size="45"
                                                                    >
                                                                        <v-img
                                                                            v-if="
                                                                                o_alineacion_local
                                                                                    .equipo
                                                                                    .url_logo
                                                                            "
                                                                            :src="
                                                                                o_alineacion_local
                                                                                    .equipo
                                                                                    .url_logo
                                                                            "
                                                                            cover
                                                                            :lazy-src="
                                                                                o_alineacion_local
                                                                                    .equipo
                                                                                    .url_logo
                                                                            "
                                                                        ></v-img>
                                                                        <span
                                                                            v-else
                                                                            >{{
                                                                                o_alineacion_local
                                                                                    .equipo
                                                                                    .iniciales_nombre
                                                                            }}</span
                                                                        >
                                                                    </v-avatar>

                                                                    <span
                                                                        class="text-body-1 font-weight-bold ml-3"
                                                                        >{{
                                                                            o_alineacion_local
                                                                                .equipo
                                                                                .nombre
                                                                        }}</span
                                                                    >
                                                                </div>
                                                            </template>
                                                            <template
                                                                v-slot:subtitle
                                                            >
                                                                <v-card>
                                                                    <v-card-text>
                                                                        <v-row>
                                                                            <v-col
                                                                                cols="12"
                                                                                md="6"
                                                                                xl="6"
                                                                                offset-md="6"
                                                                                offset-xl="6"
                                                                            >
                                                                                <v-text-field
                                                                                    :hide-details="
                                                                                        form
                                                                                            .errors
                                                                                            ?.g_local
                                                                                            ? false
                                                                                            : true
                                                                                    "
                                                                                    :error="
                                                                                        form
                                                                                            .errors
                                                                                            ?.g_local
                                                                                            ? true
                                                                                            : false
                                                                                    "
                                                                                    :error-messages="
                                                                                        form
                                                                                            .errors
                                                                                            ?.g_local
                                                                                            ? form
                                                                                                  .errors
                                                                                                  ?.g_local
                                                                                            : ''
                                                                                    "
                                                                                    type="number"
                                                                                    step="1"
                                                                                    variant="outlined"
                                                                                    label="Goles Local"
                                                                                    required
                                                                                    density="compact"
                                                                                    v-model="
                                                                                        form.g_local
                                                                                    "
                                                                                ></v-text-field>
                                                                            </v-col>
                                                                        </v-row>
                                                                    </v-card-text>
                                                                </v-card>
                                                            </template>
                                                        </v-list-item>
                                                        <template
                                                            v-for="(
                                                                item, i
                                                            ) in o_alineacion_local.alineacion_detalles"
                                                        >
                                                            <v-list-item
                                                                :value="item"
                                                                class="pl-0"
                                                            >
                                                                <template
                                                                    v-slot:prepend
                                                                >
                                                                    <div>
                                                                        <span
                                                                            class="text-body-1 ml-3 mr-2"
                                                                            >{{
                                                                                i +
                                                                                1
                                                                            }})</span
                                                                        >
                                                                        <v-avatar
                                                                            color="primary"
                                                                            class="mr-2"
                                                                        >
                                                                            <v-img
                                                                                :src="
                                                                                    item
                                                                                        ?.jugador
                                                                                        .url_foto
                                                                                "
                                                                                alt="Foto"
                                                                                cover
                                                                                v-if="
                                                                                    item
                                                                                        ?.jugador
                                                                                        .url_foto
                                                                                "
                                                                            ></v-img>
                                                                            <span
                                                                                v-else
                                                                                >{{
                                                                                    item
                                                                                        ?.jugador
                                                                                        .iniciales_nombre
                                                                                }}</span
                                                                            >
                                                                        </v-avatar>
                                                                    </div>
                                                                </template>
                                                                <template
                                                                    v-slot:title
                                                                >
                                                                    <v-list-item-title
                                                                        v-text="
                                                                            item
                                                                                ?.jugador
                                                                                .full_name
                                                                        "
                                                                    >
                                                                    </v-list-item-title>
                                                                </template>
                                                                <template
                                                                    v-slot:subtitle
                                                                >
                                                                    <div>
                                                                        {{
                                                                            item
                                                                                .jugador
                                                                                .posicion
                                                                        }}
                                                                        &mdash;
                                                                        <v-chip
                                                                            color="primary"
                                                                            variant="flat"
                                                                            >{{
                                                                                item
                                                                                    .fichaje
                                                                                    .nro_polera
                                                                            }}</v-chip
                                                                        >
                                                                    </div>
                                                                </template>
                                                                <!-- <template
                                                                    v-slot:append
                                                                >
                                                                    <div>
                                                                        <v-btn
                                                                            class="ml-1"
                                                                            variant="outlined"
                                                                            icon="mdi-account"
                                                                            size="x-small"
                                                                            @click.stop="
                                                                                showInfoJugador(
                                                                                    item
                                                                                )
                                                                            "
                                                                        ></v-btn>
                                                                    </div>
                                                                </template> -->
                                                            </v-list-item>
                                                            <v-divider
                                                                v-if="
                                                                    i <
                                                                    o_alineacion_local.alineacion_detalles -
                                                                        1
                                                                "
                                                            ></v-divider>
                                                        </template>
                                                    </v-list>
                                                </v-col>
                                            </v-row>
                                        </v-card-text>
                                    </v-card>
                                </v-col>
                                <v-col
                                    cols="12"
                                    xs="12"
                                    sm="12"
                                    md="2"
                                    xl="2"
                                    class="d-flex align-center"
                                >
                                    <v-btn
                                        class="btn-wrap-text"
                                        color="blue-darken-2"
                                        size="x-large"
                                        block
                                        :disabled="
                                            !form.local_id ||
                                            !form.visitante_id ||
                                            !form.alineacion_local_id ||
                                            !form.alineacion_visitante_id ||
                                            loading
                                                ? true
                                                : false
                                        "
                                        @click="generarPrediccion"
                                    >
                                        <p>
                                            GENERAR
                                            <br />PREDICCIÓN
                                        </p>
                                    </v-btn>
                                </v-col>
                                <v-col cols="12" sm="12" md="5" xl="5">
                                    <v-card>
                                        <v-card-text>
                                            <v-row>
                                                <v-col cols="12">
                                                    <v-select
                                                        :hide-details="
                                                            form.errors
                                                                ?.visitante_id
                                                                ? false
                                                                : true
                                                        "
                                                        :error="
                                                            form.errors
                                                                ?.visitante_id
                                                                ? true
                                                                : false
                                                        "
                                                        :error-messages="
                                                            form.errors
                                                                ?.visitante_id
                                                                ? form.errors
                                                                      ?.visitante_id
                                                                : ''
                                                        "
                                                        clearable
                                                        variant="outlined"
                                                        label="Seleccionar Equipo Visitante*"
                                                        :items="listEquipos"
                                                        item-value="id"
                                                        item-title="nombre"
                                                        required
                                                        density="compact"
                                                        @update:modelValue="
                                                            getListaAlneacionVisitante
                                                        "
                                                        v-model="
                                                            form.visitante_id
                                                        "
                                                    ></v-select>
                                                </v-col>
                                                <v-col cols="12">
                                                    <v-select
                                                        :hide-details="
                                                            form.errors
                                                                ?.alineacion_visitante_id
                                                                ? false
                                                                : true
                                                        "
                                                        :error="
                                                            form.errors
                                                                ?.alineacion_visitante_id
                                                                ? true
                                                                : false
                                                        "
                                                        :error-messages="
                                                            form.errors
                                                                ?.alineacion_visitante_id
                                                                ? form.errors
                                                                      ?.alineacion_visitante_id
                                                                : ''
                                                        "
                                                        clearable
                                                        variant="outlined"
                                                        label="Seleccionar Alineación Equipo Visitante*"
                                                        :items="
                                                            listAlineacionVisitante
                                                        "
                                                        item-value="id"
                                                        item-title="nombre"
                                                        required
                                                        density="compact"
                                                        @update:modelValue="
                                                            changeAlineacionVisitante
                                                        "
                                                        v-model="
                                                            form.alineacion_visitante_id
                                                        "
                                                    ></v-select>
                                                </v-col>
                                                <v-col
                                                    cols="12"
                                                    v-if="
                                                        o_alineacion_visitante &&
                                                        o_alineacion_visitante.id
                                                    "
                                                >
                                                    <v-list
                                                        class="bg-green-darken-3 rounded"
                                                    >
                                                        <v-list-item>
                                                            <template
                                                                v-slot:title
                                                            >
                                                                <div
                                                                    class="text-center"
                                                                >
                                                                    <v-avatar
                                                                        color="primary"
                                                                        size="45"
                                                                    >
                                                                        <v-img
                                                                            v-if="
                                                                                o_alineacion_visitante
                                                                                    .equipo
                                                                                    .url_logo
                                                                            "
                                                                            :src="
                                                                                o_alineacion_visitante
                                                                                    .equipo
                                                                                    .url_logo
                                                                            "
                                                                            cover
                                                                            :lazy-src="
                                                                                o_alineacion_visitante
                                                                                    .equipo
                                                                                    .url_logo
                                                                            "
                                                                        ></v-img>
                                                                        <span
                                                                            v-else
                                                                            >{{
                                                                                o_alineacion_visitante
                                                                                    .equipo
                                                                                    .iniciales_nombre
                                                                            }}</span
                                                                        >
                                                                    </v-avatar>

                                                                    <span
                                                                        class="text-body-1 font-weight-bold ml-3"
                                                                        >{{
                                                                            o_alineacion_visitante
                                                                                .equipo
                                                                                .nombre
                                                                        }}</span
                                                                    >
                                                                </div>
                                                            </template>
                                                            <template
                                                                v-slot:subtitle
                                                            >
                                                                <v-card>
                                                                    <v-card-text>
                                                                        <v-row>
                                                                            <v-col
                                                                                cols="12"
                                                                                md="6"
                                                                                xl="6"
                                                                            >
                                                                                <v-text-field
                                                                                    :hide-details="
                                                                                        form
                                                                                            .errors
                                                                                            ?.g_visitante
                                                                                            ? false
                                                                                            : true
                                                                                    "
                                                                                    :error="
                                                                                        form
                                                                                            .errors
                                                                                            ?.g_visitante
                                                                                            ? true
                                                                                            : false
                                                                                    "
                                                                                    :error-messages="
                                                                                        form
                                                                                            .errors
                                                                                            ?.g_visitante
                                                                                            ? form
                                                                                                  .errors
                                                                                                  ?.g_visitante
                                                                                            : ''
                                                                                    "
                                                                                    type="number"
                                                                                    step="1"
                                                                                    variant="outlined"
                                                                                    label="Goles Visitante"
                                                                                    required
                                                                                    density="compact"
                                                                                    v-model="
                                                                                        form.g_visitante
                                                                                    "
                                                                                ></v-text-field>
                                                                            </v-col>
                                                                        </v-row>
                                                                    </v-card-text>
                                                                </v-card>
                                                            </template>
                                                        </v-list-item>
                                                        <template
                                                            v-for="(
                                                                item, i
                                                            ) in o_alineacion_visitante.alineacion_detalles"
                                                        >
                                                            <v-list-item
                                                                :value="item"
                                                                class="pl-0"
                                                            >
                                                                <template
                                                                    v-slot:prepend
                                                                >
                                                                    <div>
                                                                        <span
                                                                            class="text-body-1 ml-3 mr-2"
                                                                            >{{
                                                                                i +
                                                                                1
                                                                            }})</span
                                                                        >
                                                                        <v-avatar
                                                                            color="primary"
                                                                            class="mr-2"
                                                                        >
                                                                            <v-img
                                                                                :src="
                                                                                    item
                                                                                        ?.jugador
                                                                                        .url_foto
                                                                                "
                                                                                alt="Foto"
                                                                                cover
                                                                                v-if="
                                                                                    item
                                                                                        ?.jugador
                                                                                        .url_foto
                                                                                "
                                                                            ></v-img>
                                                                            <span
                                                                                v-else
                                                                                >{{
                                                                                    item
                                                                                        ?.jugador
                                                                                        .iniciales_nombre
                                                                                }}</span
                                                                            >
                                                                        </v-avatar>
                                                                    </div>
                                                                </template>
                                                                <template
                                                                    v-slot:title
                                                                >
                                                                    <v-list-item-title
                                                                        v-text="
                                                                            item
                                                                                ?.jugador
                                                                                .full_name
                                                                        "
                                                                    >
                                                                    </v-list-item-title>
                                                                </template>
                                                                <template
                                                                    v-slot:subtitle
                                                                >
                                                                    <div>
                                                                        {{
                                                                            item
                                                                                .jugador
                                                                                .posicion
                                                                        }}
                                                                        &mdash;
                                                                        <v-chip
                                                                            color="primary"
                                                                            variant="flat"
                                                                            >{{
                                                                                item
                                                                                    .fichaje
                                                                                    .nro_polera
                                                                            }}</v-chip
                                                                        >
                                                                    </div>
                                                                </template>
                                                                <!-- <template
                                                                    v-slot:append
                                                                >
                                                                    <div>
                                                                        <v-btn
                                                                            class="ml-1"
                                                                            variant="outlined"
                                                                            icon="mdi-account"
                                                                            size="x-small"
                                                                            @click.stop="
                                                                                showInfoJugador(
                                                                                    item
                                                                                )
                                                                            "
                                                                        ></v-btn>
                                                                    </div>
                                                                </template> -->
                                                            </v-list-item>
                                                            <v-divider
                                                                v-if="
                                                                    i <
                                                                    o_alineacion_visitante.alineacion_detalles -
                                                                        1
                                                                "
                                                            ></v-divider>
                                                        </template>
                                                    </v-list>
                                                </v-col>
                                            </v-row>
                                        </v-card-text>
                                    </v-card>
                                </v-col>
                            </v-row>
                            <v-row v-if="muestra_resultado">
                                <v-col cols="12">
                                    <v-alert class="bg-green-darken-3">
                                        <template v-slot:title>
                                            <div class="text-center w-100">
                                                <span
                                                    v-if="
                                                        oPrediccionPartido.p_ganador &&
                                                        oPrediccionPartido
                                                            .p_ganador.id
                                                    "
                                                    >GANADOR "{{
                                                        oPrediccionPartido
                                                            .p_ganador.nombre
                                                    }}"</span
                                                >
                                                <span v-else>EMPATÉ</span>
                                            </div>
                                        </template>
                                    </v-alert>
                                </v-col>
                            </v-row>
                        </form>
                    </v-container>
                </v-card-text>
            </v-card>
        </v-col>
    </v-row>
</template>

<style scoped>
.contenedor_prediccion {
    position: relative;
}
.loading {
    z-index: 4;
    height: 100%;
    width: 100%;
    position: absolute;
    background: var(--principal);
    text-align: center;
    padding: 20px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.loader {
    display: block;
    height: 20%;
}

svg {
    height: 100%;
    margin: 0 auto;
}

path {
    animation-duration: 1s;
    animation-name: pulse;
    animation-iteration-count: infinite;
    color: #0068f0;
}

path .path-7 {
    animation-delay: -1s;
}
path .path-6 {
    animation-delay: -0.875s;
}
path .path-5 {
    animation-delay: -0.75s;
}
path .path-4 {
    animation-delay: -0.625s;
}
path .path-3 {
    animation-delay: -0.5s;
}
path .path-2 {
    animation-delay: -0.375s;
}
path .path-1 {
    animation-delay: -0.25s;
}
path .path-0 {
    animation-delay: -0.125s;
}

@keyframes pulse {
    0% {
        opacity: 0.1;
    }
    30% {
        opacity: 0.8;
    }
    100% {
        opacity: 0.1;
    }
}
</style>
