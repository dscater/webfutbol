<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useTablaPosicions } from "@/composables/tabla_posicions/useTablaPosicions";
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

const { oTablaPosicion, limpiarTablaPosicion } = useTablaPosicions();
const { getEquipos } = useEquipos();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);

const listEquipos = ref([]);
const listTipoTorneos = ref([
    { value: "APERTURA", label: "APERTURA" },
    { value: "CLAUSURA", label: "CLAUSURA" },
    { value: "CAMPEONATO", label: "CAMPEONATO" },
    { value: "COPA", label: "COPA" },
]);

let form = useForm(oTablaPosicion.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oTablaPosicion.value);
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

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `Agregar Tabla de Posición`
        : `Editar Tabla de Posición`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("tabla_posicions.store")
            : route("tabla_posicions.update", form.id);

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
            limpiarTablaPosicion();
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
                                            form.errors?.tipo_torneo
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.tipo_torneo
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.tipo_torneo
                                                ? form.errors?.tipo_torneo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listTipoTorneos"
                                        label="Tipo de Torneo*"
                                        item-value="value"
                                        item-title="label"
                                        v-model="form.tipo_torneo"
                                        required
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.temporada
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.temporada
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.temporada
                                                ? form.errors?.temporada
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Temporada(Año)*"
                                        required
                                        density="compact"
                                        v-model="form.temporada"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.pj ? false : true
                                        "
                                        :error="form.errors?.pj ? true : false"
                                        :error-messages="
                                            form.errors?.pj
                                                ? form.errors?.pj
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Partidos Jugados(PJ)*"
                                        required
                                        density="compact"
                                        v-model="form.pj"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.g ? false : true
                                        "
                                        :error="form.errors?.g ? true : false"
                                        :error-messages="
                                            form.errors?.g ? form.errors?.g : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Ganados(G)*"
                                        required
                                        density="compact"
                                        v-model="form.g"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.e ? false : true
                                        "
                                        :error="form.errors?.e ? true : false"
                                        :error-messages="
                                            form.errors?.e ? form.errors?.e : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Empates(E)*"
                                        required
                                        density="compact"
                                        v-model="form.e"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.p ? false : true
                                        "
                                        :error="form.errors?.p ? true : false"
                                        :error-messages="
                                            form.errors?.p ? form.errors?.p : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Perdidas(P)*"
                                        required
                                        density="compact"
                                        v-model="form.p"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.gf ? false : true
                                        "
                                        :error="form.errors?.gf ? true : false"
                                        :error-messages="
                                            form.errors?.gf
                                                ? form.errors?.gf
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Goles a favor(GF)*"
                                        required
                                        density="compact"
                                        v-model="form.gf"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.gc ? false : true
                                        "
                                        :error="form.errors?.gc ? true : false"
                                        :error-messages="
                                            form.errors?.gc
                                                ? form.errors?.gc
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Goles en Contra(GC)*"
                                        required
                                        density="compact"
                                        v-model="form.gc"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.dg ? false : true
                                        "
                                        :error="form.errors?.dg ? true : false"
                                        :error-messages="
                                            form.errors?.dg
                                                ? form.errors?.dg
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Diferencia de Goles(DG)*"
                                        required
                                        density="compact"
                                        v-model="form.dg"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.pts ? false : true
                                        "
                                        :error="form.errors?.pts ? true : false"
                                        :error-messages="
                                            form.errors?.pts
                                                ? form.errors?.pts
                                                : ''
                                        "
                                        type="number"
                                        step="1"
                                        variant="outlined"
                                        label="Puntos(PTS)*"
                                        required
                                        density="compact"
                                        v-model="form.pts"
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
