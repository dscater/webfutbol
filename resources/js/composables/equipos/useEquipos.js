import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oEquipo = ref({
    id: 0,
    nombre: "",
    nombre_p: "",
    nombre_e: "",
    fundacion: "",
    colores: "",
    ubicacion: "",
    logo: null,
    _method: "POST",
});

export const useEquipos = () => {
    const { flash } = usePage().props;
    const getEquipos = async () => {
        try {
            const response = await axios.get(route("equipos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.equipos;
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

    const getEquiposApi = async (data) => {
        try {
            const response = await axios.get(route("equipos.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.equipos;
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
    const saveEquipo = async (data) => {
        try {
            const response = await axios.post(route("equipos.store", data), {
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

    const deleteEquipo = async (id) => {
        try {
            const response = await axios.delete(route("equipos.destroy", id), {
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

    const setEquipo = (item = null) => {
        if (item) {
            oEquipo.value.id = item.id;
            oEquipo.value.nombre = item.nombre;
            oEquipo.value.nombre_p = item.nombre_p;
            oEquipo.value.nombre_e = item.nombre_e;
            oEquipo.value.fundacion = item.fundacion;
            oEquipo.value.colores = item.colores;
            oEquipo.value.ubicacion = item.ubicacion;
            oEquipo.value.logo = item.logo;
            oEquipo.value._method = "PUT";
            return oEquipo;
        }
        return false;
    };

    const limpiarEquipo = () => {
        oEquipo.value.id = 0;
        oEquipo.nombre = "";
        oEquipo.nombre_p = "";
        oEquipo.nombre_e = "";
        oEquipo.fundacion = "";
        oEquipo.colores = "";
        oEquipo.ubicacion = "";
        oEquipo.logo = null;
        oEquipo.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oEquipo,
        getEquipos,
        getEquiposApi,
        saveEquipo,
        deleteEquipo,
        setEquipo,
        limpiarEquipo,
    };
};
