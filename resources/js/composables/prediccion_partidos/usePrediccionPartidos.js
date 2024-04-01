import axios from "axios";
import { onMounted, reactive, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oPrediccionPartido = reactive({
    id: 0,
    local_id: null,
    alineacion_local_id: null,
    visitante_id: null,
    alineacion_visitante_id: null,
    p_ganador_id: "",
    ganador_id: "",
    g_local: null,
    g_visitante: null,
    p_ganador: ref(null),
    ganador: ref(null),
    _method: "POST",
});

export const usePrediccionPartidos = () => {
    const { flash } = usePage().props;
    const getPrediccionPartidos = async () => {
        try {
            const response = await axios.get(
                route("prediccion_partidos.listado"),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.prediccion_partidos;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getPrediccionPartidosApi = async (data) => {
        try {
            const response = await axios.get(
                route("prediccion_partidos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.prediccion_partidos;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const savePrediccionPartido = async (data) => {
        try {
            const response = await axios.post(
                route("prediccion_partidos.store", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
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
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const deletePrediccionPartido = async (id) => {
        try {
            const response = await axios.delete(
                route("prediccion_partidos.destroy", id),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
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
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const setPrediccionPartido = (item = null) => {
        if (item) {
            oPrediccionPartido.id = item.id;
            oPrediccionPartido.local_id = item.local_id;
            oPrediccionPartido.alineacion_local_id = item.alineacion_local_id;
            oPrediccionPartido.visitante_id = item.visitante_id;
            oPrediccionPartido.alineacion_visitante_id =
                item.alineacion_visitante_id;
            oPrediccionPartido.p_ganador_id = item.p_ganador_id;
            oPrediccionPartido.ganador_id = item.ganador_id;
            oPrediccionPartido.g_local = item.g_local;
            oPrediccionPartido.g_visitante = item.g_visitante;
            oPrediccionPartido.p_ganador = ref({ ...item.p_ganador });
            oPrediccionPartido.ganador = ref({ ...item.ganador });
            oPrediccionPartido._method = "PUT";
            return oPrediccionPartido;
        }
        return false;
    };

    const setGanadorPartido = (item = null) => {
        oPrediccionPartido.ganador = ref({ ...item });
        return oPrediccionPartido;
    };

    const setPGanadorPartido = (item = null) => {
        oPrediccionPartido.p_ganador = ref({ ...item });
        return oPrediccionPartido;
    };

    const limpiarPrediccionPartido = () => {
        oPrediccionPartido.id = 0;
        oPrediccionPartido.local_id = null;
        oPrediccionPartido.alineacion_local_id = null;
        oPrediccionPartido.visitante_id = null;
        oPrediccionPartido.alineacion_visitante_id = null;
        oPrediccionPartido.p_ganador_id = "";
        oPrediccionPartido.ganador_id = "";
        oPrediccionPartido.g_local = null;
        oPrediccionPartido.g_visitante = null;
        oPrediccionPartido.p_ganador = ref(null);
        oPrediccionPartido.ganador = ref(null);
        oPrediccionPartido._method = "POST";
    };

    onMounted(() => {});

    return {
        oPrediccionPartido,
        getPrediccionPartidos,
        getPrediccionPartidosApi,
        savePrediccionPartido,
        deletePrediccionPartido,
        setPrediccionPartido,
        limpiarPrediccionPartido,
        setGanadorPartido,
        setPGanadorPartido,
    };
};
