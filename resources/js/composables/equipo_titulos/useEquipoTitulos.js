import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oEquipoTitulo = ref({
    id: 0,
    equipo_id: "",
    titulo: "",
    anio: "",
    fecha: "",
    descripcion: "",
    tipo: "",
    _method: "POST",
});

export const useEquipoTitulos = () => {
    const { flash } = usePage().props;
    const getEquipoTitulos = async () => {
        try {
            const response = await axios.get(route("equipo_titulos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.equipo_titulos;
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

    const getEquipoTitulosApi = async (data) => {
        try {
            const response = await axios.get(
                route("equipo_titulos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.equipo_titulos;
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
    const saveEquipoTitulo = async (data) => {
        try {
            const response = await axios.post(
                route("equipo_titulos.store", data),
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

    const deleteEquipoTitulo = async (id) => {
        try {
            const response = await axios.delete(
                route("equipo_titulos.destroy", id),
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

    const setEquipoTitulo = (item = null) => {
        if (item) {
            oEquipoTitulo.value.id = item.id;
            oEquipoTitulo.value.equipo_id = item.equipo_id;
            oEquipoTitulo.value.titulo = item.titulo;
            oEquipoTitulo.value.anio = item.anio;
            oEquipoTitulo.value.fecha = item.fecha;
            oEquipoTitulo.value.descripcion = item.descripcion;
            oEquipoTitulo.value.tipo = item.tipo;
            oEquipoTitulo.value._method = "PUT";
            return oEquipoTitulo;
        }
        return false;
    };

    const limpiarEquipoTitulo = () => {
        oEquipoTitulo.value.id = 0;
        oEquipoTitulo.equipo_id = "";
        oEquipoTitulo.titulo = "";
        oEquipoTitulo.anio = "";
        oEquipoTitulo.fecha = "";
        oEquipoTitulo.descripcion = "";
        oEquipoTitulo.tipo = "";
        oEquipoTitulo.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oEquipoTitulo,
        getEquipoTitulos,
        getEquipoTitulosApi,
        saveEquipoTitulo,
        deleteEquipoTitulo,
        setEquipoTitulo,
        limpiarEquipoTitulo,
    };
};
