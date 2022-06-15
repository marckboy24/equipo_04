DROP DATABASE IF EXISTS restaurante_db;
CREATE DATABASE IF NOT EXISTS restaurante_db;

USE restaurante_db;

# Creación de la tabla independiente "mesa"
CREATE TABLE IF NOT EXISTS mesa(
	mesa_id INT NOT NULL AUTO_INCREMENT,
    mesa_capacidad INT NOT NULL,
    mesa_estado ENUM('Disponible', 'Ocupado'),
    UNIQUE(mesa_id, mesa_capacidad),
    PRIMARY KEY(mesa_id) 	#Decidimos utilizar una llave primaria artificial porque es numerico el id siendo facil de 
                            #interpretar y a su vez, el número de mesa es único
);

# Creación de tabla independiente "mesero"
CREATE TABLE IF NOT EXISTS mesero(
	meser_id INT NOT NULL AUTO_INCREMENT,
    meser_nombre VARCHAR(50) NOT NULL,
    meser_ap_pat VARCHAR(50) NOT NULL,
    meser_ap_mat VARCHAR(50),
    INDEX(meser_nombre),
    PRIMARY KEY(meser_id) #Se decidió utilizar una llave primaria artificial porque es un atributo más sencillo de 
							#identificar y asi es difícil confundirse si un mesero tuviera el mismo nombre y apellido
);

# Creación de la tabla independiente "comida"
CREATE TABLE IF NOT EXISTS comida(
	com_id INT NOT NULL AUTO_INCREMENT,
    com_nombre VARCHAR(75) NOT NULL,
    com_categoria ENUM('Sopas', 'Ensaladas', 'Carnes rojas', 'Otras carnes', 'Postres') NOT NULL,
    com_porcion INT COMMENT 'Porción medida en gramos',
    com_precio DECIMAL(7, 2) NOT NULL,
    INDEX(com_nombre),
    PRIMARY KEY(com_id) #Utilizamos una llave primaria artificial ya que es fácil de identificar por el id propio del sistema(restaurante)
						#y así, que no exista confusión si una comida tiene nombre similar 
);

 #Creación de la tabla independiente "bebida"
 CREATE TABLE IF NOT EXISTS bebida(
	beb_id INT NOT NULL AUTO_INCREMENT,
    beb_nombre VARCHAR(75) NOT NULL,
    beb_categoria ENUM('Aguas', 'Jugos', 'Refrescos', 'Cervezas', 'Coctelería') NOT NULL,
    beb_cantidad INT NOT NULL COMMENT 'Cantidad medida en mililitros',
    beb_precio DECIMAL(7, 2) NOT NULL,
    INDEX(beb_nombre),
    PRIMARY KEY(beb_id) 	#Utilizamos una llave primaria artificial, ya que puede darse el caso que existan bebidas
							#con nombres similares, por lo que, un identificador único facilitaría la ubicación de los registros
 );

