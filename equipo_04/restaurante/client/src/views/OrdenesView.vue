<template>
    <v-container>
        <v-data-table dark
            :headers="headers"
            :items="ordenes"
            :items-per-page="5"
            class="elevation-1"
            >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Órdenes</v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="secondary" @click="no_dialog=true">Agregar orden</v-btn>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{item}">
              <v-icon @click="nd_dialog = true" small class="mr-3">
                  fas fa-plus
              </v-icon>
                <v-icon @click="" small class="mr-3">
                    fas fa-eye
                </v-icon>
                <v-icon @click="" small class="mr-3">
                    fas fa-pencil-alt
                </v-icon>
                <v-icon @click="eliminar_orden(item)" small>
                    fas fa-trash
                </v-icon>
            </template>
            <template v-slot:item.bill="{item}">
                <v-icon @click="" small>
                    fa-solid fa-scroll
                </v-icon>
            </template>
        </v-data-table>
        <v-dialog v-model="no_dialog" max-width="500px">
          <v-card>
            <v-card-title>Nueva orden</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="'6'">
                                <v-select
                                        :items="mesas"
                                        v-model="nueva_orden.ord_mesa_id"
                                        label="Mesa asignada" required>
                                </v-select>
                            </v-col>
                            <v-col cols="'6'">
                                <v-select
                                        :items="meseros"
                                        v-model="nueva_orden.ord_meser_encargado"
                                        label="Mesero encargado" required
                                >
                                </v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-select
                                        :items="clientes"
                                        v-model="nueva_orden.ord_cli_info"
                                        label="Cliente" required
                                >
                                </v-select>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field v-model="nueva_orden.ord_estado" label="Estado de la orden" clearable required hint="Abierta, Cerrada, Pagada, Cancelada">
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_orden()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-dialog v-model="nd_dialog" max-width="500px">
            <v-card>
                <v-card-title>
                    Detalles de la orden
                    <v-spacer></v-spacer>
                    <v-col cols="6">
                        <v-menu v-model="menu_fecha"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                min-width="290px">
                                <template v-slot:activator="{on, attrs}">
                                    <v-text-field v-model="det_orden.det_fecha"
                                                  label="Fecha de expedición"
                                                  prepend-icon="fas fa-calendar"
                                                  readonly
                                                  v-bind="attrs"
                                                  v-on="on">
                                </v-text-field>
                              </template>
                              <v-date-picker v-model="det_orden.det_fecha"
                                          @input="menu_fecha= false">
                              </v-date-picker>
                          </v-menu>
                      </v-col>
                </v-card-title>

                <v-card-text>
                <v-spacer></v-spacer>
                <v-btn color="success" @click="agregar_renglon()" class="mr-5">Agregar pedido</v-btn>
                    <v-container>
                        <v-row v-for="(comida, index) in det_orden" v-bin:key="index">
                            <v-col cols="12">
                                <v-select
                                        :items="comidas"
                                        label="Seleccionar comida"
                                        v-model="comida.det_com_id"
                                >
                                </v-select>
                            </v-col>
                        </v-row>
                        <v-row v-for="(bebida, index) in det_orden" v-bin:key="index">
                            <v-col cols="12">
                                <v-select
                                        :items="bebidas"
                                        label="Seleccionar bebida"
                                        v-model="bebida.det_beb_id"
                                >
                                </v-select>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_detalles()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script>
