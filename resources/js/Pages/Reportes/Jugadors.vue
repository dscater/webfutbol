<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Jugadores",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>

<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { Head, usePage } from "@inertiajs/vue3";
import { useJugadors } from "@/composables/jugadors/useJugadors";
const { getJugadors } = useJugadors();
const { setLoading } = useApp();

onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const form = ref({
    jugador_id: "TODOS",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const listJugadors = ref([]);

const cargarListas = async () => {
    listJugadors.value = await getJugadors({
        order: "desc",
    });

    listJugadors.value.unshift({
        id: "TODOS",
        full_name: "TODOS",
    });
};

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_jugadors", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

onMounted(() => {
    cargarListas();
});
</script>
<template>
    <Head title="Reporte Jugadores"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row>
            <v-col cols="12" sm="12" md="12" xl="8" class="mx-auto">
                <v-card>
                    <v-card-item>
                        <v-container>
                            <form @submit.prevent="generarReporte">
                                <v-row>
                                    <v-col cols="12">
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
                                            variant="outlined"
                                            density="compact"
                                            required
                                            :items="listJugadors"
                                            item-value="id"
                                            item-title="full_name"
                                            label="Seleccionar Jugador*"
                                            search
                                            v-model="form.jugador_id"
                                        ></v-select>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-btn
                                            color="blue-darken-2"
                                            block
                                            @click="generarReporte"
                                            :disabled="generando"
                                            v-text="txtBtn"
                                        ></v-btn>
                                    </v-col>
                                </v-row>
                            </form>
                        </v-container>
                    </v-card-item>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>
