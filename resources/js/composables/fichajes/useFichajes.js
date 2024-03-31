import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oFichaje = ref({
    id: 0,
    equipo_id: null,
    jugador_id: null,
    nro_polera: "",
    fecha_fichaje: "",
    contrato_hasta: "",
    descripcion: "",
    _method: "POST",
});

export const useFichajes = () => {
    const { flash } = usePage().props;
    const getFichajes = async () => {
        try {
            const response = await axios.get(route("fichajes.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.fichajes;
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
    const getFichajesByEquipo = async (data) => {
        try {
            const response = await axios.get(route("fichajes.byEquipo"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.fichajes;
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

    const getFichajesApi = async (data) => {
        try {
            const response = await axios.get(route("fichajes.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.fichajes;
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
    const saveFichaje = async (data) => {
        try {
            const response = await axios.post(route("fichajes.store", data), {
                headers: { Accept: "application/json" },
            });
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

    const deleteFichaje = async (id) => {
        try {
            const response = await axios.delete(route("fichajes.destroy", id), {
                headers: { Accept: "application/json" },
            });
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

    const setFichaje = (item = null) => {
        if (item) {
            oFichaje.value.id = item.id;
            oFichaje.value.equipo_id = item.equipo_id;
            oFichaje.value.jugador_id = item.jugador_id;
            oFichaje.value.nro_polera = item.nro_polera;
            oFichaje.value.fecha_fichaje = item.fecha_fichaje;
            oFichaje.value.contrato_hasta = item.contrato_hasta;
            oFichaje.value.descripcion = item.descripcion;
            oFichaje.value._method = "PUT";
            return oFichaje;
        }
        return false;
    };

    const limpiarFichaje = () => {
        oFichaje.value.id = 0;
        oFichaje.value.equipo_id = null;
        oFichaje.value.jugador_id = null;
        oFichaje.value.nro_polera = "";
        oFichaje.value.fecha_fichaje = "";
        oFichaje.value.contrato_hasta = "";
        oFichaje.value.descripcion = "";
        oFichaje.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oFichaje,
        getFichajes,
        getFichajesByEquipo,
        getFichajesApi,
        saveFichaje,
        deleteFichaje,
        setFichaje,
        limpiarFichaje,
    };
};
