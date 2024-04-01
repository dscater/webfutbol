<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useAlineacionEquipos } from "@/composables/alineacion_equipos/useAlineacionEquipos";
import { useFichajes } from "@/composables/fichajes/useFichajes";
import { useEquipos } from "@/composables/equipos/useEquipos";
import { useMenu } from "@/composables/useMenu";
import { watch, ref, reactive, computed, onMounted } from "vue";
import InfoJugador from "../InfoJugador.vue";

const { mobile, cambiarUrl } = useMenu();
const {
    oAlineacionEquipo,
    limpiarAlineacionEquipo,
    addAlineacionDetalle,
    eliminarAlineacionDetalle,
} = useAlineacionEquipos();
let form = useForm(oAlineacionEquipo);

const { flash, auth } = usePage().props;
const user = ref(auth.user);
const { getFichajesByEquipo } = useFichajes();
const { getEquipos } = useEquipos();

const listEquipos = ref([]);
const listFichajes = ref([]);

const open_dialog = ref(false);
const accion_dialog = ref(0);
const o_jugador = ref(null);
const enviando = ref(false);

const tituloDialog = computed(() => {
    return oAlineacionEquipo.id == 0
        ? `Agregar Alineación de Equipo`
        : `Editar Alineación de Equipo`;
});

