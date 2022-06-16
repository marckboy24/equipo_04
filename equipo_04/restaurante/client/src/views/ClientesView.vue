<template>
    <v-container>
        <v-data-table
            :headers="headers"
            :items="clientes"
            :items-per-page="5"
            class="elevation-19"
            >
            <template  v-slot:top>
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
                <v-icon @click="eliminar_cliente(item)" small>
                    fas fa-trash
                </v-icon>
            </template>
        </v-data-table>
        <v-dialog v-model="nc_dialog" max-width="500px">
          <v-card>
            <v-card-title>Nuevo cliente(s)</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field v-model="nuevo_cliente.cli_nombre" label="Nombre" clearable required>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field v-model="nuevo_cliente.cli_cantidad" type="number" label="Cantidad de personas" clearable required>
                                </v-text-field>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-select
                                        :items="mesas"
                                        v-model = "nuevo_cliente.cli_mesa_id"
                                        label = "Mesa asignada" required
                                >
                                </v-select>

                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_cliente()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>

                </v-card-actions>
          </v-card>
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
              class:'colscolor'
            },
            { text: 'Nombre', value: 'cli_nombre', class:'colscolor'},
            { text: 'Cantidad de personas', value: 'cli_cantidad', class:'colscolor'},
            { text: 'Mesa del cliente(s)', value: 'cli_mesa_id', class:'colscolor'},
            { text: 'Acciones', value: 'actions', sortable:false, class:'colscolor'}
          ],
          clientes: [],
          mesas: [],
          nc_dialog: false,
          nuevo_cliente:{
              cli_nombre:'',
              cli_cantidad:'',
              cli_mesa_id:''
          }
        }
    },
    
    created(){
        this.llenar_mesas();
        this.llenar_clientes();
    },

    methods:{
      async llenar_mesas(){
          const api_data = await this.axios.get('mesa/mostrar_mesas');
          api_data.data.forEach((item) => {
              this.mesas.push({
                  text: 'Mesa ' + item.mesa_id + ': '+ item.mesa_estado + ' (Capacidad: ' + item.mesa_capacidad + ' )',
                  value: item.mesa_id
              });
          });
      },

      async llenar_clientes(){
          const api_data = await this.axios.get('clientes/mostrar_clientes');
          this.clientes = api_data.data;
      },
      async guardar_cliente(){
          console.log("FUNCIÓN GUARDAR");
          await this.axios.post('clientes/nuevo_cliente', this.nuevo_cliente);
          this.llenar_clientes();
          this.cancelar();
      },
      async eliminar_cliente(item){
          const body = {
              cli_id: item.cli_id
          }
          await this.axios.delete('clientes/eliminar_cliente', {data:body});
          this.llenar_clientes();
      },
      cancelar(){
          this.nuevo_cliente = {}
          this.nc_dialog = false;
      }
    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
