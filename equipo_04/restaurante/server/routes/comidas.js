//comidas.js: Archivo que gestiona todas las peticiones hacia la tabla "comida"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_comidas', async(req, res) => {
      try{
          const query = 'SELECT * FROM comida';
          const comidas = await connection.query(query);
          res.json(comidas);
      }
      catch(error){
          res.json({
              error:error
          });
      }
});

router.delete('/eliminar_comida', async(req, res) => {
    try{
        const com_id = req.body.com_id; //Propiedad body contiene toda la información que se le pasa a la petición
        const query = 'DELETE FROM comida WHERE com_id = ?';
        const result = await connection.query(query, [com_id]); //El signo de interrogación será reemplazado por todos los valores del arreglo [lib_id]
        res.json('Comida eliminada');
    }
    catch(error){
        res.json({
          error:error
        });
    }
});

router.post('/nueva_comida', async(req, res) => {
      try{
          const body = req.body;
          const query = 'INSERT INTO comida (com_nombre, com_categoria, com_porcion, com_precio) VALUES(?, ?, ?, ?)';
          await connection.query(query, [body.com_nombre, body.com_categoria, body.com_porcion, body.com_precio]);
          res.json('Ok, inserción realizada con éxito');
      }
      catch(error){
          res.json({
              error:error
          });
      }
});


module.exports = router;
