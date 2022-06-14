<template>
    <v-container>
        <v-data-table
            :headers="headers"
            :items="clientes"
            :items-per-page="5"
            class="elevation-1"
            >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Clientes</v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="secondary" @click="nc_dialog=true">Agregar cliente(s)</v-btn>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{item}">
                <v-icon @click="" small class="mr-3">
                  fas fa-pencil-alt
                </v-icon>
                <v-icon @click="" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>
        <v-dialog v-model="nc_dialog" max-width="500px">
            <v-card-title>Nuevo cliente(s)</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Nombre" clearable required>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field label="Cantidad de personas" clearable required>
                                </v-text-field>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Mesa asignada" required>
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>

                </v-card-actions>
        </v-dialog>
    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Clientes',

    data(){
        return{
          headers: [
            {
              text: 'ID Cliente(s)',
              align: 'start',
              sortable: false,
              value: 'cli_id',
            },
            { text: 'Nombre', value: 'cli_nombre' },
            { text: 'Cantidad de personas', value: 'cli_cantidad' },
            { text: 'Mesa del cliente(s)', value: 'cli_mesa_id' },
            { text: 'Acciones', value: 'actions', sortable:false}


          ],
          clientes: [{
            cli_id:1,
            cli_nombre:'Humberto',
            cli_cantidad: 4,
            cli_mesa_id: 4
          },
          {
            cli_id:2,
            cli_nombre:'Mónica',
            cli_cantidad: 4,
            cli_mesa_id: 4
          }],
          nc_dialog: false
        }
    },
    methods:{
      cancelar(){
          this.nc_dialog = false;
      }

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
