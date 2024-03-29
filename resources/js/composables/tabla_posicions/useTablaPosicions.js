import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oTablaPosicion = ref({
    id: 0,
    equipo_id: null,
    tipo_torneo: null,
    temporada: "",
    pj: "",
    g: "",
    e: "",
    p: "",
    gf: "",
    gc: "",
    dg: "",
    pts: "",
    _method: "POST",
});

export const useTablaPosicions = () => {
    const { flash } = usePage().props;
    const getTablaPosicions = async () => {
        try {
            const response = await axios.get(route("tabla_posicions.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.tabla_posicions;
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

    const getTablaPosicionsApi = async (data) => {
        try {
            const response = await axios.get(
                route("tabla_posicions.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.tabla_posicions;
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
    const saveTablaPosicion = async (data) => {
        try {
            const response = await axios.post(
                route("tabla_posicions.store", data),
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

    const deleteTablaPosicion = async (id) => {
        try {
            const response = await axios.delete(
                route("tabla_posicions.destroy", id),
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

    const setTablaPosicion = (item = null) => {
        if (item) {
            oTablaPosicion.value.id = item.id;
            oTablaPosicion.value.equipo_id = item.equipo_id;
            oTablaPosicion.value.tipo_torneo = item.tipo_torneo;
            oTablaPosicion.value.temporada = item.temporada;
            oTablaPosicion.value.pj = item.pj;
            oTablaPosicion.value.g = item.g;
            oTablaPosicion.value.e = item.e;
            oTablaPosicion.value.p = item.p;
            oTablaPosicion.value.gf = item.gf;
            oTablaPosicion.value.gc = item.gc;
            oTablaPosicion.value.dg = item.dg;
            oTablaPosicion.value.pts = item.pts;
            oTablaPosicion.value._method = "PUT";
            return oTablaPosicion;
        }
        return false;
    };

    const limpiarTablaPosicion = () => {
        oTablaPosicion.value.id = 0;
        oTablaPosicion.value.equipo_id = null;
        oTablaPosicion.value.tipo_torneo = null;
        oTablaPosicion.value.temporada = "";
        oTablaPosicion.value.pj = "";
        oTablaPosicion.value.g = "";
        oTablaPosicion.value.e = "";
        oTablaPosicion.value.p = "";
        oTablaPosicion.value.gf = "";
        oTablaPosicion.value.gc = "";
        oTablaPosicion.value.dg = "";
        oTablaPosicion.value.pts = "";
        oTablaPosicion.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oTablaPosicion,
        getTablaPosicions,
        getTablaPosicionsApi,
        saveTablaPosicion,
        deleteTablaPosicion,
        setTablaPosicion,
        limpiarTablaPosicion,
    };
};
