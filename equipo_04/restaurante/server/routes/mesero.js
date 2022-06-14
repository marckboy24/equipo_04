//mesa.js: Archivo que gestiona todas las peticiones hacia la tabla "mesa"
const express = require('express');
const router = express.Router();
const connection = require('../connection');

router.get('/mostar_meseros', async(req, res) => {
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

module.exports = router;
