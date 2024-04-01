<script setup>
import { useMenu } from "@/composables/useMenu";
import { onMounted, ref } from "vue";
import { usePage, router } from "@inertiajs/vue3";
import { useUser } from "@/composables/useUser";
const { oUser } = useUser();

// data
const {
    mobile,
    drawer,
    rail,
    width,
    menu_open,
    setMenuOpen,
    cambiarUrl,
    toggleDrawer,
} = useMenu();

const user_logeado = ref({
    permisos: [],
});

const submenus = {
    "equipos.index": "Equipos",
    "equipo_titulos.index": "Equipos",
    "jugadors.index": "Jugadors",
    "jugador_titulos.index": "Jugadors",
    "reportes.usuarios": "Reportes",
    "reportes.equipos": "Reportes",
    "reportes.jugadors": "Reportes",
    "reportes.equipo_jugadors": "Reportes",
    "reportes.tabla_posicions": "Reportes",
    "reportes.g_tabla_posicions": "Reportes",
};

const route_current = ref("");

router.on("navigate", (event) => {
    route_current.value = route().current();
    if (mobile.value) {
        toggleDrawer(false);
    }
});

const { props: props_page } = usePage();

onMounted(() => {
    let route_actual = route().current();
    // buscar en submenus y abrirlo si uno de sus elementos esta activo
    setMenuOpen([]);
    if (submenus[route_actual]) {
        setMenuOpen([submenus[route_actual]]);
    }

    if (props_page.auth) {
        user_logeado.value = props_page.auth?.user;
    }

    setTimeout(() => {
        scrollActive();
    }, 300);
});

