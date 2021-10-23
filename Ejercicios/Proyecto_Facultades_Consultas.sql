
-- Query 1. Quiero saber los nombres de todas las facultades que no empiezan por "Ciencias" y ordenarlas alfabéticamente

SELECT `2000nomfacultad`
	FROM `2000FACULTADES`
	WHERE `2000nomfacultad` NOT LIKE "Ciencias%"
	ORDER BY `2000nomfacultad` ASC;
	
-- Query 2. Quiero saber de cada facultad cuantas carreras imparte pero sólo si tienen más de una carrera

SELECT `2000nomfacultad`, COUNT( * ) AS numcarreras
	FROM `2000FACULTADES`
	INNER JOIN `2100CARRERAS`
	ON 2000FACULTADES.2000idfacultad = 2100CARRERAS.2000idfacultad
	GROUP BY `2000nomfacultad`
	HAVING `numcarreras` > 1;
	
-- Query 3. Quiero saber los nombres de las carreras que pertenezcan a una facultad cuyo nombre empiece por "Ciencias" ó por "F" pero sólo las carreras que empiecen por "B" ó "F"
	
SELECT `2100nomcarrera`
	FROM `2000FACULTADES`
	INNER JOIN `2100CARRERAS`
	ON 2000FACULTADES.2000idfacultad = 2100CARRERAS.2000idfacultad
	WHERE (`2000nomfacultad` LIKE "Ciencias%" OR `2000nomfacultad` LIKE "F%") AND (`2100nomcarrera` LIKE "B%" OR `2100nomcarrera` LIKE "F%");
	
-- Query 4. Quiero saber el nombre de la facultad, el del decano ( junto con su salario ) que mayor salario tiene habiendo comenzado su labor en un año mayor o igual a 2010 hasta el año actual

SELECT `2000nomfacultad`, `1000nomdecano`,`1100salariodecano`
	FROM `1000DECANOS`
	INNER JOIN `1100DECANOFACULTAD`
	ON 1000DECANOS.1000iddecano = 1100DECANOFACULTAD.1000iddecano
	INNER JOIN `2000FACULTADES`
	ON 1100DECANOFACULTAD.2000idfacultad = 2000FACULTADES.2000idfacultad
	WHERE `1100salariodecano`= ( SELECT MAX( `1100salariodecano` ) AS salariomax
								FROM `1000DECANOS`
								INNER JOIN `1100DECANOFACULTAD`
								ON 1000DECANOS.1000iddecano = 1100DECANOFACULTAD.1000iddecano
								INNER JOIN `2000FACULTADES`
								ON 1100DECANOFACULTAD.2000idfacultad = 2000FACULTADES.2000idfacultad
								WHERE YEAR( `1100fecdecano` ) BETWEEN "2010" AND YEAR(NOW()));

-- Query 5. Quiero saber los nombres y apellidos de los alumnos que hayan iniciado dos carreras en la misma fecha ( quiero la fecha )

SELECT `2110feccarrera`, `3000nomalumno`, `3000apellidosalumno`
	FROM `2110CARRERASALUMNOS`
	INNER JOIN `3000ALUMNOS`
	ON 2110CARRERASALUMNOS.3000idalumno = 3000ALUMNOS.3000idalumno
    GROUP BY `2110feccarrera`, `3000nomalumno`, `3000apellidosalumno`
    HAVING COUNT( * ) >= 2;
	
-- Query 6. Quiero saber el nombre de la facultad que imparte cada asignatura, pero solo de aquellas asignaturas que tengan menos de 12 créditos

SELECT `2000nomfacultad`, `2120nomasignatura`
	FROM `2000FACULTADES`
	INNER JOIN `2100CARRERAS`
	ON 2000FACULTADES.2000idfacultad = 2100CARRERAS.2000idfacultad
	INNER JOIN `2120ASIGNATURAS`
	ON 2100CARRERAS.2100idcarrera = 2120ASIGNATURAS.2100idcarrera
	INNER JOIN `5000CREDITOS`
	ON 2120ASIGNATURAS.5000idcreditos = 5000CREDITOS.5000idcreditos
	WHERE `5000numcreditos` < 12;
	
-- Query 7. Quiero saber los nombres de los departamentos tengan o no asignaturas asignadas ( si tienen se ponen sus nombres ), en caso de no tener asignaturas asociadas escribimos "No imparte asignaturas"

