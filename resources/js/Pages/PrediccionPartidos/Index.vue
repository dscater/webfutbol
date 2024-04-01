<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Alineación de Equipos",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { useMenu } from "@/composables/useMenu";
import { Head } from "@inertiajs/vue3";
import { usePrediccionPartidos } from "@/composables/prediccion_partidos/usePrediccionPartidos";
import { ref, onMounted } from "vue";
const { mobile, identificaDispositivo, cambiarUrl } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getPrediccionPartidosApi, deletePrediccionPartido } =
    usePrediccionPartidos();
const responsePrediccionPartidos = ref([]);
const listPrediccionPartidos = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Equipo Local",
        align: "start",
        sortable: false,
    },
    { title: "Equipo Visitante", align: "start", sortable: false },
    { title: "Resultado Predicción", align: "start", sortable: false },
    { title: "Resultado", align: "start", sortable: false },
    { title: "Fecha de Registro", align: "start", sortable: false },
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
        responsePrediccionPartidos.value = await getPrediccionPartidosApi(
            options.value
        );
        listPrediccionPartidos.value = responsePrediccionPartidos.value.data;
        totalItems.value = parseInt(responsePrediccionPartidos.value.total);
        loading.value = false;
    }, 300);
};
const recargaPrediccionPartidos = async () => {
    loading.value = true;
    listPrediccionPartidos.value = [];
    options.value.search = search.value;
    responsePrediccionPartidos.value = await getPrediccionPartidosApi(
        options.value
    );
    listPrediccionPartidos.value = responsePrediccionPartidos.value.data;
    totalItems.value = parseInt(responsePrediccionPartidos.value.total);
    setTimeout(() => {
        loading.value = false;
    }, 300);
};

const editarPrediccionPartido = (item) => {
    cambiarUrl(route("prediccion_partidos.edit", item.id));
};

const eliminarPrediccionPartido = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong> ${item.local.nombre}(${
            item.g_local ? item.g_local : "-"
        }) &mdash;
                                                    ${item.visitante.nombre}(${
            item.g_visitante ? item.g_visitante : "-"
        })</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deletePrediccionPartido(item.id);
            if (respuesta && respuesta.sw) {
                recargaPrediccionPartidos();
            }
        }
    });
};
</script>
<template>
    <Head title="Alineación de Equipos"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="primary"
                    prepend-icon="mdi-plus"
                    @click="cambiarUrl(route('prediccion_partidos.create'))"
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
                            <v-col cols="12" sm="6" md="4">
                                Alineación de Equipos
                            </v-col>
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
                            :items="listPrediccionPartidos"
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
                                <template v-if="!mobile">
                                    <tr>
                                        <td>
                                            {{ item.local.nombre }}
                                        </td>
                                        <td>
                                            {{ item.visitante.nombre }}
                                        </td>
                                        <td>
                                            <span v-if="item.p_ganador"
                                                >Ganador: "{{
                                                    item.p_ganador.nombre
                                                }}"</span
                                            >
                                            <span v-else>EMPATÉ</span>
                                        </td>
                                        <td>
                                            {{ item.local.nombre }}({{
                                                item.g_local
                                                    ? item.g_local
                                                    : "-"
                                            }}) &mdash;
                                            {{ item.visitante.nombre }}({{
                                                item.g_visitante
                                                    ? item.g_visitante
                                                    : "-"
                                            }})
                                        </td>
                                        <td>{{ item.fecha_registro_t }}</td>
                                        <td class="text-right" width="5%">
                                            <v-btn
                                                color="yellow"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="
                                                    editarPrediccionPartido(
                                                        item
                                                    )
                                                "
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="
                                                    eliminarPrediccionPartido(
                                                        item
                                                    )
                                                "
                                                icon="mdi-trash-can"
                                            ></v-btn>
                                        </td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td>
                                            <ul class="flex-content">
                                                <li
                                                    class="flex-item"
                                                    data-label="Equipo Local"
                                                >
                                                    {{ item.local.nombre }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Equipo Visitante"
                                                >
                                                    {{ item.visitante.nombre }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Resultado Predicción"
                                                >
                                                    <span v-if="item.p_ganador"
                                                        >Ganador: "{{
                                                            item.p_ganador
                                                                .nombre
                                                        }}"</span
                                                    >
                                                    <span v-else>Empaté</span>
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Resultado"
                                                >
                                                    {{ item.local.nombre }}({{
                                                        item.g_local
                                                            ? item.g_local
                                                            : "-"
                                                    }}) &mdash;
                                                    {{
                                                        item.visitante.nombre
                                                    }}({{
                                                        item.g_visitante
                                                            ? item.g_visitante
                                                            : "-"
                                                    }})
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha de Registro"
                                                >
                                                    {{ item.fecha_registro }}
                                                </li>
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
                                                            editarPrediccionPartido(
                                                                item
                                                            )
                                                        "
                                                        icon="mdi-pencil"
                                                    ></v-btn>
                                                    <v-btn
                                                        color="error"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            eliminarPrediccionPartido(
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
    </v-container>
</template>
