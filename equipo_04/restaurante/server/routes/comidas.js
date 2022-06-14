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

module.exports = router;
