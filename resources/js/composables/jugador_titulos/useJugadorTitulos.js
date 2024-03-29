import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oJugadorTitulo = ref({
    id: 0,
    jugador_id: "",
    titulo: "",
    anio: "",
    fecha: "",
    descripcion: "",
    tipo: "",
    _method: "POST",
});

export const useJugadorTitulos = () => {
    const { flash } = usePage().props;
    const getJugadorTitulos = async () => {
        try {
            const response = await axios.get(route("jugador_titulos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.jugador_titulos;
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

    const getJugadorTitulosApi = async (data) => {
        try {
            const response = await axios.get(
                route("jugador_titulos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.jugador_titulos;
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
    const saveJugadorTitulo = async (data) => {
        try {
            const response = await axios.post(
                route("jugador_titulos.store", data),
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

    const deleteJugadorTitulo = async (id) => {
        try {
            const response = await axios.delete(
                route("jugador_titulos.destroy", id),
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

    const setJugadorTitulo = (item = null) => {
        if (item) {
            oJugadorTitulo.value.id = item.id;
            oJugadorTitulo.value.jugador_id = item.jugador_id;
            oJugadorTitulo.value.titulo = item.titulo;
            oJugadorTitulo.value.anio = item.anio;
            oJugadorTitulo.value.fecha = item.fecha;
            oJugadorTitulo.value.descripcion = item.descripcion;
            oJugadorTitulo.value.tipo = item.tipo;
            oJugadorTitulo.value._method = "PUT";
            return oJugadorTitulo;
        }
        return false;
    };

    const limpiarJugadorTitulo = () => {
        oJugadorTitulo.value.id = 0;
        oJugadorTitulo.value.jugador_id = "";
        oJugadorTitulo.value.titulo = "";
        oJugadorTitulo.value.anio = "";
        oJugadorTitulo.value.fecha = "";
        oJugadorTitulo.value.descripcion = "";
        oJugadorTitulo.value.tipo = "";
        oJugadorTitulo.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oJugadorTitulo,
        getJugadorTitulos,
        getJugadorTitulosApi,
        saveJugadorTitulo,
        deleteJugadorTitulo,
        setJugadorTitulo,
        limpiarJugadorTitulo,
    };
};
