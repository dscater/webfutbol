import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, reactive } from "vue";
import { usePage } from "@inertiajs/vue3";

const oAlineacionEquipo = reactive({
    id: 0,
    equipo_id: null,
    nombre: "",
    alineacion_detalles: reactive([]),
    eliminados: reactive([]),
    _method: "POST",
});

export const useAlineacionEquipos = () => {
    const { flash } = usePage().props;
    const getAlineacionEquipos = async (data) => {
        try {
            const response = await axios.get(
                route("alineacion_equipos.listado"),
                {
                    headers: { Accept: "application/json" },
                    params: data,
                }
            );
            return response.data.alineacion_equipos;
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
    const getAlineacionEquiposById = async (data) => {
        try {
            const response = await axios.get(route("alineacion_equipos.ById"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.alineacion_equipo;
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
    const getAlineacionEquiposByEquipo = async (data) => {
        try {
            const response = await axios.get(
                route("alineacion_equipos.byEquipo"),
                {
                    headers: { Accept: "application/json" },
                    params: data,
                }
            );
            return response.data.alineacion_equipos;
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

    const getAlineacionEquiposApi = async (data) => {
        try {
            const response = await axios.get(
                route("alineacion_equipos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.alineacion_equipos;
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
    const saveAlineacionEquipo = async (data) => {
        try {
            const response = await axios.post(
                route("alineacion_equipos.store", data),
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

    const deleteAlineacionEquipo = async (id) => {
        try {
            const response = await axios.delete(
                route("alineacion_equipos.destroy", id),
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

    const setAlineacionEquipo = (item = null) => {
        if (item) {
            oAlineacionEquipo.id = item.id;
            oAlineacionEquipo.equipo_id = item.equipo_id;
            oAlineacionEquipo.nombre = item.nombre;
            oAlineacionEquipo.alineacion_detalles = reactive([
                ...item.alineacion_detalles,
            ]);
            oAlineacionEquipo.eliminados = reactive([]);
            oAlineacionEquipo._method = "PUT";
            return oAlineacionEquipo;
        }
        return false;
    };

    const limpiarAlineacionEquipo = () => {
        oAlineacionEquipo.id = 0;
        oAlineacionEquipo.equipo_id = null;
        oAlineacionEquipo.nombre = "";
        oAlineacionEquipo.alineacion_detalles = reactive([]);
        oAlineacionEquipo.eliminados = reactive([]);
        oAlineacionEquipo._method = "POST";
    };

    const addAlineacionDetalle = (item) => {
        oAlineacionEquipo.alineacion_detalles.push(item);
    };

    const eliminarAlineacionDetalle = (index, id = 0) => {
        if (id != 0) {
            oAlineacionEquipo.eliminados.push(id);
        }
        oAlineacionEquipo.alineacion_detalles.splice(index, 1);
    };

    onMounted(() => {});

    return {
        oAlineacionEquipo,
        getAlineacionEquipos,
        getAlineacionEquiposById,
        getAlineacionEquiposByEquipo,
        getAlineacionEquiposApi,
        saveAlineacionEquipo,
        deleteAlineacionEquipo,
        setAlineacionEquipo,
        limpiarAlineacionEquipo,
        addAlineacionDetalle,
        eliminarAlineacionDetalle,
    };
};