SELECT `6000nomdepartamento`, CASE 
	WHEN `2120nomasignatura` IS NULL 
	THEN "No imparte asignaturas"
	ELSE `2120nomasignatura`
	END AS nombreasignatura
	FROM `6000DEPARTAMENTOS`
	LEFT JOIN `2122ASIGNATDEPART`
	ON 6000DEPARTAMENTOS.6000iddepartamento = 2122ASIGNATDEPART.6000iddepartamento
	LEFT JOIN `2120ASIGNATURAS`
	ON 2122ASIGNATDEPART.2120idasignatura = 2120ASIGNATURAS.2120idasignatura;
	
-- Query 8. Quiero los nombres de los departamentos que impartan asignaturas en los cuales la media de sueldos de los profesores es menor de 22000, junto con su salario medio --

SELECT `6000nomdepartamento`, AVG( 6100salarioprofesor ) AS mediasalarios
	FROM `2120ASIGNATURAS`
	INNER JOIN `2122ASIGNATDEPART`
	ON 2120ASIGNATURAS.2120idasignatura = 2122ASIGNATDEPART.2120idasignatura
	INNER JOIN `6000DEPARTAMENTOS`
	ON 2122ASIGNATDEPART.6000iddepartamento = 6000DEPARTAMENTOS.6000iddepartamento
	INNER JOIN `6100PROFESDEPART`
	ON 6000DEPARTAMENTOS.6000iddepartamento = 6100PROFESDEPART.6000iddepartamento
	INNER JOIN `7000PROFESORES`
	ON 6100PROFESDEPART.7000idprofesor = 7000PROFESORES.7000idprofesor
	GROUP BY `6000nomdepartamento`
	HAVING mediasalarios < 22000;
	
-- Query 9. Quiero los nombres y apellidos de los profesores que se hayan cambiado de un departamento a otro pero de la misma facultad únicamente --
	
SELECT `7000nomprofesor`, `7000apellidosprofesor`
	FROM ( SELECT `7000nomprofesor`, `7000apellidosprofesor`, `2000nomfacultad`, COUNT( * ) AS numveces
				FROM `7000PROFESORES`
				INNER JOIN `6100PROFESDEPART`
				ON 7000PROFESORES.7000idprofesor = 6100PROFESDEPART.7000idprofesor
				INNER JOIN `6000DEPARTAMENTOS`
				ON 6100PROFESDEPART.6000iddepartamento = 6000DEPARTAMENTOS.6000iddepartamento
				INNER JOIN `2122ASIGNATDEPART`
				ON 6000DEPARTAMENTOS.6000iddepartamento = 2122ASIGNATDEPART.6000iddepartamento
				INNER JOIN `2120ASIGNATURAS`
				ON 2122ASIGNATDEPART.2120idasignatura = 2120ASIGNATURAS.2120idasignatura
				INNER JOIN `2100CARRERAS`
				ON 2120ASIGNATURAS.2100idcarrera = 2100CARRERAS.2100idcarrera
				INNER JOIN `2000FACULTADES`
				ON 2100CARRERAS.2000idfacultad = 2000FACULTADES.2000idfacultad
				GROUP BY `7000nomprofesor`, `7000apellidosprofesor`, `2000nomfacultad` ) T1
	WHERE numveces > 1
	GROUP BY `7000nomprofesor`, `7000apellidosprofesor`
	HAVING COUNT( * ) = 1;

-- Query 10. Quiero saber qué asignaturas pueden ser impartidas por varios departamentos ( nombre de asignaturas y departamentos ) --

SELECT `2120nomasignatura`, `6000nomdepartamento`					
	FROM `6000DEPARTAMENTOS`
	INNER JOIN `2122ASIGNATDEPART`
	ON 6000DEPARTAMENTOS.6000iddepartamento = 2122ASIGNATDEPART.6000iddepartamento
	INNER JOIN `2120ASIGNATURAS`
	ON 2122ASIGNATDEPART.2120idasignatura = 2120ASIGNATURAS.2120idasignatura
	WHERE `2120nomasignatura` IN ( SELECT `2120nomasignatura`
								FROM `6000DEPARTAMENTOS`
								INNER JOIN `2122ASIGNATDEPART`
								ON 6000DEPARTAMENTOS.6000iddepartamento = 2122ASIGNATDEPART.6000iddepartamento
								INNER JOIN `2120ASIGNATURAS`
								ON 2122ASIGNATDEPART.2120idasignatura = 2120ASIGNATURAS.2120idasignatura
								GROUP BY `2120nomasignatura`
								HAVING COUNT( 6000DEPARTAMENTOS.6000iddepartamento ) > 1 );

-- Query 11. Quiero saber los sueldos base medios ( contando todos los registros ) de cada departamento ( departamentos que imparten asignaturas ) que ha tenido más de un profesor diferente --

