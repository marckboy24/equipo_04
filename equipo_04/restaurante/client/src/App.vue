<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        <v-img
          alt="Vuetify Logo"
          class="shrink mr-2"
          contain
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
          transition="scale-transition"
          width="40"
        />

        <v-img
          alt="Vuetify Name"
          class="shrink mt-1 hidden-sm-and-down"
          contain
          min-width="100"
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-name-dark.png"
          width="100"
        />
      </div>

      <v-spacer></v-spacer>
    </v-app-bar>

    <v-main>
      <v-row class="my-5">
        <v-spacer></v-spacer>
        <router-link :to="{ name: 'home'}" class="mr-5">Inicio</router-link>
        <router-link :to="{ name: 'clientes'}" class="mr-5">Clientes</router-link>
        <router-link :to="{ name: 'ordenes'}" class="mr-5">Ordenes</router-link>
        <router-link :to="{ name: 'comidas'}" class="mr-5">Comidas</router-link>
        <router-link :to="{ name: 'bebidas'}" class="mr-5">Bebidas</router-link>
        <router-link :to="{ name: 'mesa'}" class="mr-5">Mesas</router-link>
        <router-link :to="{ name: 'meseros'}" class="mr-5">Meseros</router-link>

        <v-spacer></v-spacer>
      </v-row>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data: () => ({
    //
  }),
};
</script>
