
USE BDCoches;
 
-- Query 1.
-- Quiero saber de que paises tengo marcas de coches pero que no tengo modelos.

SELECT nompais, COUNT( nommodelo ) AS nummodelos
	FROM PAISES 
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	LEFT JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
    GROUP BY nompais
	HAVING nummodelos = 0;

-- Query 2.
-- Quiero saber de que paises tengo marcas de coches pero si tengo modelos.

SELECT nompais, COUNT( nommodelo ) AS nummodelos
	FROM PAISES 
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	LEFT JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
    GROUP BY nompais
	HAVING nummodelos > 0;

-- Query 3.
-- Quiero saber de que paises tengo marcas de coches pero si tengo modelos y no he vendido ningun modelo de ese pais.

SELECT nompais, COUNT( MODELOSVENDIDOS.idmodelo ) AS numventas
	FROM PAISES 
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	LEFT JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
    GROUP BY nompais
	HAVING numventas = 0;
	
-- Query 4.
-- Quiero saber de que paises tengo marcas de coches pero si tengo modelos y no he vendido ningun modelo de ese pais este año.

SELECT nompais, COUNT( MODELOSVENDIDOS.idmodelo ) AS numventas
	FROM PAISES 
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	LEFT JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE YEAR(fecventa) = YEAR(NOW())
    GROUP BY nompais
	HAVING numventas = 0;

-- Query 5.
-- Quiero saber de que paises tengo marcas de coches pero si tengo modelos y no he vendido ningun modelo de ese pais este año pero si en años anteriores.

SELECT nompais, COUNT( MODELOSVENDIDOS.idmodelo ) AS numventas
	FROM PAISES 
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	INNER JOIN MODELOS
	ON MARCAS.idmarca = MODELOS.idmarca
	LEFT JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE YEAR(fecventa) != YEAR(NOW())
    GROUP BY nompais
	HAVING numventas > 0;

-- Query 7.
-- Quiero saber que modelos han sido vendidos en el mismo año de salida.

SELECT nommodelo
	FROM MODELOS
	INNER JOIN MODELOSVENDIDOS
	ON MODELOS.idmodelo = MODELOSVENDIDOS.idmodelo
	WHERE aniosalida = YEAR (fecventa);

-- Query 8.
-- Quiero saber los 2 paises ( el nombre ) donde más coches se venden.
-- Pista: LIMIT Busca en internet.

SELECT nompais, SUM( importe ) AS sumaimporte
	FROM MODELOSVENDIDOS
	INNER JOIN PAISES
	ON MODELOSVENDIDOS.idpais = PAISES.idpais
	GROUP BY nompais
	ORDER BY sumaimporte DESC, nompais DESC
	LIMIT 2;

-- Query 9.
-- Quiero saber los paises ( los nombres del pais y su continente ) en los que se venden modelos.

SELECT DISTINCT nompais, nomcontinente
	FROM MODELOSVENDIDOS
	INNER JOIN PAISES
	ON MODELOSVENDIDOS.idpais = PAISES.idpais
	INNER JOIN CONTINENTES
	ON PAISES.idcontinente = CONTINENTES.idcontinente;

-- Query 10.
-- Quiero saber los paises ( los nombres del pais y su continente ) en los que se venden modelos pero que no tienen marcas.

-- Query 11.
-- Quiero saber los paises ( los nombres del pais y su continente ) en los que se venden modelos pero solo de marcas de su pais.

SELECT T1.nompais, nomcontinente
	FROM CONTINENTES
	INNER JOIN PAISES T1
	ON CONTINENTES.idcontinente = T1.idcontinente
	INNER JOIN MODELOSVENDIDOS
	ON T1.idpais = MODELOSVENDIDOS.idpais
	INNER JOIN MODELOS
	ON MODELOSVENDIDOS.idmodelo = MODELOS.idmodelo
	INNER JOIN MARCAS
	ON MODELOS.idmarca = MARCAS.idmarca
	INNER JOIN PAISES T2
	ON MARCAS.idpais = T2.idpais
	WHERE T1.nompais = T2.nompais;
