//clientes.js: Archivo que gestiona todas las peticiones hacia la tabla "clientes"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_clientes', async(req, res) =>{
      try{
          const query = 'SELECT * FROM clientes';
          const clientes = await connection.query(query);
          res.json(clientes);
          console.log(clientes);
      }
      catch(error){
          res.json({
              error:error
          });
      }
      return;
});

module.exports = router;
