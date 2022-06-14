//app.js: Script para crear y gestionar el servidor
const express = require('express');
const app = express();
const morgan = require('morgan');
const cors = require('cors');
const path = require('path');
const history = require('connect-history-api-fallback');

//Funciones middleware
app.use(cors());
app.use(morgan('tiny'));
app.use(history());
app.use(express.json());

//Conecta con el public/index.html
app.use(express.urlencoded({extended:true}));
app.use(express.static(path.join(__dirname, 'public')));

//Rutas de la página
app.use('/mesa', require('./routes/mesa'));
app.use('/clientes', require('./routes/clientes'));
app.use('/comidas', require('./routes/comidas'))
app.use('/ordenes', require('./routes/ordenes'));
app.use('/meseros', require('./routes/meseros'));

//Método para ejecutar el servidor
app.listen(3000, function(){
    console.log("API del restaurante ejecutandose");
});

/*
Programa de prueba

app.get("/", inicio);
app.get("/hola", hola);

function inicio(req, res){
    res.send("Ventana inicio, prueba para server de restaurante");
}

function hola(req, res){
    res.send("Segunda ventana para restaurante");
}
*/
