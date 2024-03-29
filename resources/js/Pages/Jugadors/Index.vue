<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Jugadores",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { Head } from "@inertiajs/vue3";
import { useJugadors } from "@/composables/jugadors/useJugadors";
import { ref, onMounted } from "vue";
import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
const { mobile, identificaDispositivo } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getJugadorsApi, setJugador, limpiarJugador, deleteJugador } =
    useJugadors();
const responseJugadors = ref([]);
const listJugadors = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    { title: "Nombre del Jugador", align: "start", sortable: false },
    { title: "Fotografía", align: "start", sortable: false },
    { title: "Nacionalidad", align: "start", sortable: false },
    { title: "Número CI/DNI", align: "start", sortable: false },
    { title: "Fecha de Nacimiento", align: "start", sortable: false },
    { title: "Posición de Juego", align: "start", sortable: false },
    { title: "Altura", align: "start", sortable: false },
    { title: "Peso", align: "start", sortable: false },
    { title: "Pie", align: "start", sortable: false },
    { title: "Más", align: "start", sortable: false },
    { title: "Acción", align: "end", sortable: false },
]);

const search = ref("");
const options = ref({
    page: 1,
    itemsPerPage: itemsPerPage,
    sortBy: "",
    sortOrder: "desc",
    search: "",
});

const loading = ref(true);
const totalItems = ref(0);
let setTimeOutLoadData = null;
const loadItems = async ({ page, itemsPerPage, sortBy }) => {
    loading.value = true;
    options.value.page = page;
    if (sortBy.length > 0) {
        options.value.sortBy = sortBy[0].key;
        options.value.sortOrder = sortBy[0].order;
    }
    options.value.search = search.value;

    clearInterval(setTimeOutLoadData);
    setTimeOutLoadData = setTimeout(async () => {
        responseJugadors.value = await getJugadorsApi(options.value);
        listJugadors.value = responseJugadors.value.data;
        totalItems.value = parseInt(responseJugadors.value.total);
        loading.value = false;
    }, 300);
};
const recargaJugadors = async () => {
    loading.value = true;
    listJugadors.value = [];
    options.value.search = search.value;
    responseJugadors.value = await getJugadorsApi(options.value);
    listJugadors.value = responseJugadors.value.data;
    totalItems.value = parseInt(responseJugadors.value.total);
    setTimeout(() => {
        loading.value = false;
        open_dialog.value = false;
    }, 300);
};
const accion_dialog = ref(0);
const open_dialog = ref(false);

const agregarRegistro = () => {
    limpiarJugador();
    accion_dialog.value = 0;
    open_dialog.value = true;
};
const editarJugador = (item) => {
    setJugador(item);
    accion_dialog.value = 1;
    open_dialog.value = true;
};

