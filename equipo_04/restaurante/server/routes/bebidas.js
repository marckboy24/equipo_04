//bebidas.js: Archivo que gestiona todas las peticiones hacia la tabla "comida"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_bebidas', async(req, res) => {
      try{
          const query = 'SELECT * FROM bebida';
          const bebidas = await connection.query(query);
          res.json(bebidas);
      }
      catch(error){
          res.json({
              error:error
          });
      }
      return;
});

router.delete('/eliminar_bebida', async(req, res) => {
      try{
          const beb_id = req.body.beb_id;
          const query = 'DELETE FROM bebida WHERE beb_id = ?';
          const result = await connection.query(query, [beb_id]);
          res.json('Bebida eliminada');
      }
      catch(error){
          res.json({
              error:error
          });
      }
});

module.exports = router;
