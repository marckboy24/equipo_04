//ordenes.js:  Archivo para gestionar todas las peticiones a la tabla "orden"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_ordenes', async(req, res) => {
      try{
          //const query = 'SELECT * FROM orden';
          const query = 'SELECT ' +
                        'o.ord_id, o.ord_mesa_id, ' +
                        'CONCAT_WS(" ", m.meser_id, "-", m.meser_nombre) AS ord_meser_encargado, ' +
                        'CONCAT_WS(" ", c.cli_id, "-", c.cli_nombre) AS ord_cli_info, ' +
                        'o.ord_estado ' +
                        'FROM orden AS o, mesero AS m, clientes AS c ' +
                        'WHERE o.ord_meser_id = m.meser_id ' +
                        'AND o.ord_cli_id = c.cli_id';

          const ordenes = await connection.query(query);
          res.json(ordenes);
      }
      catch(error){
          res.json({
              error:error
          });
      }
      return;
});

router.delete('/eliminar_orden', async(req, res) => {
    try{
        const ord_id = req.body.ord_id;
        const query = 'DELETE FROM orden WHERE ord_id = ?';
        const result = await connection.query(query, [ord_id]);
        res.json('Orden eliminada');
    }
    catch{
        res.json({
            error:error
        });
    }
});

router.post('/nueva_orden', async(req, res) => {
      try{
          const body = req.body;
          const query = 'INSERT INTO orden (ord_mesa_id, ord_meser_id, ord_cli_id, ord_estado) VALUES(?, ?, ?, ?)';
          await connection.query(query, [body.ord_mesa_id, body.ord_meser_id, body.ord_cli_id, body.ord_estado]);
          res.json('Ok, inserción realizada con éxito');
      }
      catch(error){
          res.json({
              error:error
          });

      }
});

module.exports = router;
