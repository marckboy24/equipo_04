<template>
    <v-container>
        <v-data-table dark
            :headers="headers"
            :items="comidas"
            :items-per-page="5"
            class="elevation-1"
            >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Comidas</v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="secondary" @click="nc_dialog=true">Agregar comida</v-btn>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{item}">
                <v-icon @click="" small class="mr-3">
                  fas fa-pencil-alt
                </v-icon>
                <v-icon @click="eliminar_comida(item)" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>


        <!--Cuadros de diálogo-->
        <v-dialog v-model="nc_dialog" max-width="500px">
          <v-card>
            <v-card-title>Nueva comida</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-text-field v-model="nueva_comida.com_nombre" label="Nombre" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field v-model="nueva_comida.com_categoria" label="Categoría" clearable required hint="Sopas, Ensaladas, Carnes rojas, Otras carnes, Postres">
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field v-model="nueva_comida.com_porcion" type="number" label="Porción" suffix ="grs" clearable>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field v-model="nueva_comida.com_precio" type="number" label="Precio" prefix="$" suffix="MXN" clearable>
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_comida()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar_comida()">Cancelar</v-btn>
                </v-card-actions>
          </v-card>
        </v-dialog>
    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Comidas',

    data(){
        return{
          headers: [
            {
              text: 'ID Comida',
              align: 'start',
              sortable: false,
              value: 'com_id',
            },
            { text: 'Nombre', value: 'com_nombre' },
            { text: 'Categoría', value: 'com_categoria' },
            { text: 'Porción (grs)', value: 'com_porcion' },
            { text: 'Precio', value: 'com_precio' },
            { text: 'Acciones', value: 'actions', sortable:false}
          ],

          comidas: [],

          nc_dialog: false,
          nueva_comida:{
              com_nombre:'',
              com_categoria:'',
              com_porcion:'',
              com_precio:''
          }
        }
    },
    created(){
        this.llenar_comidas();
    },
    methods:{
      async llenar_comidas(){
          const api_data = await this.axios.get('comidas/mostrar_comidas');
          this.comidas = api_data.data;
      },
      async eliminar_comida(item){
          console.log('FUNCION ELIMINAR COMIDA');
          const body = {
              com_id: item.com_id
          }
          await this.axios.delete('comidas/eliminar_comida', {data:body});
          this.llenar_comidas();
      },
      async guardar_comida(){
          await this.axios.post('comidas/nueva_comida', this.nueva_comida);
          this.llenar_comidas();
          this.cancelar_comida();
          console.log("FUNCION GUARDAR COMIDA");
      },
      cancelar_comida(){
          this.nueva_comida = {}
          this.nc_dialog = false;
      }

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
