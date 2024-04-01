<script setup>
import { watch, ref, computed, defineEmits } from "vue";
const props = defineProps({
    jugador: {
        type: Object,
        default: null,
    },
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);

var o_jugador = ref(props.jugador);

watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
        }
    }
);
watch(
    () => props.jugador,
    (newValue) => {
        o_jugador = newValue;
    }
);

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Información de Jugador` : `Editar Usuario`;
});

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
        <v-dialog v-model="dialog" width="600" persistent scrollable>
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
                        <v-row v-if="o_jugador" align="center" justify="center">
                            <v-col cols="12" md="8" xl="8" class="text-center">
                                <v-card>
                                    <v-card-text>
                                        <v-row>
                                            <v-col cols="12">
                                                <v-avatar
                                                    color="primary"
                                                    size="100"
                                                    cover
                                                    class="mx-auto"
                                                >
                                                    <v-img
                                                        :src="
                                                            o_jugador.url_foto
                                                        "
                                                        alt=""
                                                        cover
                                                        v-if="
                                                            o_jugador.url_foto
                                                        "
                                                    ></v-img>
                                                    <span v-else>{{
                                                        o_jugador.iniciales_nombre
                                                    }}</span>
                                                </v-avatar>
                                                <p class="font-weight-bold mt-1 text-body-1">{{ o_jugador.full_name }}</p>
                                                <p class="mt-1 text-body-2"><strong>Edad:</strong> {{ o_jugador.edad }} AÑOS</p>
                                                <p class="mt-1 text-body-2"><strong>Posición:</strong> {{ o_jugador.posicion }}</p>
                                                <p class="mt-1 text-body-2"><strong>Estatura:</strong> {{ o_jugador.altura }}</p>
                                                <p class="mt-1 text-body-2"><strong>Peso:</strong> {{ o_jugador.peso }}</p>

                                            </v-col>
                                        </v-row>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions class="border-t">
                    <v-spacer></v-spacer>
                    <v-btn
                        color="grey-darken-4"
                        variant="text"
                        @click="cerrarDialog"
                    >
                        Cerrar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>
