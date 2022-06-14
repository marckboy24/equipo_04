//ordenes.js:  Archivo para gestionar todas las peticiones a la tabla "orden"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostrar_ordenes', async(req, res) => {
      try{
          const query = 'SELECT * FROM orden';
          const ordenes = await connection.query(query);
          res.json(ordenes);
      }
      catch(error){
          res.json({
              error:error
          });
      }
});

module.exports = router;
