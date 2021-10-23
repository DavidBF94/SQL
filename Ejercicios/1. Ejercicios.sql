-- Queries Modelo BDCOCHES

-- Query 1.
-- Obten todos los modelos.
-- 

SELECT *
	FROM MODELOS;

-- Query 2.
-- Obten todos los modelos ordenados alfabeticamente por el nombre del modelo.
-- 

SELECT *
	FROM `MODELOS`
	ORDER BY nommodelo DESC;
	
-- Query 3.
-- Obten todas las marcas ordenadas alfabeticamente.
-- 

SELECT *
	FROM `MARCAS`
	ORDER BY nommarca DESC;
	
-- Query 4.
-- Muestra todos los modelos cuyo año de salida sea 2018.
-- 

SELECT *
	FROM `MODELOS`
	WHERE aniosalida = "2018";

-- Query 5.
-- Muestra todos los modelos de color "rojo" pero que sean del siglo pasado.
-- 

SELECT *
	FROM `MODELOS`
	WHERE color = "rojo" AND aniosalida < "2000";

-- Query 6.
-- Muestra todos los modelos de color "rojo" o "blanco" pero que sean de este siglo.
-- 

SELECT *
	FROM `MODELOS`
	WHERE aniosalida >= "2000" AND (color = "rojo" OR color = "blanco");

-- Query 7.
-- Muestra todos los modelos de este siglo que no sean ni "rojos" ni "blancos".
-- Ordena por año de salida de más viejo a más nuevo.
-- 

SELECT *
	FROM `MODELOS`
	WHERE aniosalida >= "2000" AND (color != "rojo" AND color != "blanco")
	ORDER BY aniosalida ASC;

-- Query 8.
-- Muestra todos los modelos de este siglo cuyo nombre de modelo contenga la cadena "xxxx" ( pues escribir lo que quieras dependiendo de tus datos ).
-- Ordena por color, de la A a la Z, y por el año de salida de más nuevo a más viejo.
-- 

SELECT *
	FROM `MODELOS`
	WHERE nommodelo LIKE "%Ibi%"
	ORDER BY color, nommodelo DESC, aniosalida DESC;

-- Query 9.
-- Muestra todos los modelos no más viejos de 10 años cuyo nombre de modelo empiece por "xxxx" (idem)
-- Ordena del más viejo al más nuevo, y por color alfabeticamente. 
-- 

SELECT *
	FROM `MODELOS`
	WHERE aniosalida >= 2011 AND nommodelo LIKE "M%"
	ORDER BY aniosalida ASC, color DESC;

-- Query 10.
-- Cuenta cuantos paises tenemos.
-- 

SELECT COUNT( * ) AS numpaises
	FROM `PAISES`;

-- Query 11.
-- Cuenta cuantos modelos tenemos.
-- 

SELECT COUNT( * ) AS nummodelos
	FROM `MODELOS`;

-- Query 12.
-- Cuenta cuantos modelos tenemos por marca (vale con el idmarca ). Con nommarca sería Join.
-- 

SELECT idmarca, COUNT( * ) AS nummodelos
	FROM `MODELOS`
	GROUP BY idmarca;

-- Query 13.
-- Cuenta cuantos modelos tenemos por color.
-- Pero no muestres los que empiezan por un color que empiece por la letra "R".
-- Ordena por color.
-- 

SELECT color, COUNT( * ) AS nummodelos
	FROM `MODELOS`
	WHERE color NOT LIKE "r%"
	GROUP BY color
	ORDER BY color DESC;

-- Query 14.
-- Cuenta cuantos modelos tenemos por color.
-- Pero no muestres los que empiezan por un color que empiece por la letra "R" o por la letra "B".
-- Ordena por mayor a menor y por color de la Z a A.
-- 

SELECT color, COUNT( * ) AS nummodelos
	FROM `MODELOS`
	WHERE color NOT LIKE "r%" AND color NOT LIKE "b%"
	GROUP BY color
	ORDER BY aniosalida ASC, color ASC;

-- Query 15.
-- Cuenta cuantos modelos tenemos por color y año salida pero si solo tenemos uno no lo muestres.
-- Ordena de menor a mayor
-- 

SELECT color, aniosalida, COUNT( * ) AS nummodelos
	FROM `MODELOS`
	GROUP BY color, aniosalida
	HAVING ( nummodelos > 1 )
	ORDER BY aniosalida ASC;

-- Query 16.
-- Muestra cuantos coches he vendido.
-- 

SELECT COUNT( * ) AS numventas
	FROM `MODELOSVENDIDOS`;

-- Query 16.1.
-- Muestra el importe total de cuantos coches he vendido.
-- 
 
SELECT SUM( importe ) AS importetotal
	FROM `MODELOSVENDIDOS`;
	
-- Query 16.2.
-- Muestra el importe total de cuantos coches he vendido y el número de coches. ( 2 funciones de agregación en el SELECT. ).
-- 

SELECT SUM( importe ) AS importetotal, COUNT( * ) AS numventas
	FROM `MODELOSVENDIDOS`;

-- Query 17.
-- Muestra cuantos coches he vendido este año.
--

SELECT COUNT( * ) AS numcoches
	FROM `MODELOSVENDIDOS`
	WHERE YEAR( fecventa ) = YEAR(NOW());

-- Query 17.2
-- Muestra cuantos coches he vendido este año y el número de coches y la media de venta.
--

SELECT COUNT( * ) AS numcoches, AVG ( importe ) AS mediaventas
	FROM `MODELOSVENDIDOS`
	WHERE YEAR( fecventa ) = YEAR(NOW());

-- Query 18.
-- Muestra cuantos coches he vendido este año en cada color de venta.
-- 

SELECT colorventa, COUNT( * ) AS numcoches
	FROM `MODELOSVENDIDOS`
	WHERE YEAR( fecventa ) = YEAR(NOW())
	GROUP BY colorventa;

-- Query 19
-- Muestra la media del importe de los coches vendidos este año en cada color de venta.
-- 

SELECT colorventa, COUNT( * ) AS numcoches, AVG ( importe ) AS mediaventascolor
	FROM `MODELOSVENDIDOS`
	WHERE YEAR( fecventa ) = YEAR(NOW())
	GROUP BY colorventa;

-- Query 20.
-- Muestra cuantos coches he vendido este año o el año pasado en cada color de venta y el pago ha sido en efectivo.
-- 

SELECT colorventa, COUNT( * ) AS numcoches
	FROM `MODELOSVENDIDOS`
	WHERE ( YEAR( fecventa ) = YEAR(NOW()) OR YEAR( fecventa ) = YEAR(NOW()) - 1 ) AND btipopago = 1
	GROUP BY colorventa;
	
-- Query 21.
-- Haz un enunciado y la query en la que tengas que poner una función de agregación y un GROUP BY.
-- 

-- Query 22.
-- Haz un enunciado y la query en la que tengas que poner una función de agregación y un GROUP BY y un HAVING.
-- 



