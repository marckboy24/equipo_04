<template>
    <v-container>
        <v-data-table
            :headers="headers"
            :items="meseros"
            :items-per-page="5"
            class="elevation-1"
            >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Meseros</v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="secondary" @click="nm_dialog=true">Agregar mesero</v-btn>
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
            <v-card-title>Nuevo mesero</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-text-field label="Nombre" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field label="Apellido paterno" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field label="Apellido materno" clearable>
                            </v-text-field>
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
    name: 'Meseros',

    data(){
        return{
          headers: [
            {
              text: 'ID Mesero',
              align: 'start',
              sortable: false,
              value: 'meser_id',
            },
            { text: 'Nombre', value: 'meser_nombre' },
            { text: 'Apellido paterno', value: 'meser_ap_pat' },
            { text: 'Apellido materno', value: 'meser_ap_mat' },
            { text: 'Acciones', value: 'actions', sortable:false}


          ],
          meseros: [{
            meser_id:1,
            meser_nombre:'Juana',
            meser_ap_pat: 'Montoya',
            meser_ap_mat: 'Lopéz'
          },
          {
            meser_id:2,
            meser_nombre:'Jair',
            meser_ap_pat: 'Chavéz',
            meser_ap_mat: 'Islas'
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
