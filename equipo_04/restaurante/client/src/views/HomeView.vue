<template>
    <v-container>
      Acciones rápidas
          <v-data-table
              :headers="headers"
              :items="desserts"
              :items-per-page="5"
              class="elevation-1"
              >
          </v-data-table>

    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Home',

    data(){
        return{

        }
    },
    methods:{

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
