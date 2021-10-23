USE BDCOCHES;
 
-- Query 1.
-- Quiero saber todas las marcas ( el nombre ) que tengan modelos en el año 2020 ( elige otro si te viene bien).
-- 

SELECT *
	FROM MARCAS
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	WHERE aniosalida = "2021";

-- Query 2.
-- Quiero saber todas las marcas ( el nombre ) que tengan modelos en el año actual y en el anterior.
-- 

SELECT *
	FROM MARCAS
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	WHERE aniosalida = YEAR(NOW()) AND aniosalida = YEAR(NOW()) - 1;

-- Query 3. Igual que Query 2. 
-- Pero que no sean del pais 1 ( cualquier otro si te viene bien.).

SELECT *
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	WHERE PAISES.idpais != "JPN" AND (aniosalida = YEAR(NOW()) AND aniosalida = YEAR(NOW()) - 1);

-- Query 3.1. Igual que Query 2. 
-- Pero que no sean del pais Alemania ( cualquier otro si te viene bien.).

SELECT *
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	WHERE PAISES.nompais != "Japon" AND (aniosalida = YEAR(NOW()) AND aniosalida = YEAR(NOW()) - 1);

-- Query 4.
-- Lista por pais de pertenencia todos los modelos de coches ( no importa el año, o sea Ibiza 2018 e Ibiza 2020 es el mismo modelo ).
-- Si un país no tiene coches no lo muestres.

SELECT nompais, nommodelo
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	GROUP BY nompais, nommodelo;

-- Query 4.1. Igual que 4. Pero ahora cuentalos.
--

SELECT nommodelo, COUNT( idmodelo ) AS nummodelos
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	GROUP BY nommodelo;

-- Query 5. Igual que 4 pero ahora si muestra el pais.

SELECT nompais,nommarca,nommodelo
	FROM PAISES
	LEFT JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	LEFT JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca;

-- Query 5.1. Igual que 5. Ahora cuentalos.

SELECT nompais,nommarca,nommodelo, COUNT( idmodelo ) AS nummodelos
	FROM PAISES
	LEFT JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	LEFT JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	GROUP BY nompais,nommarca, nommodelo;

-- Query 6. Lista que modelos he vendido, muestra el nombre del modelo, año de salida, color, el importe, la fecha de venta, el tipo de pago y el colorventa.

SELECT nommodelo, aniosalida, color, importe, fecventa, btipopago, colorventa
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo;

-- Query 7. Quiero saber que coches he vendido, muestra el nombre del modelo y anio salida, en los últimos 30 días por un importe superior o igual a 10.000,00 dolares y cuyo pago fue en efectivo.

SELECT nommodelo, aniosalida
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE fecventa >= NOW() - INTERVAL 30 DAY AND importe >= 10000 AND btipopago = 1;

-- Query 8. Lo mismo que 7, pero ahora cuentalos y calcula el importe total de venta y también la media.

SELECT nommodelo, aniosalida, COUNT( * ) AS numcochesvendidos, SUM( importe ) AS sumaimportes, AVG( importe ) AS mediaimportes
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE fecventa >= NOW() - INTERVAL 30 DAY AND importe >= 10000 AND btipopago = 1;

-- Query 9. Quiero saber cuantos coches he vendido cuyo color era el mismo que el original ( el color original es el campo color de la tabla MODELOS. ).

SELECT COUNT( * ) AS numventascolorigual
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE color = colorventa;

-- Query 9.1. Igual que 9 pero quiero saberlo por año de venta.
-- Ordena por año del mas recienta al más antiguo.

SELECT YEAR(fecventa), COUNT( * ) AS numventascolorigual
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE color = colorventa
	GROUP BY YEAR(fecventa)
	ORDER BY YEAR(fecventa) DESC;

-- Query 10. Quiero saber la media del importe de los coches que he vendido desglosado por mes del año anterior.

SELECT MONTH(fecventa), AVG( importe ) AS mediaimportes
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE YEAR(fecventa) = YEAR(NOW()) - 1
	GROUP BY MONTH(fecventa);

-- Query 11. Quiero un informe completo de los coches que he vendido, sabiendo el nombre del modelo, año de salida, color original, importe de venta, fecha de la venta, tipo de pago, colorventa, marca, pais al que pertenece la marca y el continente.

SELECT nommodelo, aniosalida, color, importe, fecventa, btipopago, colorventa, nommarca, nompais, nomcontinente
	FROM MODELOSVENDIDOS 
	INNER JOIN MODELOS
	ON MODELOSVENDIDOS.idmodelo = MODELOS.idmodelo
	INNER JOIN MARCAS
	ON MODELOS.idmarca = MARCAS.idmarca
	INNER JOIN PAISES
	ON MARCAS.idpais = PAISES.idpais
	INNER JOIN CONTINENTES
	ON PAISES.idcontinente = CONTINENTES.idcontinente;

-- Query 11.1. Solo de este año.

SELECT nommodelo, aniosalida, color, importe, fecventa, btipopago, colorventa, nommarca, nompais, nomcontinente
	FROM MODELOSVENDIDOS 
	INNER JOIN MODELOS
	ON MODELOSVENDIDOS.idmodelo = MODELOS.idmodelo
	INNER JOIN MARCAS
	ON MODELOS.idmarca = MARCAS.idmarca
	INNER JOIN PAISES
	ON MARCAS.idpais = PAISES.idpais
	INNER JOIN CONTINENTES
	ON PAISES.idcontinente = CONTINENTES.idcontinente
	WHERE YEAR(fecventa) = YEAR(NOW());

-- Query 11.2. Igual que 11 pero tambien el nombre del pais en el que fue comprado el coche.

-- Query 11.3. Igual que 11.2 pero solo los coches que fueron comprados en el pais al cual pertenece la marca del modelo.