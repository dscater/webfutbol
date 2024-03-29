import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oJugador = ref({
    id: 0,
    nombre: "",
    paterno: "",
    materno: "",
    nacionalidad: "",
    ci: "",
    fecha_nac: "",
    posicion: "",
    altura: "",
    peso: "",
    pie: "",
    valoracion_actual: "",
    correo: "",
    fono: "",
    dir: "",
    foto: "",
    nro_convocado: "",
    nro_alineaciones: "",
    minutos_jugados: "",
    nro_goles: "",
    nro_asistencias: "",
    nro_gol_penalti: "",
    nro_penalti_cometido: "",
    nro_tiro_palo: "",
    nro_sustitucion: "",
    nro_tarjeta_amarilla: "",
    nro_tarjeta_roja: "",
    nro_lesiones: "",
    puntuacion_valorada: "",
    _method: "POST",
});

export const useJugadors = () => {
    const { flash } = usePage().props;
    const getJugadors = async (data) => {
        try {
            const response = await axios.get(route("jugadors.listado"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.jugadors;
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

    const getJugadorsApi = async (data) => {
        try {
            const response = await axios.get(route("jugadors.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.jugadors;
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
    const saveJugador = async (data) => {
        try {
            const response = await axios.post(route("jugadors.store", data), {
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

    const deleteJugador = async (id) => {
        try {
            const response = await axios.delete(route("jugadors.destroy", id), {
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

    const setJugador = (item = null) => {
        if (item) {
            oJugador.value.id = item.id;
            oJugador.value.nombre = item.nombre;
            oJugador.value.paterno = item.paterno;
            oJugador.value.materno = item.materno;
            oJugador.value.nacionalidad = item.nacionalidad;
            oJugador.value.ci = item.ci;
            oJugador.value.fecha_nac = item.fecha_nac;
            oJugador.value.posicion = item.posicion;
            oJugador.value.altura = item.altura;
            oJugador.value.peso = item.peso;
            oJugador.value.pie = item.pie;
            oJugador.value.valoracion_actual = item.valoracion_actual;
            oJugador.value.correo = item.correo;
            oJugador.value.fono = item.fono;
            oJugador.value.dir = item.dir;
            oJugador.value.foto = item.foto;
            oJugador.value.nro_convocado = item.nro_convocado;
            oJugador.value.nro_alineaciones = item.nro_alineaciones;
            oJugador.value.minutos_jugados = item.minutos_jugados;
            oJugador.value.nro_goles = item.nro_goles;
            oJugador.value.nro_asistencias = item.nro_asistencias;
            oJugador.value.nro_gol_penalti = item.nro_gol_penalti;
            oJugador.value.nro_penalti_cometido = item.nro_penalti_cometido;
            oJugador.value.nro_tiro_palo = item.nro_tiro_palo;
            oJugador.value.nro_sustitucion = item.nro_sustitucion;
            oJugador.value.nro_tarjeta_amarilla = item.nro_tarjeta_amarilla;
            oJugador.value.nro_tarjeta_roja = item.nro_tarjeta_roja;
            oJugador.value.nro_lesiones = item.nro_lesiones;
            oJugador.value.puntuacion_valorada = item.puntuacion_valorada;
            oJugador.value._method = "PUT";
            return oJugador;
        }
        return false;
    };

    const limpiarJugador = () => {
        oJugador.value.id = 0;
        oJugador.value.nombre = "";
        oJugador.value.paterno = "";
        oJugador.value.materno = "";
        oJugador.value.nacionalidad = "";
        oJugador.value.ci = "";
        oJugador.value.fecha_nac = "";
        oJugador.value.posicion = "";
        oJugador.value.altura = "";
        oJugador.value.peso = "";
        oJugador.value.pie = "";
        oJugador.value.valoracion_actual = "";
        oJugador.value.correo = "";
        oJugador.value.fono = "";
        oJugador.value.dir = "";
        oJugador.value.foto = "";
        oJugador.value.nro_convocado = "";
        oJugador.value.nro_alineaciones = "";
        oJugador.value.minutos_jugados = "";
        oJugador.value.nro_goles = "";
        oJugador.value.nro_asistencias = "";
        oJugador.value.nro_gol_penalti = "";
        oJugador.value.nro_penalti_cometido = "";
        oJugador.value.nro_tiro_palo = "";
        oJugador.value.nro_sustitucion = "";
        oJugador.value.nro_tarjeta_amarilla = "";
        oJugador.value.nro_tarjeta_roja = "";
        oJugador.value.nro_lesiones = "";
        oJugador.value.puntuacion_valorada = "";
        oJugador.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oJugador,
        getJugadors,
        getJugadorsApi,
        saveJugador,
        deleteJugador,
        setJugador,
        limpiarJugador,
    };
};
