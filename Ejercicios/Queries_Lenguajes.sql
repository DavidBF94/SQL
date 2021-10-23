
-- Query 1. Realizad una consulta sobre la tabla lenguajes (y solamente sobre la tabla lenguajes) en la cual tenga que utilizar un ORDER BY con dos campos, uno ascendente y otro descendente.
-- Además, emplee en la misma query un AND y también un OR. --

SELECT `100_nomlenguaje`, `100_aniocreacion`
	FROM `100_LENGUAJES`
	WHERE `100_aniocreacion` > "1970" AND ( `100_nomlenguaje` LIKE "J%" OR `100_nomlenguaje` LIKE "P%" )
	ORDER BY `100_nomlenguaje` ASC, `100_aniocreacion` DESC;

-- Query 2. Realizad una consulta sobre la tabla lenguajes (y solamente sobre la tabla lenguajes) en la cual cuente los lenguajes según el año de creación, pero solo de los lenguajes que estén activos.

SELECT `100_aniocreacion`, COUNT( * ) AS numLenguajes
	FROM `100_LENGUAJES`
	WHERE `100_activo` = 1
	GROUP BY `100_aniocreacion`;

-- Query 3. Realice una consulta en la cual obtenga el nombre de la imagen asociado a cada lenguaje. Muestre solo el nombre del lenguaje, el año de creación y el nombre del fichero de la imagen. Pero solo si el fichero de la imagen tiene extensión png. Ordene 
-- los registros por el nombre del lenguaje.

SELECT `100_nomlenguaje`, `100_aniocreacion`, `400_nomfichero`
	FROM `400_imagenes`
	INNER JOIN `100_LENGUAJES`
	ON 400_imagenes.400_idimagen = 100_LENGUAJES.100_idlenguaje
	WHERE `400_nomfichero` LIKE "%.png"
	ORDER BY `100_nomlenguaje`;

-- Query 4. Realice una consulta en la cual obtenga los nombres de los autores que hayan escrito un lenguaje (se debe entender que en la tabla 120_lenguajesautores están escritos los registros de los autores que escribieron un lenguaje) que hayan nacido antes del -- año 1970.
-- Sugerencia: Al menos deben salir dos registros de dos autores, uno de ellos debe haber escrito al menos dos lenguajes y otro solamente un lenguaje.

SELECT DISTINCT `300_nomautor`
	FROM `100_LENGUAJES`
	INNER JOIN `120_LENGUAJESAUTORES`
	ON 100_LENGUAJES.100_idlenguaje = 120_LENGUAJESAUTORES.100_idlenguaje
	INNER JOIN `300_AUTORES`
	ON 120_LENGUAJESAUTORES.300_idautor = 300_AUTORES.300_idautor
	WHERE YEAR(`300_fecnacimiento`) < "1970"
	ORDER BY `300_nomautor`;

-- Query 5. Realice una consulta en la cual obtenga los nombres de los paradigmas y qué lenguaje tienen asociado o asociados.

SELECT `200_nomparadigma`, `100_nomlenguaje`
	FROM `200_PARADIGMAS`
	LEFT JOIN `110_LENGUAJESPARADIGMAS`
	ON 200_PARADIGMAS.200_idparadigma = 110_LENGUAJESPARADIGMAS.200_idparadigma
	LEFT JOIN `100_LENGUAJES`
	ON 110_LENGUAJESPARADIGMAS.100_idlenguaje = 100_LENGUAJES.100_idlenguaje;

