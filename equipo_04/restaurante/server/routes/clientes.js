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

router.delete('/eliminar_cliente', async(req, res) => {
      try{
          const cli_id = req.body.cli_id;
          const query = 'DELETE FROM clientes WHERE cli_id = ?';
          const result = await connection.query(query, [cli_id]);
          res.json('Cliente eliminado');
      }
      catch(error){
          res.json({
              error:error
          });
      }
});

router.post('/nuevo_cliente', async(req, res) => {
      try{
          const body = req.body;
          const query = 'INSERT INTO clientes (cli_nombre, cli_cantidad, cli_mesa_id) VALUES(?, ?, ?)';
          await connection.query(query, [body.cli_nombre, body.cli_cantidad, body.cli_mesa_id]);
          res.json('Ok, inserción realizada con éxito');
      }
      catch(error){
          res.json({
              error:error
          });

      }
});

module.exports = router;
