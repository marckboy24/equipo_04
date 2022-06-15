<template>
    <v-container>
        <v-data-table dark
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
                <v-icon @click="eliminar_mesero(item)" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>
        <v-dialog v-model="nm_dialog" max-width="500px">
          <v-card>
            <v-card-title>Nuevo mesero</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-text-field v-model="nuevo_mesero.meser_nombre" label="Nombre" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field v-model="nuevo_mesero.meser_ap_pat" label="Apellido paterno" clearable required>
                            </v-text-field>
                        </v-row>
                        <v-row>
                            <v-text-field v-model="nuevo_mesero.meser_ap_mat" label="Apellido materno" clearable>
                            </v-text-field>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_mesero()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>

                </v-card-actions>
            </v-card>
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
          meseros: [],
          nm_dialog: false,
          nuevo_mesero:{
              meser_nombre:'',
              meser_ap_pat:'',
              meser_ap_mat:''
          }
        }
    },
    created(){
        this.llenar_meseros();
    },

    methods:{
      async llenar_meseros(){
          const api_data = await this.axios.get('meseros/mostrar_meseros');
          this.meseros = api_data.data;
      },

      async eliminar_mesero(item){
          console.log("FUNCIÓN ELIMINAR MESERO");
          const body = {
              meser_id: item.meser_id
          }
          await this.axios.delete('meseros/eliminar_mesero', {data:body});
          this.llenar_meseros();
      },

      async guardar_mesero(){
          await this.axios.post('meseros/nuevo_mesero', this.nuevo_mesero);
          this.llenar_meseros();
          this.cancelar();
          console.log("FUNCION GUARDAR MESEROS");
      },

      cancelar(){
          this.nuevo_mesero = {}
          this.nm_dialog = false;
      }

    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
