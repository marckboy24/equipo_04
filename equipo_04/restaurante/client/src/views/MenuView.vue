<template>
    <v-container>
        <v-data-table
            :headers="headers_com"
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
            <template v-slot:item.com_actions="{item}">
                <v-icon @click="" small class="mr-3">
                  fas fa-pencil-alt
                </v-icon>
                <v-icon @click="" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>

        <v-data-table
            :headers="headers_beb"
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
            <template v-slot:item.beb_actions="{item}">
                <v-icon @click="" small class="mr-3">
                  fas fa-pencil-alt
                </v-icon>
                <v-icon @click="" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>

        <!--Cuadros de diálogo-->
        <v-dialog v-model="nc_dialog" max-width="500px">
            <v-card-title>Nueva comida</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-text-field label="Nombre" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field label="Categoría" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Porción" suffix ="grs" clearable>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field label="Precio" prefix="$" suffix="MXN" clearable>
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar_comida()">Cancelar</v-btn>
                </v-card-actions>
        </v-dialog>
        <v-dialog v-model="nb_dialog" max-width="500px">
            <v-card-title>Nueva bebida</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-text-field label="Nombre" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field label="Categoría" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Cantidad" suffix="ml" clearable>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field label="Precio" prefix="$" suffix="MXN" clearable>
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar_bebida()">Cancelar</v-btn>
                </v-card-actions>
        </v-dialog>
    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Menu',

    data(){
        return{
          headers_com: [
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
            { text: 'Acciones', value: 'com_actions', sortable:false}
          ],

          headers_beb: [
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
            { text: 'Acciones', value: 'beb_actions', sortable:false}
          ],

          comidas: [],

          bebidas: [],

          nc_dialog: false,
          nb_dialog: false,
          nueva_comida:{
              com_nombre:'',
              com_categoria:'',
              com_porcion:'',
              com_precio:''
          }
        }
    },
    created(){

    },
    methods:{
      async llenar_comidas(){
          const api_data = await this.axios.get('menu/comida/mostrar_comidas');
          this.comidas = api_data.data;
      },
      cancelar_comida(){
          this.nc_dialog = false;
      },
      cancelar_bebida(){
          this.nueva_comida = {}
          this.nb_dialog = false;
      }

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