#Creación de la tabla ADICIONAL dependiente "clientes"
CREATE TABLE IF NOT EXISTS clientes(
	cli_id INT NOT NULL AUTO_INCREMENT,
    cli_nombre VARCHAR(50) NOT NULL COMMENT 'A que nombre se encuentra la mesa',
    cli_cantidad TINYINT NOT NULL,
    cli_mesa_id INT NOT NULL,
    PRIMARY KEY(cli_id),			#Se optó por usar una llave primaria artificial, ya que los clientes pueden compartir cosas en común,
    CONSTRAINT fk_mesa_clientes		#mientras que si se ubican por un identificador único se evitan confusiones
		FOREIGN KEY(cli_mesa_id)
        REFERENCES mesa(mesa_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

# Creación de la tabla "orden"
CREATE TABLE IF NOT EXISTS orden(
	ord_id INT NOT NULL AUTO_INCREMENT,
    ord_mesa_id INT NOT NULL,
    ord_meser_id INT NOT NULL,
    ord_cli_id INT NOT NULL,
    ord_estado ENUM('Abierta', 'Cerrada', 'Pagada', 'Cancelada') NOT NULL,
    UNIQUE(ord_id, ord_mesa_id, ord_meser_id, ord_cli_id),
    PRIMARY KEY(ord_id),			#Utilizamos una llave artificial porque cada orden es única, además de que hacerlo por los
    CONSTRAINT fk_mesa_orden		#atributos de la orden no es la mejor manera de identificar los registros para una llave primaria
		FOREIGN KEY(ord_mesa_id)
        REFERENCES mesa(mesa_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	CONSTRAINT fk_mesero_orden
		FOREIGN KEY(ord_meser_id)
        REFERENCES mesero(meser_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	CONSTRAINT fk_clientes_orden
		FOREIGN KEY(ord_cli_id)
        REFERENCES clientes(cli_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    
);

#Creación de la tabla ADICIONAL de características "detalles" de la orden
CREATE TABLE IF NOT EXISTS detalles(
	det_ord_id INT NOT NULL,
    det_com_id INT NOT NULL,
    det_beb_id INT NOT NULL,
	det_fecha DATE NOT NULL,
    PRIMARY KEY(det_ord_id, det_com_id, det_beb_id),		#Elegimos una combinación de 3 llaves primarias artificiales
    CONSTRAINT fk_orden_detalles							#porque así se puede identificar de forma única el detalle de la orden 
		FOREIGN KEY(det_ord_id)								#dependiendo de las especificaciones ingresadas por el usuario
        REFERENCES orden(ord_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
	CONSTRAINT fk_comida_detalles
		FOREIGN KEY(det_com_id)
        REFERENCES comida(com_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
	CONSTRAINT fk_bebida_detalles
		FOREIGN KEY(det_beb_id)
        REFERENCES bebida(beb_id)
		ON UPDATE RESTRICT
        ON DELETE RESTRICT
		
);
 
#Creación de la tabla ADICIONAL dependiente "cuenta"
CREATE TABLE IF NOT EXISTS cuenta(
    cuen_ord_id INT NOT NULL,
    cuen_fecha DATE NOT NULL,
    cuen_hora TIME NOT NULL,
    cuen_total DECIMAL(7, 2) NOT NULL,
    PRIMARY KEY(cuen_ord_id),					#Se eligió una llave primaria del tipo artificial porque cada orden genera solo una 
    CONSTRAINT fk_orden_cuenta					#cuenta única, y por ende, no se puede repetir
		FOREIGN KEY(cuen_ord_id)
        REFERENCES orden(ord_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

#INSERTS
#a) Tabla mesa
INSERT INTO mesa(mesa_capacidad, mesa_estado)
	VALUE('8', 'Ocupado'),
		 ('6', 'Ocupado'),
		 ('10', 'Ocupado'),
		 ('12', 'Ocupado'),
		 ('4', 'Ocupado');

#b)Tabla mesero
INSERT INTO mesero(meser_nombre, meser_ap_pat, meser_ap_mat)
	VALUES ('Juan Carlos', 'Bodoque', 'Galindo'),
		   ('Jair', 'Chávez', 'Islas');

#c) Tabla comida
INSERT INTO comida(com_nombre, com_categoria, com_precio)
	VALUES ('Bistek asado', 'Carnes rojas', '45'),
		   ('Pastel', 'Postres', '60'),
		   ('Espaguetti', 'Sopas', '35'),
		   ('Pollo agridulce', 'Otras carnes', '23'),
		   ('Tiramisu', 'Postres', '80');

#d)Tabla bebida
INSERT INTO bebida(beb_nombre, beb_categoria, beb_cantidad, beb_precio)
	VALUES ('Coca-Cola', 'Refrescos', '600', '45'),
		   ('Jugo de mango', 'Jugos', '600', '60'),
		   ('Modelo', 'Cervezas', '350', '35'),
		   ('Martini', 'Coctelería', '250','23'),
		   ('Agua de horchata', 'Aguas', '1000', '80');
           
#e)Tabla clientes           
INSERT INTO clientes(cli_nombre, cli_cantidad, cli_mesa_id)
	VALUE('Héctor', '4', '5'),
		 ('Sofía', '12', '4'),
		 ('Carlos', '6', '2'),
		 ('Aldo', '8', '1'),
		 ('Emiliano', '10', '3');
         
 #f)Tabla orden        
INSERT INTO orden(ord_mesa_id, ord_meser_id, ord_cli_id, ord_estado)
	VALUES ('1', '1', '4', 'Cerrada'),
		   ('2', '1' ,'3', 'Cerrada'),
		   ('3', '2', '5', 'Cerrada'),
		   ('4', '2', '2', 'Cerrada'),
		   ('5', '1', '1', 'Cerrada');

#g)Tabla detalles (de la orden)
INSERT INTO detalles(det_ord_id, det_com_id, det_beb_id, det_fecha)
	VALUES ('1', '1', '5', '2022-03-15'),
		   ('1', '2', '4', '2022-03-15'),
		   ('2', '2' ,'4', '2022-03-15'),
		   ('3', '3', '3', '2022-03-15'),
		   ('4', '4', '2', '2022-02-15'),
		   ('5', '5', '1', '2022-02-15');

#h)Tabla cuenta
INSERT INTO cuenta (cuen_ord_id, cuen_fecha, cuen_hora, cuen_total)
VALUES('1', '2022-03-15', '23:34:33', '120'),
	  ('2', '2022-03-15', '19:22:56', '160'),
      ('3', '2022-03-15', '21:25:02', '190'),
      ('4', '2022-02-15', '12:25:09', '18'),
      ('5', '2022-02-15', '16:42:47', '120');

#--------------------CONSULTAS--------------------

#a) SELECT que muestra las órdenes por mesero con el total de venta para una fecha determinada
#Recuperando uno en específico
SELECT mesero.meser_id, mesero.meser_nombre, orden.ord_id, cuenta.cuen_fecha,
		SUM(cuenta.cuen_total) AS Total_de_venta,
        COUNT(orden.ord_meser_id) AS Ordenes_por_mesero
	FROM mesero
	LEFT JOIN orden
		ON orden.ord_meser_id = 1
	LEFT JOIN cuenta
		ON orden.ord_id = cuenta.cuen_ord_id
        WHERE cuenta.cuen_fecha = '2022-03-15'
        AND orden.ord_meser_id = mesero.meser_id
	GROUP BY mesero.meser_id;

#Recuperando todos
SELECT mesero.meser_id, mesero.meser_nombre, orden.ord_id, cuenta.cuen_fecha,
		SUM(cuenta.cuen_total) AS Total_de_venta,
        COUNT(orden.ord_meser_id) AS Ordenes_por_mesero
	FROM mesero
	LEFT JOIN orden
		ON mesero.meser_id = orden.ord_meser_id 
	LEFT JOIN cuenta
		ON orden.ord_id = cuenta.cuen_ord_id
        WHERE cuenta.cuen_fecha = '2022-03-15'
        AND orden.ord_meser_id = mesero.meser_id
	GROUP BY mesero.meser_id;

#b)SELECT que muestre las órdenes por mesa con el total de venta para una fecha determinada

#Recuperando una en específico
SELECT mesa_id, 
		SUM(cuenta.cuen_total) AS total_venta
	FROM mesa
    INNER JOIN orden
		ON mesa.mesa_id = 2
	INNER JOIN cuenta
		ON orden.ord_id = cuenta.cuen_ord_id
        WHERE cuenta.cuen_fecha = '2022-03-15'
        AND orden.ord_mesa_id = mesa.mesa_id
	GROUP BY mesa_id;
    
#Recuperando todas las mesas
SELECT mesa_id, 
		SUM(cuenta.cuen_total) AS total_venta
	FROM mesa
    INNER JOIN orden
		ON orden.ord_mesa_id = mesa.mesa_id
	INNER JOIN cuenta
		ON orden.ord_id = cuenta.cuen_ord_id
        WHERE cuenta.cuen_fecha = '2022-03-15'
        AND orden.ord_mesa_id = mesa.mesa_id
	GROUP BY mesa_id;
    
#c)SELECT que muestre el total de órdenes y de venta para una fecha determinada   
SELECT 
		COUNT(det_ord_id) AS numero_de_ordenes_de_una_fecha,
        SUM(cuenta.cuen_total) AS total_venta
    FROM detalles
	INNER JOIN cuenta
		ON detalles.det_ord_id = cuenta.cuen_ord_id
		WHERE  detalles.det_fecha = '2022-02-15';
    
#d) SELECT que muestre el total de venta por mes o año.    

#Por mes
SELECT 
		MONTH(cuenta.cuen_fecha) AS Mes,
		SUM(cuenta.cuen_total) AS Total_venta  
	FROM cuenta
		WHERE cuenta.cuen_fecha BETWEEN '2022-03-01' AND '2022-03-31';
        
#Por año 
SELECT
		YEAR(cuenta.cuen_fecha) AS Anio,
		SUM(cuenta.cuen_total) AS Total_venta  
	FROM cuenta
		WHERE cuenta.cuen_fecha BETWEEN '2022-01-01' AND '2023-01-01';
        
#----------CONSULTAS ADICIONALES----------
#1. El número de bebidas alcoholicas que se pidieron en cada mesa, incluyendo su fecha de venta
SELECT mesa.mesa_id, detalles.det_fecha AS Fecha_venta,
		COUNT(bebida.beb_id) AS Cantidad_de_bebidas_alcoholicas
	FROM mesa
    INNER JOIN orden
		ON mesa.mesa_id = orden.ord_mesa_id
	INNER JOIN detalles
		ON orden.ord_id = detalles.det_ord_id
	INNER JOIN bebida
		ON detalles.det_beb_id = bebida.beb_id 
        WHERE bebida.beb_categoria = 'Coctelería' OR bebida.beb_categoria = 'Cervezas'
	GROUP BY mesa_id
    ORDER BY mesa_id;
    
#2. El número de clientes en un mes
SELECT 
		MONTH(cuenta.cuen_fecha) AS Mes,
		SUM(clientes.cli_cantidad) AS Numero_de_clientes  
	FROM clientes
    INNER JOIN mesa
		ON clientes.cli_mesa_id = mesa.mesa_id 
	INNER JOIN orden
		ON mesa.mesa_id = orden.ord_mesa_id
	INNER JOIN cuenta
		ON cuenta.cuen_ord_id = orden.ord_id
		WHERE cuenta.cuen_fecha BETWEEN '2022-02-01' AND '2022-02-28';