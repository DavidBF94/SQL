
USE BDCOCHES;

-- Query 1.
-- Quiero todos los paises que tengan marcas.
-- 

SELECT *
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais;

-- Query 2.
-- Quiero todos los paises que tengan marcas.
-- Pero cuya marca empiece por "letra" (Pon la letra que mejor te convenga ).

SELECT *
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	WHERE nommarca LIKE "H%";

-- Query 3.
-- Quiero todos los paises que tengan marcas.
-- Pero que el pais sea del continente 1.

SELECT *
	FROM CONTINENTES
	INNER JOIN PAISES
	ON CONTINENTES.idcontinente = PAISES.idcontinente
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	WHERE CONTINENTES.idcontinente = 1;

-- Query 4.
-- Quiero todos los paises que tengan marcas.
-- Pero que el pais sea del continente Europa.

SELECT *
	FROM CONTINENTES
	INNER JOIN PAISES
	ON CONTINENTES.idcontinente = PAISES.idcontinente
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	WHERE CONTINENTES.nomcontinente = "Europa";

-- Query 5.
-- Quiero todos los paises que tengan marcas.
-- Pero cuya marca empiece por "letra" (Pon la letra que mejor te convenga ).
-- Pero que el pais sea del continente Europa.

SELECT *
	FROM CONTINENTES
	INNER JOIN PAISES
	ON CONTINENTES.idcontinente = PAISES.idcontinente
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	WHERE CONTINENTES.nomcontinente = "Europa" AND Marcas.nommarca LIKE "F%";

-- Query 6.
-- Quiero saber por cada pais( el nombre ) cuantas marcas tienen. ( NO CUALES ).

SELECT nompais, COUNT( * ) AS nummarcaspais
	FROM PAISES
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	GROUP BY nompais;

-- Query 7.
-- Quiero saber que paises no tienen marcas.

SELECT *
	FROM PAISES
	LEFT JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	WHERE MARCAS.idpais IS NULL;

-- Query 8.
-- Quiero saber que paises no tienen marcas y también los paises que tienen marcas incluyendo el número de marcas que tienen.
-- Ordena por el que tiene mas marcas primero y si tienen el mismo número de marcas ordena por orden alfabetico por el nombre del pais.
-- 

SELECT nompais, COUNT( idmarca ) AS nummarcas
	FROM PAISES
	LEFT JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	GROUP BY nompais
	ORDER BY nummarcas DESC, nompais ASC;

-- Query 9.
-- Quiero saber que paises no tienen marcas y también los paises que tienen marcas incluyendo el número de marcas que tienen.
-- Ordena por el nombre del pais.
-- 

SELECT nompais, COUNT( idmarca ) AS nummarcas
	FROM PAISES
	LEFT JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	GROUP BY nompais
	ORDER BY nompais ASC;

-- Query 10.
-- Quiero saber cuantas marcas tengo por continente. 
--

SELECT nomcontinente, COUNT( idmarca ) AS nummarcas
	FROM CONTINENTES
	INNER JOIN PAISES
	ON CONTINENTES.idcontinente = PAISES.idcontinente
	INNER JOIN MARCAS
	ON PAISES.idpais = MARCAS.idpais
	GROUP BY nomcontinente;
