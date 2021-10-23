
DROP DATABASE IF EXISTS BDFACULTADES;

CREATE DATABASE BDFACULTADES DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE BDFACULTADES;



-- INICIO --



-- PARTE 1 --

-- 1 Tabla DECANOS --

CREATE TABLE `1000DECANOS` (
	1000iddecano SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	1000dnidecano CHAR( 9 ) NOT NULL, 
	1000nomdecano CHAR( 20 ) NOT NULL,
	1000apellidosdecano CHAR( 50 ) NOT NULL, 
	1000direcciondecano CHAR( 80 ) NOT NULL, 
	1000telefonodecano CHAR( 9 ) NOT NULL,
	1000correodecano CHAR( 50 ) NOT NULL,
	1000nomficherofotodecano CHAR( 50 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 2 Tabla FACULTADES --

CREATE TABLE `2000FACULTADES` (
	2000idfacultad TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	2000nomfacultad CHAR( 40 ) NOT NULL,
	2000direccionfacultad CHAR( 80 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 3 Tabla AlUMNOS --

CREATE TABLE `3000ALUMNOS` (
	3000idalumno MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	3000dnialumno CHAR( 9 ) NOT NULL, 
	3000nomalumno CHAR( 20 ) NOT NULL,
	3000apellidosalumno CHAR( 50 ) NOT NULL, 
	3000direccionalumno CHAR( 80 ) NOT NULL, 
	3000telefonoalumno CHAR( 9 ) NOT NULL,
	3000correoalumno CHAR( 50 ) NOT NULL,
	3000nomficherofotoalumno CHAR( 50 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 4 Tabla CURSOS --

CREATE TABLE `4000CURSOS` (
	4000idcurso TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	4000nomcurso CHAR( 20 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 5 Tabla CREDITOS --

CREATE TABLE `5000CREDITOS` (
	5000idcreditos TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	5000numcreditos FLOAT( 3, 1 ) UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 6 Tabla GRUPOS --

CREATE TABLE `8000GRUPOS` (
	8000idgrupo TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	8000nomgrupo CHAR( 1 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 7 Tabla DEPARTAMENTOS --

CREATE TABLE `6000DEPARTAMENTOS` (
	6000iddepartamento SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	6000nomdepartamento CHAR( 50 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 8 Tabla PROFESORES --

CREATE TABLE `7000PROFESORES` (
	7000idprofesor SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	7000dniprofesor CHAR( 9 ) NOT NULL, 
	7000nomprofesor CHAR( 20 ) NOT NULL,
	7000apellidosprofesor CHAR( 50 ) NOT NULL, 
	7000direccionprofesor CHAR( 80 ) NOT NULL, 
	7000telefonoprofesor CHAR( 9 ) NOT NULL,
	7000correoprofesor CHAR( 50 ) NOT NULL,
	7000nomficherofotoprofesor CHAR( 50 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- PARTE 2 --

-- 9 Tabla DECANOFACULTAD --

CREATE TABLE `1100DECANOFACULTAD` (
	1000iddecano SMALLINT UNSIGNED,
	2000idfacultad TINYINT UNSIGNED,
	1100fecdecano DATE,
	PRIMARY KEY ( 1000iddecano, 2000idfacultad, 1100fecdecano ),
	CONSTRAINT `fk_ DECANOFACULTAD_iddecano` FOREIGN KEY ( 1000iddecano ) REFERENCES `1000DECANOS` ( 1000iddecano ),
	CONSTRAINT `fk_ DECANO_FACULTAD_idfacultad` FOREIGN KEY ( 2000idfacultad ) REFERENCES `2000FACULTADES` ( 2000idfacultad ),
	1100salariodecano FLOAT( 7, 2 ) UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 10 Tabla CARRERAS --

CREATE TABLE `2100CARRERAS` (
	2100idcarrera TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	2000idfacultad TINYINT UNSIGNED NOT NULL,
	CONSTRAINT `fk_CARRERAS_idfacultad` FOREIGN KEY ( 2000idfacultad ) REFERENCES `2000FACULTADES` ( 2000idfacultad ),
	2100nomcarrera CHAR( 60 ) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 11 Tabla CARRERASALUMNOS --

CREATE TABLE `2110CARRERASALUMNOS` (
	2110feccarrera DATE,
	3000idalumno MEDIUMINT UNSIGNED,
	2100idcarrera TINYINT UNSIGNED,
	PRIMARY KEY ( 2110feccarrera, 3000idalumno, 2100idcarrera ),
	CONSTRAINT `fk_CARRERASALUMNOS_idalumno` FOREIGN KEY ( 3000idalumno ) REFERENCES `3000ALUMNOS` ( 3000idalumno ),
	CONSTRAINT `fk_CARRERASALUMNOS_idcarrera` FOREIGN KEY ( 2100idcarrera ) REFERENCES `2100CARRERAS` ( 2100idcarrera )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 12 Tabla ASIGNATURAS --

CREATE TABLE `2120ASIGNATURAS` (
	2120idasignatura SMALLINT UNSIGNED,  
	2100idcarrera TINYINT UNSIGNED,
	PRIMARY KEY ( 2120idasignatura, 2100idcarrera ),
	4000idcurso TINYINT UNSIGNED NOT NULL,
	5000idcreditos TINYINT UNSIGNED NOT NULL,
	CONSTRAINT `fk_ASIGNATURAS_idcarrera` FOREIGN KEY ( 2100idcarrera ) REFERENCES `2100CARRERAS` ( 2100idcarrera ),
	CONSTRAINT `fk_ASIGNATURAS_idcurso` FOREIGN KEY ( 4000idcurso ) REFERENCES `4000CURSOS` ( 4000idcurso ),
	CONSTRAINT `fk_ASIGNATURAS_idcreditos` FOREIGN KEY ( 5000idcreditos ) REFERENCES `5000CREDITOS` ( 5000idcreditos ),
	2120nomasignatura CHAR( 50 ) NOT NULL,
	2120bvigencia BOOLEAN NOT NULL,
	UNIQUE ( 2120idasignatura )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
	
-- 13 Tabla ASIGNATGRUPO --

CREATE TABLE `2121ASIGNATGRUPO` (
	8000idgrupo TINYINT UNSIGNED,
	2120idasignatura SMALLINT UNSIGNED,
	2121fecgrupo DATE,
	PRIMARY KEY ( 8000idgrupo, 2120idasignatura, 2121fecgrupo ),
	CONSTRAINT `fk_ASIGNATGRUPO_idgrupo` FOREIGN KEY ( 8000idgrupo ) REFERENCES `8000GRUPOS` ( 8000idgrupo ),
	CONSTRAINT `fk_ASIGNATGRUPO_idasignatura` FOREIGN KEY ( 2120idasignatura ) REFERENCES `2120ASIGNATURAS` ( 2120idasignatura )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 14 Tabla ASIGNATDEPART --

CREATE TABLE `2122ASIGNATDEPART` (
	2120idasignatura SMALLINT UNSIGNED, 
	6000iddepartamento SMALLINT UNSIGNED, 
	PRIMARY KEY ( 2120idasignatura, 6000iddepartamento ),
	CONSTRAINT `fk_ASIGNATDEPART_idasignatura` FOREIGN KEY ( 2120idasignatura ) REFERENCES `2120ASIGNATURAS` ( 2120idasignatura ),
	CONSTRAINT `fk_ASIGNATDEPART_iddepartamento` FOREIGN KEY ( 6000iddepartamento ) REFERENCES `6000DEPARTAMENTOS` ( 6000iddepartamento )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 15 Tabla PROFESDEPART --

CREATE TABLE `6100PROFESDEPART` (
	6000iddepartamento SMALLINT UNSIGNED,
	7000idprofesor SMALLINT UNSIGNED, 
	6100fecdepartamento DATE, 
	PRIMARY KEY ( 6000iddepartamento, 7000idprofesor, 6100fecdepartamento ),
	CONSTRAINT `fk_PROFESDEPART_iddepartamento` FOREIGN KEY ( 6000iddepartamento ) REFERENCES `6000DEPARTAMENTOS` ( 6000iddepartamento ),
	CONSTRAINT `fk_PROFESDEPART_idprofesor` FOREIGN KEY ( 7000idprofesor ) REFERENCES `7000PROFESORES` ( 7000idprofesor ),
	6100salarioprofesor FLOAT( 7, 2 ) UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- PARTE 3 --

-- 16 Tabla ASIGNATCARRALUMNGRUPO --

CREATE TABLE `2121AASIGNATCARRALUMNGRUPO` (
	2110feccarrera DATE,
	3000idalumno MEDIUMINT UNSIGNED,
	2100idcarrera TINYINT UNSIGNED, 
	2120idasignatura SMALLINT UNSIGNED,
	8000idgrupo TINYINT UNSIGNED,
	2121fecgrupo DATE,
	2121Afecinicioalum DATE,
	PRIMARY KEY ( 2110feccarrera, 3000idalumno, 2100idcarrera, 2120idasignatura, 8000idgrupo, 2121fecgrupo, 2121Afecinicioalum ),
	CONSTRAINT `fk_ASIGNATCARRALUMNGRUPO_feccarrera_idalumno_idcarrera` FOREIGN KEY ( 2110feccarrera, 3000idalumno, 2100idcarrera ) REFERENCES `2110CARRERASALUMNOS` ( 2110feccarrera, 3000idalumno, 2100idcarrera ),
	CONSTRAINT `fk_ASIGNATCARRALUMNGRUPO_idasignatura_idcarrera` FOREIGN KEY ( 2120idasignatura, 2100idcarrera ) REFERENCES `2120ASIGNATURAS` ( 2120idasignatura, 2100idcarrera ),
	CONSTRAINT `fk_ASIGNATCARRALUMNGRUPO_idgrupo_idasignatura_fecgrupo` FOREIGN KEY ( 8000idgrupo, 2120idasignatura, 2121fecgrupo ) REFERENCES `2121ASIGNATGRUPO` ( 8000idgrupo, 2120idasignatura, 2121fecgrupo )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 17 Tabla ASIGNATPROFDEPARTGRUPO --

CREATE TABLE `2122AASIGNATPROFDEPARTGRUPO` (
	2121fecgrupo DATE, 
	8000idgrupo TINYINT UNSIGNED,
	2120idasignatura SMALLINT UNSIGNED, 
	6000iddepartamento SMALLINT UNSIGNED,
	7000idprofesor SMALLINT UNSIGNED, 
	6100fecdepartamento DATE,
	2122Afecinicioprof DATE,
	PRIMARY KEY ( 2121fecgrupo, 8000idgrupo, 2120idasignatura, 6000iddepartamento, 7000idprofesor, 6100fecdepartamento, 2122Afecinicioprof ),
	CONSTRAINT `fk_ASIGNATPROFDEPARTGRUPO_fecgrupo_idgrupo_idasignatura` FOREIGN KEY ( 8000idgrupo, 2120idasignatura, 2121fecgrupo ) REFERENCES `2121ASIGNATGRUPO` ( 8000idgrupo, 2120idasignatura, 2121fecgrupo ),
	CONSTRAINT `fk_ASIGNATPROFDEPARTGRUPO_idasignatura_iddepartamento` FOREIGN KEY ( 2120idasignatura, 6000iddepartamento ) REFERENCES `2122ASIGNATDEPART` ( 2120idasignatura, 6000iddepartamento ),
	CONSTRAINT `fk_ASIGNATPROFDEPARTGRUPO_iddepart_idprof_fecdepart` FOREIGN KEY ( 6000iddepartamento, 7000idprofesor, 6100fecdepartamento ) REFERENCES `6100PROFESDEPART` ( 6000iddepartamento, 7000idprofesor, 6100fecdepartamento )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- PARTE 4 --

-- 18 Tabla PRECIOCREDITOS --

CREATE TABLE `9000PRECIOCREDITOS` (
	9000anno CHAR( 4 ) PRIMARY KEY,
	9000preciocredito FLOAT( 4, 2 ) UNSIGNED NOT NULL,
	9000incremento FLOAT( 4, 2 ) UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
