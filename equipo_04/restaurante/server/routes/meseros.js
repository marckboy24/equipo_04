//mesa.js: Archivo que gestiona todas las peticiones hacia la tabla "mesa"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_meseros', async(req, res) => {
      try{
          const query = 'SELECT * FROM mesero';
          const meseros = await connection.query(query);
          res.json(meseros);
      }
      catch(error){
          res.json({
              error:error
          });
      }
      return;
});


router.delete('/eliminar_mesero', async(req, res) => {
    try{
        const meser_id = req.body.meser_id; //Propiedad body contiene toda la información que se le pasa a la petición
        const query = 'DELETE FROM mesero WHERE meser_id = ?';
        const result = await connection.query(query, [meser_id]); //El signo de interrogación será reemplazado por todos los valores del arreglo [lib_id]
        res.json('Mesero eliminado');
    }
    catch(error){
        res.json({
          error:error
        });
    }
});

router.post('/nuevo_mesero', async(req, res) => {
      try{
          const body = req.body;
          const query = 'INSERT INTO mesero (meser_nombre, meser_ap_pat, meser_ap_mat) VALUES(?, ?, ?)';
          await connection.query(query, [body.meser_nombre, body.meser_ap_pat, body.meser_ap_mat]);
          res.json('Ok, inserción realizada con éxito');
      }
      catch(error){
          res.json({
              error:error
          });
      }
});

module.exports = router;
