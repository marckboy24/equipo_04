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

module.exports = router;
