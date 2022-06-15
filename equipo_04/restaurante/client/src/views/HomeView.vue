<template>
    <v-container class="my-5">
            <v-spacer></v-spacer>
            <h1>Bienvenido</h1>
            <v-spacer></v-spacer>
            <h3>Base de Datos del restaurante <i>PQ's Dinner</i></h3>
            <br/>
            <h5>Por favor, escoge una acción de la barra de tareas para empezar a trabajar</h5>
          </v-data-table>

    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Home',

    data(){
        return{
          headers: [],
          query_one: []
        }
    },
    methods:{

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