const eliminarJugador = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.full_name}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteJugador(item.id);
            if (respuesta && respuesta.sw) {
                recargaJugadors();
            }
        }
    });
};
</script>
<template>
    <Head title="Jugadores"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="primary"
                    prepend-icon="mdi-plus"
                    @click="agregarRegistro"
                >
                    Agregar</v-btn
                >
            </v-col>
        </v-row>
        <v-row class="mt-0">
            <v-col cols="12">
                <v-card flat>
                    <v-card-title>
                        <v-row class="bg-primary d-flex align-center pa-3">
                            <v-col cols="12" sm="6" md="4"> Jugadores </v-col>
                            <v-col cols="12" sm="6" md="4" offset-md="4">
                                <v-text-field
                                    v-model="search"
                                    label="Buscar"
                                    append-inner-icon="mdi-magnify"
                                    variant="underlined"
                                    clearable
                                    hide-details
                                ></v-text-field>
                            </v-col>
                        </v-row>
                    </v-card-title>
                    <v-card-text>
                        <v-data-table-server
                            v-model:items-per-page="itemsPerPage"
                            :headers="!mobile ? headers : []"
                            :class="[mobile ? 'mobile' : '']"
                            :items-length="totalItems"
                            :items="listJugadors"
                            :loading="loading"
                            :search="search"
                            @update:options="loadItems"
                            height="auto"
                            no-data-text="No se encontrarón registros"
                            loading-text="Cargando..."
                            page-text="{0} - {1} de {2}"
                            items-per-page-text="Registros por página"
                            :items-per-page-options="[
                                { value: 10, title: '10' },
                                { value: 25, title: '25' },
                                { value: 50, title: '50' },
                                { value: 100, title: '100' },
                                {
                                    value: -1,
                                    title: 'Todos',
                                },
                            ]"
                        >
                            <template v-slot:item="{ item }">
                                <template v-if="!mobile"
                                    ><tr>
                                        <td>{{ item.full_name }}</td>
                                        <td>
                                            <v-avatar color="primary">
                                                <v-img
                                                    v-if="item.url_foto"
                                                    :src="item.url_foto"
                                                    cover
                                                    :lazy-src="item.url_foto"
                                                ></v-img>
                                                <span v-else>{{
                                                    item.iniciales_nombre
                                                }}</span>
                                            </v-avatar>
                                        </td>
                                        <td class="text-xs-right">
                                            {{ item.nacionalidad }}
                                        </td>
                                        <td>{{ item.ci }}</td>
                                        <td>{{ item.fecha_nac_t }}</td>
                                        <td>{{ item.posicion }}</td>
                                        <td>{{ item.altura }}</td>
                                        <td>{{ item.peso }}</td>
                                        <td>{{ item.pie }}</td>
                                        <td>
                                            <v-btn
                                                :icon="
                                                    item.mas
                                                        ? 'mdi-chevron-down'
                                                        : 'mdi-chevron-left'
                                                "
                                                @click="item.mas = !item.mas"
                                            ></v-btn>
                                        </td>
                                        <td class="text-right">
                                            <v-btn
                                                color="yellow"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="editarJugador(item)"
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="eliminarJugador(item)"
                                                icon="mdi-trash-can"
                                            ></v-btn>
                                        </td>
                                    </tr>
                                    <tr v-if="item.mas">
                                        <td
                                            :colspan="headers.length"
                                            class="py-5"
                                        >
                                            <v-row>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                        >
                                                            Valoración de
                                                            Mercado
                                                            Actual</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.valoracion_actual
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Correo
                                                            Electrónico</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.correo
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Teléfono</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.fono
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Dirección</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.dir
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de Veces
                                                            Convocado</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_convocado
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de
                                                            Alineaciones</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_alineaciones
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Minutos
                                                            Jugados</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.minutos_jugados
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de
                                                            Goles</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_goles
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de
                                                            Asistencias</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_asistencias
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de Gol
                                                            Penalti</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_gol_penalti
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de Penalti
                                                            cometido</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_penalti_cometido
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de Tiro al
                                                            Palo</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_tiro_palo
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                        >
                                                            Número de
                                                            Sustitución</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_sustitucion
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de Tarjeta
                                                            Amarilla</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_tarjeta_amarilla
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de Tarjeta
                                                            Roja</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_tarjeta_roja
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Número de
                                                            Lesiones</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.nro_lesiones
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Puntuación Valorada
                                                            Actual</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.puntuacion_valorada
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Fecha de
                                                            Registro</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.fecha_registro_t
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                            </v-row>
                                        </td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td>
                                            <ul class="flex-content">
                                                <li
                                                    class="flex-item"
                                                    data-label="Nombre del Jugador"
                                                >
                                                    {{ item.full_name }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Nacionalidad"
                                                >
                                                    {{ item.nacionalidad }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Número CI/DNI"
                                                >
                                                    {{ item.ci }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha de Nacimiento"
                                                >
                                                    {{ item.fecha_nac_t }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Posición de Juego"
                                                >
                                                    {{ item.posicion }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Altura"
                                                >
                                                    {{ item.altura }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Peso"
                                                >
                                                    {{ item.peso }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Pie"
                                                >
                                                    {{ item.pie }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Ver Más"
                                                >
                                                    <v-btn
                                                        :icon="
                                                            item.mas
                                                                ? 'mdi-chevron-down'
                                                                : 'mdi-chevron-left'
                                                        "
                                                        @click="
                                                            item.mas = !item.mas
                                                        "
                                                    ></v-btn>
                                                </li>
                                                <template v-if="item.mas">
                                                    <li
                                                        class="flex-item"
                                                        data-label="Valoración del Mercado Actual"
                                                    >
                                                        {{
                                                            item.valoracion_actual
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Teléfono"
                                                    >
                                                        {{ item.fono }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Dirección"
                                                    >
                                                        {{ item.dir }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Veces Convocado"
                                                    >
                                                        {{ item.nro_convocado }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Alineaciones"
                                                    >
                                                        {{
                                                            item.nro_alineaciones
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Minutos Jugados"
                                                    >
                                                        {{
                                                            item.minutos_jugados
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Goles"
                                                    >
                                                        {{ item.nro_goles }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Asistencias"
                                                    >
                                                        {{
                                                            item.nro_asistencias
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Gol Penalti"
                                                    >
                                                        {{
                                                            item.nro_gol_penalti
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Penalti cometido"
                                                    >
                                                        {{
                                                            item.nro_penalti_cometido
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Tiro al Palo"
                                                    >
                                                        {{ item.nro_tiro_palo }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Sustitución"
                                                    >
                                                        {{
                                                            item.nro_sustitucion
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Tarjeta Amarilla"
                                                    >
                                                        {{
                                                            item.nro_tarjeta_amarilla
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Tarjeta Roja"
                                                    >
                                                        {{
                                                            item.nro_tarjeta_roja
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Número de Lesiones"
                                                    >
                                                        {{ item.nro_lesiones }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Puntuación Valorada Actual"
                                                    >
                                                        {{
                                                            item.puntuacion_valorada
                                                        }}
                                                    </li>
                                                    <li
                                                        class="flex-item"
                                                        data-label="Fecha de Registro"
                                                    >
                                                        {{
                                                            item.fecha_registro
                                                        }}
                                                    </li></template
                                                >
                                            </ul>
                                            <v-row>
                                                <v-col
                                                    cols="12"
                                                    class="text-center pa-5"
                                                >
                                                    <v-btn
                                                        color="yellow"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            editarJugador(item)
                                                        "
                                                        icon="mdi-pencil"
                                                    ></v-btn>
                                                    <v-btn
                                                        color="error"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            eliminarJugador(
                                                                item
                                                            )
                                                        "
                                                        icon="mdi-trash-can"
                                                    ></v-btn>
                                                </v-col>
                                            </v-row>
                                        </td>
                                    </tr>
                                </template>
                            </template>
                        </v-data-table-server>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <Formulario
            :open_dialog="open_dialog"
            :accion_dialog="accion_dialog"
            @envio-formulario="recargaJugadors"
            @cerrar-dialog="open_dialog = false"
        ></Formulario>
    </v-container>
</template>
