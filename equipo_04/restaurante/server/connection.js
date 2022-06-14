//connection.js: Archivo que establece la conexión con la base de datos
const mysql = require('mysql');
const {promisify} = require('util');

const connection = mysql.createPool({
    host: 'localhost',
    user: 'empleado',
    password: 'empleado123',
    database: 'restaurante_db'
});

//Método para establecer la conexión
connection.getConnection(
      (err, conn) => {
          if(err){
              console.log('NO se pudo conectar con la DB del restaurante');
          }
          if(conn){
              console.log('DB del restaurante CONECTADA');
          }
          return;
      }
);

connection.query = promisify(connection.query);
module.exports = connection;
