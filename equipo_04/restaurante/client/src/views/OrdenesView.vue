<template>
    <v-container>
        <v-data-table
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
                <v-icon @click="" small class="mr-3">
                    fas fa-eye
                </v-icon>
                <v-icon @click="" small class="mr-3">
                    fas fa-pencil-alt
                </v-icon>
                <v-icon @click="" small>
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
            <v-card-title>Nueva orden</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Mesa asignada" clearable required>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field label="Mesero encargado" clearable required>
                                </v-text-field>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="'6'">
                                <v-text-field label="Cliente" clearable required>
                                </v-text-field>
                            </v-col>
                            <v-col cols="'6'">
                                <v-text-field label="Estado de la orden" clearable required>
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
            { text: 'Mesero encargado', value: 'ord_meser_id' },
            { text: 'Cliente', value: 'ord_cli_id' },
            { text: 'Estado de la orden', value: 'ord_estado', sortable:false},
            { text: 'Acciones', value: 'actions', sortable:false},
            { text: 'Imprimir cuenta', value: 'bill', sortable:false}


          ],
          ordenes: [{
            ord_id: 1,
            ord_mesa_id: 4,
            ord_meser_id: 2,
            ord_cli_id: 1,
            ord_estado: 'Abierta'
          },
          {
            ord_id: 2,
            ord_mesa_id: 5,
            ord_meser_id: 3,
            ord_cli_id: 2,
            ord_estado: 'Abierta'
          }],
          no_dialog: false
        }
    },
    methods:{
        cancelar(){
            this.no_dialog = false;
        }
    }
  //components: { //Importar archivos desde otro directorio
  //  HelloWorld,
  //},
}
</script>