const scrollActive = () => {
    let sidebar = document.querySelector("#sidebar");
    let menu = null;
    let activeChild = null;
    if (sidebar) {
        menu = sidebar.querySelector(".v-navigation-drawer__content");
        activeChild = sidebar.querySelector(".active");
    }
    // Verifica si se encontró un hijo activo
    if (activeChild) {
        let offsetTop = activeChild.offsetTop - sidebar.offsetTop;
        setTimeout(() => {
            menu.scrollTo({
                top: offsetTop,
                behavior: "smooth", // desplazamiento suave
            });
        }, 500);
    }
};
</script>
<template>
    <v-navigation-drawer
        :permanent="!mobile"
        :temporary="mobile"
        v-model="drawer"
        class="border-0 elevation-2 __sidebar"
        :width="width"
        id="sidebar"
    >
        <v-sheet>
            <div
                class="w-100 d-flex flex-column align-center elevation-1 bg-primary pa-2 __info_usuario"
            >
                <v-avatar
                    class="mb-1"
                    color="orange-darken-4"
                    :size="`${!rail ? '64' : '32'}`"
                >
                    <v-img
                        cover
                        v-if="oUser.url_foto"
                        :src="oUser.url_foto"
                    ></v-img>
                    <span v-else class="text-h5">
                        {{ oUser.iniciales_nombre }}
                    </span>
                </v-avatar>
                <div v-show="!rail" class="text-caption font-weight-bold">
                    {{ oUser.tipo }}
                </div>
                <div v-show="!rail" class="text-body">
                    {{ oUser.full_name }}
                </div>
            </div>
        </v-sheet>

        <v-list class="mt-1 px-2" v-model:opened="menu_open">
            <v-list-item class="text-caption">
                <span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>INICIO</span></v-list-item
            >
            <v-list-item
                prepend-icon="mdi-home-outline"
                :class="[route_current == 'inicio' ? 'active' : '']"
                @click="cambiarUrl(route('inicio'))"
                link
            >
                <v-list-item-title>Inicio</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Inicio</v-tooltip
                >
            </v-list-item>
            <v-list-item
                class="text-caption"
                v-if="
                    oUser.permisos.includes('usuarios.index') ||
                    oUser.permisos.includes('equipos.index') ||
                    oUser.permisos.includes('equipo_titulos.index') ||
                    oUser.permisos.includes('jugadors.index') ||
                    oUser.permisos.includes('jugador_titulos.index') ||
                    oUser.permisos.includes('prediccion_partidos.index') ||
                    oUser.permisos.includes('alineacion_equipos.index') ||
                    oUser.permisos.includes('fichajes.index')
                "
            >
                <span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>ADMINISTRACIÓN</span></v-list-item
            >
            <v-list-item
                :class="[
                    route_current == 'prediccion_partidos.index'
                        ? 'active'
                        : '',
                ]"
                v-if="oUser.permisos.includes('prediccion_partidos.index')"
                prepend-icon="mdi-list-status"
                @click="cambiarUrl(route('prediccion_partidos.index'))"
                link
            >
                <v-list-item-title>Predicción del Partido</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Predicción del Partido</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[
                    route_current == 'alineacion_equipos.index' ||
                    route_current == 'alineacion_equipos.create' ||
                    route_current == 'alineacion_equipos.edit'
                        ? 'active'
                        : '',
                ]"
                v-if="oUser.permisos.includes('alineacion_equipos.index')"
                prepend-icon="mdi-clipboard-list"
                @click="cambiarUrl(route('alineacion_equipos.index'))"
                link
            >
                <v-list-item-title>Alineación de Equipos</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Alineación de Equipos</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[
                    route_current == 'tabla_posicions.index' ? 'active' : '',
                ]"
                v-if="oUser.permisos.includes('tabla_posicions.index')"
                prepend-icon="mdi-table"
                @click="cambiarUrl(route('tabla_posicions.index'))"
                link
            >
                <v-list-item-title>Tabla de Posiciones</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Tabla de Posiciones</v-tooltip
                >
            </v-list-item>
            <!-- SUBGROUP 1 -->
            <v-list-group
                value="Equipos"
                v-if="
                    oUser.permisos.includes('equipos.index') ||
                    oUser.permisos.includes('equipo_tituloss.index')
                "
            >
                <template v-slot:activator="{ props }">
                    <v-list-item
                        v-bind="props"
                        prepend-icon="mdi-view-list"
                        title="Equipos"
                        :class="[
                            route_current == 'equipos.index' ||
                            route_current == 'equipo_titulos.index'
                                ? 'active'
                                : '',
                        ]"
                    >
                        <v-tooltip
                            v-if="rail && !mobile"
                            color="white"
                            activator="parent"
                            location="end"
                            >Equipos</v-tooltip
                        ></v-list-item
                    >
                </template>
                <v-list-item
                    v-if="oUser.permisos.includes('equipos.index')"
                    prepend-icon="mdi-chevron-right"
                    title="Equipos"
                    :class="[route_current == 'equipos.index' ? 'active' : '']"
                    @click="cambiarUrl(route('equipos.index'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Equipos</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('equipo_titulos.index')"
                    prepend-icon="mdi-chevron-right"
                    title="Títulos de Equipos"
                    :class="[
                        route_current == 'equipo_titulos.index' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('equipo_titulos.index'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Títulos de Equipos</v-tooltip
                    ></v-list-item
                >
            </v-list-group>
            <!-- SUBGROUP 2 -->
            <v-list-group
                value="Jugadors"
                v-if="
                    oUser.permisos.includes('jugadors.index') ||
                    oUser.permisos.includes('jugador_tituloss.index')
                "
            >
                <template v-slot:activator="{ props }">
                    <v-list-item
                        v-bind="props"
                        prepend-icon="mdi-account-multiple-outline"
                        title="Jugadores"
                        :class="[
                            route_current == 'jugadors.index' ||
                            route_current == 'jugador_titulos.index'
                                ? 'active'
                                : '',
                        ]"
                    >
                        <v-tooltip
                            v-if="rail && !mobile"
                            color="white"
                            activator="parent"
                            location="end"
                            >Jugadores</v-tooltip
                        ></v-list-item
                    >
                </template>
                <v-list-item
                    v-if="oUser.permisos.includes('jugadors.index')"
                    prepend-icon="mdi-chevron-right"
                    title="Jugadores"
                    :class="[route_current == 'jugadors.index' ? 'active' : '']"
                    @click="cambiarUrl(route('jugadors.index'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Jugadores</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('jugador_titulos.index')"
                    prepend-icon="mdi-chevron-right"
                    title="Títulos de Jugadores"
                    :class="[
                        route_current == 'jugador_titulos.index'
                            ? 'active'
                            : '',
                    ]"
                    @click="cambiarUrl(route('jugador_titulos.index'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Títulos de Jugadores</v-tooltip
                    ></v-list-item
                >
            </v-list-group>
            <v-list-item
                :class="[route_current == 'fichajes.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('fichajes.index')"
                prepend-icon="mdi-clipboard-edit"
                @click="cambiarUrl(route('fichajes.index'))"
                link
            >
                <v-list-item-title>Fichajes</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Fichajes</v-tooltip
                >
            </v-list-item>
            <v-list-item
                :class="[route_current == 'usuarios.index' ? 'active' : '']"
                v-if="oUser.permisos.includes('usuarios.index')"
                prepend-icon="mdi-account-group"
                @click="cambiarUrl(route('usuarios.index'))"
                link
            >
                <v-list-item-title>Usuarios</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Usuarios</v-tooltip
                >
            </v-list-item>

            <v-list-item class="text-caption"
                ><span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>REPORTES</span></v-list-item
            >
            <!-- SUBGROUP 3 -->
            <v-list-group
                value="Reportes"
                v-if="
                    oUser.permisos.includes('reportes.usuarios') ||
                    oUser.permisos.includes('reportes.equipos') ||
                    oUser.permisos.includes('reportes.jugadors') ||
                    oUser.permisos.includes('reportes.equipo_jugadors') ||
                    oUser.permisos.includes('reportes.tabla_posicions')
                "
            >
                <template v-slot:activator="{ props }">
                    <v-list-item
                        v-bind="props"
                        prepend-icon="mdi-file-document-multiple"
                        title="Reportes"
                        :class="[
                            route_current == 'reportes.usuarios' ||
                            route_current == 'reportes.equipos' ||
                            route_current == 'reportes.jugadors' ||
                            route_current == 'reportes.equipo_jugadors' ||
                            route_current == 'reportes.tabla_posicions' ||
                            route_current == 'reportes.g_tabla_posicions'
                                ? 'active'
                                : '',
                        ]"
                    >
                        <v-tooltip
                            v-if="rail && !mobile"
                            color="white"
                            activator="parent"
                            location="end"
                            >Reportes</v-tooltip
                        ></v-list-item
                    >
                </template>
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.usuarios')"
                    prepend-icon="mdi-chevron-right"
                    title="Lista de Usuarios"
                    :class="[
                        route_current == 'reportes.usuarios' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('reportes.usuarios'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Lista de Usuarios</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.equipos')"
                    prepend-icon="mdi-chevron-right"
                    title="Equipos"
                    :class="[
                        route_current == 'reportes.equipos' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('reportes.equipos'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Equipos</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.jugadors')"
                    prepend-icon="mdi-chevron-right"
                    title="Jugadores"
                    :class="[
                        route_current == 'reportes.jugadors' ? 'active' : '',
                    ]"
                    @click="cambiarUrl(route('reportes.jugadors'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Jugadores</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.equipo_jugadors')"
                    prepend-icon="mdi-chevron-right"
                    title="Jugadores por Equipo"
                    :class="[
                        route_current == 'reportes.equipo_jugadors'
                            ? 'active'
                            : '',
                    ]"
                    @click="cambiarUrl(route('reportes.equipo_jugadors'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Jugadores por Equipo</v-tooltip
                    ></v-list-item
                >
                <v-list-item
                    v-if="oUser.permisos.includes('reportes.tabla_posicions')"
                    prepend-icon="mdi-chevron-right"
                    title="Tabla de Posiciones"
                    :class="[
                        route_current == 'reportes.tabla_posicions'
                            ? 'active'
                            : '',
                    ]"
                    @click="cambiarUrl(route('reportes.tabla_posicions'))"
                    link
                >
                    <v-tooltip
                        v-if="rail && !mobile"
                        color="white"
                        activator="parent"
                        location="end"
                        >Tabla de Posiciones</v-tooltip
                    ></v-list-item
                >
            </v-list-group>
            <v-list-item class="text-caption"
                ><span v-if="rail && !mobile" class="text-center d-block"
                    ><v-icon>mdi-dots-horizontal</v-icon></span
                >
                <span v-else>OTROS</span></v-list-item
            >
            <v-list-item
                v-if="oUser.permisos.includes('institucions.index')"
                prepend-icon="mdi-cog-outline"
                :class="[route_current == 'institucions.index' ? 'active' : '']"
                @click="cambiarUrl(route('institucions.index'))"
                link
            >
                <v-list-item-title>Institución</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Institución</v-tooltip
                >
            </v-list-item>
            <v-list-item
                prepend-icon="mdi-account-circle"
                :class="[route_current == 'profile.edit' ? 'active' : '']"
                @click="cambiarUrl(route('profile.edit'))"
                link
            >
                <v-list-item-title>Perfil</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Perfil</v-tooltip
                >
            </v-list-item>
            <v-list-item
                prepend-icon="mdi-logout"
                @click="cambiarUrl(route('logout'), 'post')"
                link
            >
                <v-list-item-title>Salir</v-list-item-title>
                <v-tooltip
                    v-if="rail && !mobile"
                    color="white"
                    activator="parent"
                    location="end"
                    >Salir</v-tooltip
                >
            </v-list-item>
        </v-list>
    </v-navigation-drawer>
</template>
<style scoped></style>
