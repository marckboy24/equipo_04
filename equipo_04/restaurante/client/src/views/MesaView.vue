<template>
    <v-container>
        <v-data-table
            :headers="headers"
            :items="mesas"
            :items-per-page="5"
            class="elevation-1"
            >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Mesas disponibles</v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="secondary" @click="nm_dialog=true">Agregar mesa</v-btn>
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
        <v-dialog v-model="nm_dialog" max-width="500px">
            <v-card-title>Nueva mesa</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Capacidad" clearable required>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field label="Estado" clearable required>
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
    name: 'Mesa',

    data(){
        return{
          headers: [
            {
              text: 'ID Mesa',
              align: 'start',
              sortable: false,
              value: 'mesa_id',
            },
            { text: 'Capacidad', value: 'mesa_capacidad' },
            { text: 'Estado', value: 'mesa_estado' },
            { text: 'Acciones', value: 'actions', sortable:false}


          ],
          mesas: [{
            mesa_id: 1,
            mesa_capacidad: 4,
            mesa_estado: 'Disponible'
          },
          {
            mesa_id: 2,
            mesa_capacidad: 4,
            mesa_estado: 'Disponible'
          }],
          nm_dialog: false
        }
    },
    methods:{
        cancelar(){
            this.nm_dialog = false;
        }
    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
