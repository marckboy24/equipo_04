<template>
    <v-container>
        <v-data-table
            :headers="headers"
            :items="bebidas"
            :items-per-page="5"
            class="elevation-1"
            >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Bebidas</v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="secondary" @click="nb_dialog=true">Agregar bebida</v-btn>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{item}">
                <v-icon @click="" small class="mr-3">
                  fas fa-pencil-alt
                </v-icon>
                <v-icon @click="eliminar_bebida(item)" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>

        <!--Cuadros de diálogo-->
        <v-dialog v-model="nb_dialog" max-width="500px">
            <v-card-title>Nueva bebida</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-text-field l v-model="nueva_bebida.beb_nombre" label="Nombre" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field v-model="nueva_bebida.beb_categoria" label="Categoría" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field v-model="nueva_bebida.beb_cantidad" label="Cantidad" suffix="ml" clearable>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field v-model="nueva_bebida.beb_precio" label="Precio" prefix="$" suffix="MXN" clearable>
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_bebida()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar_bebida()">Cancelar</v-btn>
                </v-card-actions>
        </v-dialog>
    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Bebidas',

    data(){
        return{
          headers: [
            {
              text: 'ID Bebida',
              align: 'start',
              sortable: false,
              value: 'beb_id',
            },
            { text: 'Nombre', value: 'beb_nombre' },
            { text: 'Categoría', value: 'beb_categoria' },
            { text: 'Cantidad (ml)', value: 'beb_cantidad' },
            { text: 'Precio', value: 'beb_precio' },
            { text: 'Acciones', value: 'actions', sortable:false}
          ],

          bebidas: [],

          nb_dialog: false,
          nueva_bebida:{
              beb_nombre:'',
              beb_categoria:'',
              beb_cantidad:'',
              beb_precio:''
          }
        }
    },
    created(){
        this.llenar_bebidas();
    },
    methods:{
      async llenar_bebidas(){
          const api_data = await this.axios.get('bebidas/mostrar_bebidas');
          this.bebidas = api_data.data;
      },
      async eliminar_bebida(item){
          const body = {
              beb_id: item.beb_id
          }
          await this.axios.delete('bebidas/eliminar_bebida', {data:body});
          this.llenar_bebidas();
      },
      async guardar_bebida(){
          await this.axios.post('bebidas/nueva_bebida', this.nueva_bebida);
          this.llenar_bebidas();
          this.cancelar_bebida();
          console.log("FUNCIÓN GUARDAR BEBIDA");
          //console.log(await this.axios.post('bebidas/nueva_bebida', this.nueva_bebida));
      },

      cancelar_bebida(){
          this.nueva_bebida = {}
          this.nb_dialog = false;
      }

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
