<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >

      <div class="d-flex align-center">
        <v-img
          alt="PQ Logo"
          class="shrink"
          contain
          src="../public/burguer.png"
          transition="scale-transition"
          width="90"
        />
        <h2>PQ´s Dinner</h2>

      </div>

      <v-spacer></v-spacer>
    </v-app-bar>

    <v-main color="">
      <v-row class="my-5">
        <v-spacer></v-spacer>
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

<style>

</style>

<script>

export default {
  name: 'App',

  data: () => ({
    //
  }),
};
</script>
