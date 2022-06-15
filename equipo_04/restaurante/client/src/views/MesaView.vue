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
                <v-icon @click="eliminar_mesa(item)" small>
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
                                <v-text-field v-model="nueva_mesa.mesa_capacidad" type="number" min="1" label="Capacidad" clearable required>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field v-model="nueva_mesa.mesa_estado" label="Estado" clearable required hint="Disponible, Ocupado">
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_mesa()">Guardar</v-btn>
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
          mesas: [],
          nm_dialog: false,
          nueva_mesa:{
              mesa_capacidad:'',
              mesa_estado:''
          }
        }
    },
    created(){
        this.llenar_mesas();
    },
    methods:{
        async llenar_mesas(){
            const api_data = await this.axios.get('mesa/mostrar_mesas');
            this.mesas = api_data.data;
        },
        async eliminar_mesa(item){
            const body = {
                mesa_id: item.mesa_id
            }
            await this.axios.delete('mesa/eliminar_mesa', {data:body});
            this.llenar_mesas();
        },
        async guardar_mesa(){

            await this.axios.post('mesa/nueva_mesa', this.nueva_mesa);
            this.llenar_mesas();
            this.cancelar();
            console.log("FUNCION GUARDAR MESA");
        },
        cancelar(){
            this.nueva_mesa = {}
            this.nm_dialog = false;
        }
    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