SELECT `6000nomdepartamento`, AVG( `6100salarioprofesor` ) AS salariomedio
	FROM `7000PROFESORES`
	INNER JOIN `6100PROFESDEPART`
	ON 7000PROFESORES.7000idprofesor = 6100PROFESDEPART.7000idprofesor
	INNER JOIN `6000DEPARTAMENTOS`
	ON 6100PROFESDEPART.6000iddepartamento = 6000DEPARTAMENTOS.6000iddepartamento
	WHERE `6000nomdepartamento` IN ( SELECT `6000nomdepartamento`
									FROM `7000PROFESORES`
									INNER JOIN `6100PROFESDEPART`
									ON 7000PROFESORES.7000idprofesor = 6100PROFESDEPART.7000idprofesor
									INNER JOIN `6000DEPARTAMENTOS`
									ON 6100PROFESDEPART.6000iddepartamento = 6000DEPARTAMENTOS.6000iddepartamento
									INNER JOIN `2122ASIGNATDEPART`
									ON 6000DEPARTAMENTOS.6000iddepartamento = 2122ASIGNATDEPART.6000iddepartamento
									GROUP BY `6000nomdepartamento`
									HAVING COUNT( * ) > 1 )
	GROUP BY `6000nomdepartamento`;
	
-- Query 12. Quiero saber cuántas asignaturas de primero de carrera tienen asignadas cada departamento --

SELECT `6000nomdepartamento`, COUNT( 2122ASIGNATDEPART.2120idasignatura ) AS numasignatprimero
	FROM `6000DEPARTAMENTOS`, `2122ASIGNATDEPART`, `2120ASIGNATURAS`
	WHERE 6000DEPARTAMENTOS.6000iddepartamento = 2122ASIGNATDEPART.6000iddepartamento 
	AND 2122ASIGNATDEPART.2120idasignatura = 2120ASIGNATURAS.2120idasignatura
	AND `4000idcurso` = 1 
	GROUP BY `6000nomdepartamento`;
	
-- Query 13. Quiero saber de los decanos que se han cambiado de facultad, sus id, nombres de las facultades y salarios de menor a mayor --

SELECT 1000DECANOS.1000iddecano, `1100salariodecano`, `2000nomfacultad`
	FROM `2000FACULTADES`
	INNER JOIN `1100DECANOFACULTAD`
	ON 2000FACULTADES.2000idfacultad = 1100DECANOFACULTAD.2000idfacultad
	INNER JOIN `1000DECANOS`
	ON 1100DECANOFACULTAD.1000iddecano = 1000DECANOS.1000iddecano
	WHERE 1000DECANOS.1000iddecano IN ( SELECT `1000iddecano`
									FROM ( SELECT 1000DECANOS.1000iddecano, `2000nomfacultad`, COUNT( * ) AS numveces
												FROM `2000FACULTADES`
												INNER JOIN `1100DECANOFACULTAD`
												ON 2000FACULTADES.2000idfacultad = 1100DECANOFACULTAD.2000idfacultad
												INNER JOIN `1000DECANOS`
												ON 1100DECANOFACULTAD.1000iddecano = 1000DECANOS.1000iddecano
												GROUP BY 1000DECANOS.1000iddecano, `2000nomfacultad` ) T1
									GROUP BY `1000iddecano`
									HAVING COUNT( * ) > 1 ) 
	ORDER BY `1100salariodecano` ASC;

-- Query 14. Quiero saber de cada decano que se ha cambiado de facultad, su id y el nombre de la facultad en la que menor salario ha tenido --
	
SELECT `1000iddecano`, `2000nomfacultad`, MIN( `1100salariodecano` ) 
	FROM ( SELECT 1000DECANOS.1000iddecano, `1100salariodecano`, `2000nomfacultad`
				FROM `2000FACULTADES`
				INNER JOIN `1100DECANOFACULTAD`
				ON 2000FACULTADES.2000idfacultad = 1100DECANOFACULTAD.2000idfacultad
				INNER JOIN `1000DECANOS`
				ON 1100DECANOFACULTAD.1000iddecano = 1000DECANOS.1000iddecano
				WHERE 1000DECANOS.1000iddecano IN ( SELECT `1000iddecano`
												FROM ( SELECT 1000DECANOS.1000iddecano, `2000nomfacultad`, COUNT( * ) AS numveces
															FROM `2000FACULTADES`
															INNER JOIN `1100DECANOFACULTAD`
															ON 2000FACULTADES.2000idfacultad = 1100DECANOFACULTAD.2000idfacultad
															INNER JOIN `1000DECANOS`
															ON 1100DECANOFACULTAD.1000iddecano = 1000DECANOS.1000iddecano
															GROUP BY 1000DECANOS.1000iddecano, `2000nomfacultad` ) T1
												GROUP BY `1000iddecano`
												HAVING COUNT( * ) > 1 ) ) T2
	GROUP BY `1000iddecano`;