const enviarFormulario = () => {
    enviando.value = true;
    form["alineacion_detalles"] = oAlineacionEquipo.alineacion_detalles;
    form["eliminados"] = oAlineacionEquipo.eliminados;

    let url =
        form["_method"] == "POST"
            ? route("alineacion_equipos.store")
            : route("alineacion_equipos.update", form.id);

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
                limpiarAlineacionEquipo();
                cambiarUrl(route("alineacion_equipos.index"));
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

const getFichajes = (val = 0) => {
    cargaFichajes(val);
};

const cargarListas = async () => {
    listEquipos.value = await getEquipos({
        order: "desc",
    });
    cargaFichajes();
};

const cargaFichajes = async (id = "") => {
    if (form.equipo_id != "" && id == "") {
        listFichajes.value = await getFichajesByEquipo({
            id: form.equipo_id,
        });
    } else {
        listFichajes.value = await getFichajesByEquipo({
            id: id,
        });
    }
};

const agregarAlineacion = (item) => {
    if (!validarExistencia(item.jugador_id) && validarMaximo()) {
        addAlineacionDetalle({
            id: 0,
            alineacion_equipo_id: 0,
            fichaje_id: item.id,
            fichaje: item,
            jugador_id: item.jugador_id,
            jugador: item.jugador,
        });
    }
};

const validarMaximo = () => {
    if (oAlineacionEquipo.alineacion_detalles.length >= 11) {
        Swal.fire({
            icon: "info",
            title: "Atención",
            text: `No puedes registrar mas de 11 jugadores en la alineación`,
            confirmButtonColor: "#3085d6",
            confirmButtonText: `Aceptar`,
        });
        return false;
    }
    return true;
};

const validarExistencia = (jugador_id) => {
    let existe = oAlineacionEquipo.alineacion_detalles.filter(
        (elem) => elem.jugador_id === jugador_id
    );
    if (existe.length > 0) {
        return true;
    }
    return false;
};

const eliminaAlineacion = (index, item) => {
    eliminarAlineacionDetalle(index, item.id);
};
onMounted(() => {
    if (form.id && form.id != "") {
    }
    cargarListas();
});

const showInfoJugador = (item) => {
    o_jugador.value = item.jugador;
    open_dialog.value = true;
};
</script>

<template>
    <v-row class="mt-0">
        <v-col cols="12" class="d-flex justify-end">
            <template v-if="mobile">
                <v-btn
                    icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('alineacion_equipos.index'))"
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
                    @click="cambiarUrl(route('alineacion_equipos.index'))"
                >
                    Volver</v-btn
                >
                <v-btn
                    :prepend-icon="
                        oAlineacionEquipo.id != 0
                            ? 'mdi-sync'
                            : 'mdi-content-save'
                    "
                    color="primary"
                    @click="enviarFormulario"
                    :disalbed="enviando"
                >
                    <span
                        v-text="
                            oAlineacionEquipo.id != 0
                                ? 'Actualizar Alineación de Equipo'
                                : 'Guardar Alineación de Equipo'
                        "
                    ></span
                ></v-btn>
            </template>
        </v-col>
    </v-row>
    <v-row>
        <v-col cols="12" sm="12" md="6" xl="6">
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
                            <v-row>
                                <v-col cols="12" sm="12" md="12" xl="6">
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
                                        clearable
                                        variant="outlined"
                                        label="Seleccionar Equipo*"
                                        :items="listEquipos"
                                        item-value="id"
                                        item-title="nombre"
                                        required
                                        density="compact"
                                        @update:modelValue="getFichajes"
                                        v-model="form.equipo_id"
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
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
                                        label="Nombre de la AlineacionEquipo*"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.nombre"
                                    ></v-textarea>
                                </v-col>
                            </v-row>
                        </form>
                        <v-row>
                            <v-col cols="12"
                                ><h3 class="text-center mt-3">
                                    Lista de Jugadores
                                </h3>
                                <span class="text-caption"
                                    >Selecciona el jugador para agregarlo a la
                                    alineación</span
                                >
                            </v-col>
                            <v-col
                                cols="12"
                                v-if="listFichajes.length > 0"
                                class="pt-0"
                            >
                                <v-list class="pt-0">
                                    <template v-for="(item, i) in listFichajes">
                                        <v-list-item
                                            :value="item"
                                            color="primary"
                                            class="pl-0"
                                            @click="agregarAlineacion(item)"
                                            :active="
                                                validarExistencia(
                                                    item.jugador_id
                                                )
                                            "
                                        >
                                            <template v-slot:prepend>
                                                <div>
                                                    <span
                                                        class="text-body-1 ml-3 mr-2"
                                                        >{{ i + 1 }})</span
                                                    >
                                                    <v-avatar
                                                        color="primary"
                                                        class="mr-2"
                                                    >
                                                        <v-img
                                                            :src="
                                                                item?.jugador
                                                                    .url_foto
                                                            "
                                                            alt="Foto"
                                                            cover
                                                            v-if="
                                                                item?.jugador
                                                                    .url_foto
                                                            "
                                                        ></v-img>
                                                        <span v-else>{{
                                                            item?.jugador
                                                                .iniciales_nombre
                                                        }}</span>
                                                    </v-avatar>
                                                </div>
                                            </template>
                                            <template v-slot:title>
                                                <v-list-item-title
                                                    v-text="
                                                        item?.jugador.full_name
                                                    "
                                                >
                                                </v-list-item-title>
                                            </template>
                                            <template v-slot:subtitle>
                                                <div>
                                                    {{ item.jugador.posicion }}
                                                    &mdash;
                                                    <v-chip
                                                        color="primary"
                                                        variant="flat"
                                                        >{{
                                                            item.nro_polera
                                                        }}</v-chip
                                                    >
                                                </div>
                                            </template>
                                            <template v-slot:append>
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
                                                    <v-btn
                                                        v-if="
                                                            !validarExistencia(
                                                                item.jugador_id
                                                            )
                                                        "
                                                        class="ml-1"
                                                        color="success"
                                                        variant="outlined"
                                                        icon="mdi-plus"
                                                        size="x-small"
                                                        @click="
                                                            agregarAlineacion(
                                                                item
                                                            )
                                                        "
                                                    ></v-btn>
                                                </div>
                                            </template>
                                        </v-list-item>
                                        <v-divider
                                            v-if="i < listFichajes.length - 1"
                                        ></v-divider>
                                    </template>
                                </v-list>
                            </v-col>
                            <v-col v-else
                                ><h4
                                    class="text-medium-emphasis text-center text-caption"
                                >
                                    Debes seleccionar un Equipo
                                </h4></v-col
                            >
                        </v-row>
                    </v-container>
                </v-card-text>
            </v-card>
        </v-col>
        <v-col cols="12" sm="12" md="6" xl="6">
            <v-card>
                <v-card-title class="bg-primary pa-5">
                    <span class="text-h5">Jugadores en la alineación</span>
                </v-card-title>
                <v-card-text>
                    <v-row class="py-3">
                        <v-col cols="12">
                            <span class="text-caption"
                                >Selecciona el jugador para quitarlo de la
                                alineación</span
                            >
                        </v-col>
                        <v-col
                            cols="12"
                            v-if="
                                oAlineacionEquipo.alineacion_detalles.length > 0
                            "
                            class="pt-0"
                        >
                            <v-list class="pt-0">
                                <template
                                    v-for="(
                                        item, i
                                    ) in oAlineacionEquipo.alineacion_detalles"
                                >
                                    <v-list-item
                                        :value="item"
                                        color="primary"
                                        class="pl-0"
                                        @click="eliminaAlineacion(i, item)"
                                    >
                                        <template v-slot:prepend>
                                            <div>
                                                <span
                                                    class="text-body-1 ml-3 mr-2"
                                                    >{{ i + 1 }})</span
                                                >
                                                <v-avatar
                                                    color="primary"
                                                    class="mr-2"
                                                >
                                                    <v-img
                                                        :src="
                                                            item?.jugador
                                                                .url_foto
                                                        "
                                                        alt="Foto"
                                                        cover
                                                        v-if="
                                                            item?.jugador
                                                                .url_foto
                                                        "
                                                    ></v-img>
                                                    <span v-else>{{
                                                        item?.jugador
                                                            .iniciales_nombre
                                                    }}</span>
                                                </v-avatar>
                                            </div>
                                        </template>
                                        <template v-slot:title>
                                            <v-list-item-title
                                                v-text="item?.jugador.full_name"
                                            >
                                            </v-list-item-title>
                                        </template>
                                        <template v-slot:subtitle>
                                            <div>
                                                {{ item.jugador.posicion }}
                                                &mdash;
                                                <v-chip
                                                    color="primary"
                                                    variant="flat"
                                                    >{{
                                                        item.fichaje.nro_polera
                                                    }}</v-chip
                                                >
                                            </div>
                                        </template>
                                        <template v-slot:append>
                                            <div>
                                                <v-btn
                                                    class="ml-1"
                                                    variant="outlined"
                                                    icon="mdi-account"
                                                    size="x-small"
                                                    @click.stop="
                                                        showInfoJugador(item)
                                                    "
                                                ></v-btn>
                                                <v-btn
                                                    class="ml-1"
                                                    color="red-darken-3"
                                                    variant="outlined"
                                                    icon="mdi-close"
                                                    size="x-small"
                                                    @click="
                                                        eliminaAlineacion(
                                                            i,
                                                            item
                                                        )
                                                    "
                                                ></v-btn>
                                            </div>
                                        </template>
                                    </v-list-item>
                                    <v-divider
                                        v-if="i < listFichajes.length - 1"
                                    ></v-divider>
                                </template>
                            </v-list>
                        </v-col>
                        <v-col v-else
                            ><h4
                                class="text-medium-emphasis text-center text-caption"
                            >
                                No se agregó ningún jugador
                            </h4></v-col
                        >
                    </v-row>
                </v-card-text>
            </v-card>
        </v-col>
    </v-row>
    <InfoJugador
        :jugador="o_jugador"
        :open_dialog="open_dialog"
        :accion_dialog="accion_dialog"
        @cerrar-dialog="
            open_dialog = false;
            o_jugador = null;
        "
    ></InfoJugador>
</template>

<style scoped></style>
