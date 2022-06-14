//mesa.js: Archivo que gestiona todas las peticiones hacia la tabla "mesa"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_mesas', async(req, res) => {
      try{
          const query = 'SELECT * FROM mesa';
          const mesas = await connection.query(query);
          res.json(mesas);
      }
      catch(error){
          res.json({
              error:error
          });
      }
      return;
});

router.delete('/eliminar_mesa', async(req, res) => {
      try{
          const mesa_id = req.body.mesa_id;
          const query = 'DELETE FROM mesa WHERE mesa_id = ?';
          const result = await connection.query(query, [mesa_id]);
          res.json('Mesa eliminada');
      }
      catch(error){
          res.json({
              error:error
          });
      }
});

router.post('/nueva_mesa', async(req, res) => {
      try{
          const body = req.body;
          const query = 'INSERT INTO mesa (mesa_capacidad, mesa_estado) VALUES(?, ?)';
          await connection.query(query, [body.mesa_capacidad, body.mesa_estado]);
          res.json('Ok, inserción realizada con éxito');
      }
      catch(error){
          res.json({
              error:error
          });

      }
});

module.exports = router;