-- Query 15. Quiero saber de entre todos los alumnos cual ha sido la mayor cantidad de elecciones para elegir carrera --

SELECT MAX( numelecciones ) AS eleccionesMaxPorAlumno
	FROM ( SELECT `3000idalumno`, `3000nomalumno`, `3000apellidosalumno`, COUNT( * ) AS numelecciones
				FROM ( SELECT 3000ALUMNOS.3000idalumno, `3000nomalumno`, `3000apellidosalumno`, `2110feccarrera`, `2100nomcarrera`
							FROM `2110CARRERASALUMNOS`
							INNER JOIN `3000ALUMNOS`
							ON 2110CARRERASALUMNOS.3000idalumno = 3000ALUMNOS.3000idalumno
							INNER JOIN `2100CARRERAS`
							ON 2110CARRERASALUMNOS.2100idcarrera = 2100CARRERAS.2100idcarrera
							ORDER BY 3000ALUMNOS.3000idalumno, `2110feccarrera` DESC ) T1
				GROUP BY `3000idalumno`) T2;

-- Query 16. Quiero saber las asignaturas que existen en más de una carrera con el mismo nombre --

SELECT 2120ASIGNATURAS.2120idasignatura, `2120nomasignatura`, 2100CARRERAS.2100idcarrera, `2100nomcarrera`
	FROM `2120ASIGNATURAS`
	INNER JOIN `2100CARRERAS`
	ON 2120ASIGNATURAS.2100idcarrera = 2100CARRERAS.2100idcarrera
	WHERE `2120nomasignatura` IN ( SELECT `2120nomasignatura`
								FROM `2120ASIGNATURAS`
								INNER JOIN `2100CARRERAS`
								ON 2120ASIGNATURAS.2100idcarrera = 2100CARRERAS.2100idcarrera
								GROUP BY `2120nomasignatura`
								HAVING COUNT( * )  > 1 );

-- Query 17, Quiero saber cuál ha sido el precio que ha tenido cada alumno ordenado por idalumno, asignatura, numero de creditos, fecha de inicio y precio

WITH Q1 AS ( SELECT `3000idalumno`, `2120nomasignatura`, `5000numcreditos`, `2121Afecinicioalum`, COUNT( * ) AS numveces
				FROM `2121AASIGNATCARRALUMNGRUPO`
				INNER JOIN `2120ASIGNATURAS`
				ON 2121AASIGNATCARRALUMNGRUPO.2120idasignatura = 2120ASIGNATURAS.2120idasignatura
				INNER JOIN `5000CREDITOS`
				ON 2120ASIGNATURAS.5000idcreditos = 5000CREDITOS.5000idcreditos
				GROUP BY `3000idalumno`, `2120nomasignatura`, `2121Afecinicioalum` )

SELECT  `3000idalumno`,
		`2120nomasignatura`,
		`5000numcreditos`,
		`2121Afecinicioalum`,
		precio * `5000numcreditos` + ( numeroveces - 1 ) * incremento * 0.01 * precio * `5000numcreditos` AS preciofinal
		FROM(SELECT`3000idalumno`,
					`2120nomasignatura`,
					`5000numcreditos`,
					`2121Afecinicioalum`,
					`numeroveces`,
					( SELECT `9000preciocredito`
						FROM `9000preciocreditos` 
						WHERE `9000anno` = YEAR( `2121Afecinicioalum` ) ) precio,
					( SELECT `9000incremento`
						FROM `9000preciocreditos` 
						WHERE `9000anno` = YEAR( `2121Afecinicioalum` ) ) incremento
					FROM ( SELECT T1.`3000idalumno`, T1.`2120nomasignatura`, T1.`5000numcreditos`, T1.`2121Afecinicioalum`, SUM( T2.numveces ) AS numeroveces
							FROM Q1 T1
							INNER JOIN Q1 T2
							ON T1.`3000idalumno` = T2.`3000idalumno` AND T1.`2121Afecinicioalum` >= T2.`2121Afecinicioalum`
							GROUP BY T1.`3000idalumno`, T1.`2121Afecinicioalum`) T3) T4;