export default { //Definir propiedades del archivo
    name: 'Ordenes',

    data(){
        return{
          headers: [
            {
              text: 'ID Orden',
              align: 'start',
              sortable: false,
              value: 'ord_id',
            },
            { text: 'Mesa asignada', value: 'ord_mesa_id' },
            { text: 'Mesero encargado', value: 'ord_meser_encargado' },
            { text: 'Cliente', value: 'ord_cli_info' },
            { text: 'Estado de la orden', value: 'ord_estado', sortable:false},
            { text: 'Acciones', value: 'actions', sortable:false},
            { text: 'Imprimir cuenta', value: 'bill', sortable:false}


          ],
          ordenes: [],
          mesas: [],
          meseros: [],
          clientes: [],

          comidas:[],
          bebidas:[],
          det_orden:[],
          det_ord_id: '',

          no_dialog: false,
          nd_dialog: false,
          menu_fecha: false,

          nueva_orden:{
              ord_mesa_id:'',
              ord_meser_id:'',
              ord_cli_id:'',
              ord_estado:''
          }
        }
    },
    created(){
        this.llenar_ordenes();
        this.llenar_mesas();
        this.llenar_meseros();
        this.llenar_clientes();

        this.llenar_comidas();
        this.llenar_bebidas();

    },
    methods:{
        async llenar_mesas(){
            const api_data = await this.axios.get('mesa/mostrar_mesas');
            api_data.data.forEach((item) => {
                this.mesas.push({
                    text: 'Mesa ' + item.mesa_id + ' (Capacidad: ' + item.mesa_capacidad + ' )',
                    value: item.mesa_id
                });
            });
        },
        async llenar_meseros(){
            const api_data = await this.axios.get('meseros/mostrar_meseros');
            api_data.data.forEach((item) => {
                this.meseros.push({
                    text: item.meser_id + ' - ' + item.meser_nombre + ' ' + item.meser_ap_pat,
                    value: item.meser_id
                });
            });
        },
        async llenar_clientes(){
            const api_data = await this.axios.get('clientes/mostrar_clientes');
            api_data.data.forEach((item) => {
                this.clientes.push({
                    text: item.cli_id + ' - ' + item.cli_nombre,
                    value: item.cli_id
                });
            });
        },

        async llenar_comidas(){
            const api_data = await this.axios.get('comidas/mostrar_comidas');
            api_data.data.forEach((item) => {
                this.comidas.push({
                    text: item.com_nombre + ' - $' + item.com_precio,
                    value: item.com_id
                });
            });
        },
        async llenar_bebidas(){
          const api_data = await this.axios.get('bebidas/mostrar_bebidas');
          api_data.data.forEach((item) => {
              this.bebidas.push({
                  text: item.beb_nombre + ' - $' + item.beb_precio,
                  value: item.beb_id
              });
          });
        },

        agregar_detalles(item){
            this.det_ord_id = item.ord_id;
            nd_dialog = true;
        },

        agregar_renglon(){
            this.det_orden.push({
                det_com_id: '',
                det_beb_id: ''
            });
        },

        async guardar_detalles(){
            const body = {
                det_ord_id: this.det_ord_id,
                det_com_id: '',
                det_beb_id: '',
                det_fecha: ''
            }
            this.det_orden.forEach(async (obj) => {
                body.det_com_id = obj.det_com_id;
                body.det_beb_id = obj.det_beb_id;
                body.det_fecha = obj.det_fecha;
                await this.axios.post('ordenes/nuevo_detalles', body);
            });
            this.cancelar();
        },

        async llenar_ordenes(){
            const api_data = await this.axios.get('ordenes/mostrar_ordenes');
            this.ordenes = api_data.data;
        },
        async eliminar_orden(item){
            const body = {
                ord_id: item.ord_id
            }
            await this.axios.delete('ordenes/eliminar_orden', {data:body});
            this.llenar_ordenes();
        },
        async guardar_orden(){
            console.log(this.nueva_orden.ord_mesa_id);
            await this.axios.post('ordenes/nueva_orden', this.nueva_orden);
            this.llenar_ordenes();
            this.cancelar();
            console.log("FUNCIÓN GUARDAR ORDEN");
            console.log(this.nueva_orden.data);
            console.log(await this.axios.post('ordenes/nueva_orden', this.nueva_orden));
        },
        cancelar(){
            this.nueva_orden = {};
            this.det_orden = [];
            this.no_dialog = false;
            this.nd_dialog = false;
        }
    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
