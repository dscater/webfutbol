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
import { useAlineacionEquipos } from "@/composables/alineacion_equipos/useAlineacionEquipos";
import { ref, onMounted } from "vue";
const { mobile, identificaDispositivo, cambiarUrl } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getAlineacionEquiposApi, deleteAlineacionEquipo } =
    useAlineacionEquipos();
const responseAlineacionEquipos = ref([]);
const listAlineacionEquipos = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Nombre del Equipo",
        align: "start",
        sortable: false,
    },
    { title: "Nombre de Alineación", align: "start", sortable: false },
    { title: "Fecha de Registro", align: "start", sortable: false },
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
        responseAlineacionEquipos.value = await getAlineacionEquiposApi(
            options.value
        );
        listAlineacionEquipos.value = responseAlineacionEquipos.value.data;
        totalItems.value = parseInt(responseAlineacionEquipos.value.total);
        loading.value = false;
    }, 300);
};
const recargaAlineacionEquipos = async () => {
    loading.value = true;
    listAlineacionEquipos.value = [];
    options.value.search = search.value;
    responseAlineacionEquipos.value = await getAlineacionEquiposApi(
        options.value
    );
    listAlineacionEquipos.value = responseAlineacionEquipos.value.data;
    totalItems.value = parseInt(responseAlineacionEquipos.value.total);
    setTimeout(() => {
        loading.value = false;
    }, 300);
};

const editarAlineacionEquipo = (item) => {
    cambiarUrl(route("alineacion_equipos.edit", item.id));
};

const eliminarAlineacionEquipo = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.nombre}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteAlineacionEquipo(item.id);
            if (respuesta && respuesta.sw) {
                recargaAlineacionEquipos();
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
                    @click="cambiarUrl(route('alineacion_equipos.create'))"
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
                            :items="listAlineacionEquipos"
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
                                            {{ item.equipo.nombre }}
                                        </td>
                                        <td>
                                            {{ item.nombre }}
                                        </td>
                                        <td>{{ item.fecha_registro_t }}</td>
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
                                        <td class="text-right" width="5%">
                                            <v-btn
                                                color="yellow"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="
                                                    editarAlineacionEquipo(item)
                                                "
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="
                                                    eliminarAlineacionEquipo(
                                                        item
                                                    )
                                                "
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
                                                    cols="12"
                                                    md="6"
                                                    class="text-center"
                                                >
                                                    <v-list class="pt-0">
                                                        <template
                                                            v-for="(
                                                                item, i
                                                            ) in item.alineacion_detalles"
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
                                                            </v-list-item>
                                                            <!-- <v-divider
                                                                v-if="
                                                                    i <
                                                                    item
                                                                        .alineacion_detalles
                                                                        .length -
                                                                        1
                                                                "
                                                            ></v-divider> -->
                                                        </template>
                                                    </v-list>
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
                                                    data-label="Nombre del Equipo"
                                                >
                                                    {{ item.equipo.nombre }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Nombre de Alineación"
                                                >
                                                    {{ item.nombre }}
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
                                                            editarAlineacionEquipo(
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
                                                            eliminarAlineacionEquipo(
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
