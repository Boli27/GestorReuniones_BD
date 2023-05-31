--Correccion DML dada por la IA para nuestra Base de datos 
-- Creación de la base de datos
CREATE DATABASE nombre_basededatos;

-- Selección de la base de datos
USE nombre_basededatos;

-- Creación de la tabla "lugar_procedencia"
CREATE TABLE lugar_procedencia (
    id_lugar_procedencia INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50)
);

-- Creación de la tabla "persona"
CREATE TABLE persona (
    id_persona INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_lugar_procedencia INT(10),
    nombre VARCHAR(50),
    telefono VARCHAR(15),
    tipo_asistente VARCHAR(10),
    FOREIGN KEY (id_lugar_procedencia) REFERENCES lugar_procedencia (id_lugar_procedencia) ON DELETE CASCADE
);

-- Creación de la tabla "partido_politico"
CREATE TABLE partido_politico (
    id_partido INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    url_logo VARCHAR(50)
);

-- Creación de la tabla "reunion"
CREATE TABLE reunion (
    id_reunion INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_partido INT(10),
    fecha DATE,
    tematica VARCHAR(50),
    hora VARCHAR(10),
    dirigida_por VARCHAR(50),
    presupuesto INT(10),
    FOREIGN KEY (id_partido) REFERENCES partido_politico (id_partido)
);

-- Creación de la tabla "lugar_reunion"
CREATE TABLE lugar_reunion (
    id_lugar_reunion INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50)
);

-- Creación de la tabla "item"
CREATE TABLE item (
    id_item INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre_item VARCHAR(50)   
);

-- Creación de la tabla "propuesta"
CREATE TABLE propuesta (
    id_propuesta INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tema_propuesta VARCHAR(500),
    descripcion_propuesta VARCHAR(500)
);

-- Creación de la tabla "pregunta"
CREATE TABLE pregunta (
    id_pregunta INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_propuesta INT(10),
    descripcion_pregunta TEXT,
    FOREIGN KEY (id_propuesta) REFERENCES propuesta (id_propuesta) ON DELETE CASCADE
);

-- Creación de la tabla "persona_pregunta"
CREATE TABLE persona_pregunta (
    id_perso_pregun INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_persona INT(10),
    id_pregunta INT(10),
    respuesta VARCHAR(50),
    FOREIGN KEY (id_persona) REFERENCES persona (id_persona) ON DELETE CASCADE,
    FOREIGN KEY (id_pregunta) REFERENCES pregunta (id_pregunta) ON DELETE CASCADE
);

-- Creación de la tabla "persona_reunion"
CREATE TABLE persona_reunion (
    id_perso_reu INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_persona INT(10),
    id_reunion INT(10),
    FOREIGN KEY (id_persona) REFERENCES persona (id_persona) ON DELETE CASCADE,
    FOREIGN KEY (id_reunion) REFERENCES reunion (id_reunion) ON DELETE CASCADE
);

-- Creación de la tabla "reunion_lugarreunion"
CREATE TABLE reunion_lugarreunion (
    id_reu_lugarreu INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_lugar_reunion INT(10),
    id_reunion INT(10),
    FOREIGN KEY (id_lugar_reunion) REFERENCES lugar_reunion (id_lugar_reunion) ON DELETE CASCADE,
    FOREIGN KEY (id_reunion) REFERENCES reunion (id_reunion) ON DELETE CASCADE
);

-- Creación de la tabla "item_reunion"
CREATE TABLE item_reunion (
    id_item_reunion INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_item INT(10),
    id_reunion INT(10),
    FOREIGN KEY (id_item) REFERENCES item (id_item) ON DELETE CASCADE,
    FOREIGN KEY (id_reunion) REFERENCES reunion (id_reunion) ON DELETE CASCADE
);

-- Creación de la tabla "propuesta_partido"
CREATE TABLE propuesta_partido (
    id_propuesta_partido INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_propuesta INT(10),
    id_partido INT(10),
    FOREIGN KEY (id_propuesta) REFERENCES propuesta (id_propuesta) ON DELETE CASCADE,
    FOREIGN KEY (id_partido) REFERENCES partido_politico (id_partido) ON DELETE CASCADE
);


--correccion DLL dada por la IA
-- Tabla "persona"
ALTER TABLE persona MODIFY telefono VARCHAR(15); -- Cambio del tipo de dato de INT(10) a VARCHAR(15) para almacenar números de teléfono de diferentes longitudes

-- Tabla "reunion"
ALTER TABLE reunion MODIFY fecha DATE; -- Cambio del tipo de dato de VARCHAR(10) a DATE para almacenar fechas de forma adecuada

-- Tabla "pregunta"
ALTER TABLE pregunta MODIFY descripcion_pregunta TEXT; -- Cambio del tipo de dato de VARCHAR(250) a TEXT para permitir descripciones más extensas

--Insercion de datos

INSERT INTO lugar_procedencia(nombre) VALUES
('Las torres'),
('La yunga'),
('Santa rosa'),
('Piendamo'),
('La vega'),
('El charco'),
('Julumito'),
('Los cerrillos'),
('Las mercedes'),
('Las piedras'),
('San Rafael'),
('La rejoya'),
('Calibio'),
('Poblazon'),
('El canelo');

INSERT INTO persona(id_lugar_procedencia,nombre,telefono,tipo_asistente) VALUES
(2,'Carlos',3218901,'invitado'),
(10,'Andres',123213,'invitado'),
(13,'Juan',53234,'invitado'),
(8,'Antonio',3432412,'invitado'),
(4,'Manuel',9765454,'invitado'),
(15,'Francisco',5325723,'invitado'),
(5,'Fernando',890394057,'invitado'),
(2,'Javier',8623746,'presidente de juntas'),
(3,'Daniel',902364,'lider'),
(2,'Jose',47235123,'dirigente'),
(7,'Luis',3216543,'administrativo'),
(4,'Julio',3290532,'concejal'),
(2,'Maria',326759022,'madre lider'),
(8,'Carmen',329086432,'lider social'),
(6,'Lucia',321823423,'representante grupo etnico');

INSERT INTO partido_politico(nombre,url_logo) VALUES
('Liberal','C:\Users\desktop\logo');

INSERT INTO reunion(id_partido,fecha,tematica,hora,dirigida_por,presupuesto) VALUES
(1,'10/04/2023','presentacion','12:00pm','William',200000),
(1,'30/04/2023','propuestas','12:00pm','Kaleft',250000),
(1,'15/04/2023','debates','1:00pm','William',150000),
(1,'16/04/2023','continuacion de debate','8:00am','William',150000),
(1,'18/04/2023','acuerdos','9:00am','Cristian',200000),
(1,'22/05/2023','continuacion de acuerdos','10:00am','Cristian',150000),
(1,'21/05/2023','introduccion a sonas rurales','7:00am','Juan',200000),
(1,'31/04/2032','solucion de dudas','10:00am','Angie',150000),
(1,'2/04/2023','discurso inspirador','1:00pm','Angie',300000),
(1,'27/04/2023','Encuentro con poblaciones indigenas','1:00pm','Angie',300000),
(1,'25/05/2023','Medidas para contrarrestar los grupos armados','1:00pm','Cristian',300000),
(1,'2/05/2023','Medidas para disminuir el indice de robos','3:00pm','Miguel',300000),
(1,'4/05/2023','Catedra sobre la etica del partido','2:00pm','Miguel',300000),
(1,'4/05/2023','Metodos para mejorar la educacion','2:00pm','Miguel',300000),   
(1,'4/05/2023','Ayudas monetarias para poblaciones vulnerables','2:00pm','Miguel',300000);

INSERT INTO lugar_reunion(nombre) VALUES
('Auditorio principal'),
('Lomas'),
('Paque centra de Santa rosa'),
('Parque central Piendamo'),
('Parque caldas'),
('Estadio regional popayan'),
('Estadio ciro lopez'),
('Los cerrillos'),
('Las mercedes'),
('Las piedras'),
('San Rafael'),
('La rejoya'),
('Calibio'),
('Poblazon'),
('El canelo');

INSERT INTO item(nombre_item) VALUES
('cillas'),
('mesas'),
('equipos de sonido'),
('proyector'),
('camaras'),
('microfonos'),
('portatiles'),
('galletas'),
('tamales'),
('pan'),
('cafe'),
('gaseosas'),
('empanadas'),
('arepas'),
('chocolate');

INSERT INTO propuesta(tema_propuesta,descripcion_propuesta) VALUES
('Reparacion de vias','Realizar mantenimiento a las vias de la ciudad de popayan'),
('Inversiones a la educacion','Realizar mayor inversion en el campo academico de popayan'),
('Incremento de la seguridad','Ubicar mas puntos de vigilancia en popayan para su respectiva seguridad'),
('Mejoras en la infraestrutura de clinicas y hospitales','Se invertira mas en el campo de la salud para su infraestructura'),
('Implementacion de nuevas bibliotecas en zona urbana ','Se construiran nuevas bibliotecas en la ciudad popayan para el publico'),
('Implementacion de nuevas bibliotecas en zona rural ','Se construiran nuevas bibliotecas en las zonas rurares de popayan'),
('Invertira en material educativo infantil','Niños tendran acceso a el material'),
('Implementacion del acceso a internet en lugares publicos de la zona rurales','Se ubicaran puntos de acceso a internet en zonas publicas rurales'),
('Implementacion del acceso a internet en lugares publicos de la zona urbana','Se ubicaran puntos de acceso a internet en zonas publicas de la ciudad de popayan'),
('Inversión en suministros agrícolas ','Apoyar a los campesinos con suministros como abonos, semillas entre otros'),
('Construcción de polideportivos ','Creación de escenarios deportivos'),
('Fomentar la actividad física ','Hacer jornadas de deporte en escenarios deportivos'),
('Jornadas de cuidado animal, jornadas de vacunacion, esterilizacion etc ','Se implemenetara jornadas para el cuidado delas mascotas'),
('Inversión en limpieza ','Mejorar el servicio de limpieza en la zona rural y urbana'),
('Incrementar el indice de empleo','Realizar mas proyectos de empleo para disminuir el desempleo');

INSERT INTO pregunta(id_propuesta,descripcion_pregunta) VALUES
(1,'Esta de acuerdo?'),
(2,'Esta de acuerdo?'),
(3,'Esta de acuerdo?'),
(4,'Esta de acuerdo?'),
(5,'Esta de acuerdo?'),
(6,'Esta de acuerdo?'),
(7,'Esta de acuerdo?'),
(8,'Esta de acuerdo?'),
(9,'Esta de acuerdo?'),
(10,'Esta de acuerdo?'),
(11,'Esta de acuerdo?'),
(12,'Esta de acuerdo?'),
(13,'Esta de acuerdo?'),
(14,'Esta de acuerdo?'),
(15,'Esta de acuerdo?');

INSERT INTO persona_pregunta(id_persona,id_pregunta,respuesta ) VALUES
(1,1,'si esta de acuerdo, pero desea mas vias para arreglar'),
(2,2,'si esta de acuerdo'),
(3,3,'no esta de acuerdo'),
(4,4,'no esta de acuerdo'),
(5,5,'si esta de acuerdo'),
(6,6,'si esta de acuerdo'),
(7,7,'no esta de acuerdo'),
(8,8,'si esta de acuerdo'),
(9,9,'no esta de acuerdo'),
(10,10,'no esta de acuerdo'),
(11,12,'no esta de acuerdo'),
(12,12,'si esta de acuerdo'),
(13,13,'si esta de acuerdo'),
(14,14,'no esta de acuerdo'),
(15,15,'si esta de acuerdo');

INSERT INTO persona_reunion(id_persona,id_reunion ) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,2),
(8,2),
(9,2),
(10,3),
(11,3),
(12,3),
(13,3),
(14,3),
(15,5),
(1,5),
(2,5),
(3,5),
(4,5),
(5,4),
(6,4),
(7,4),
(8,4),
(9,6),
(10,7),
(11,7),
(12,8),
(13,8),
(14,9),
(15,9),
(1,10),
(2,10),
(3,10),
(4,10),
(5,11),
(6,11),
(7,11),
(8,11),
(9,12),
(10,12),
(11,12),
(12,12),
(13,13),
(14,13),
(15,14);

INSERT INTO reunion_lugarreunion(id_reunion,id_lugar_reunion ) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,12),
(11,14),
(12,10),
(13,2),
(14,4),
(15,9);
INSERT INTO item_reunion(id_reunion,id_item ) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(1,2),
(2,2),
(3,2),
(4,2),
(5,2),
(6,2),
(7,2),
(8,2),
(9,2),
(1,3),
(2,3),
(3,3),
(4,3),
(5,3),
(6,3),
(7,3),
(8,3),
(9,3),
(1,4),
(2,4),
(3,4),
(4,4),
(5,4),
(6,4),
(7,4),
(8,4),
(9,4),
(1,5),
(2,5),
(3,5),
(4,5),
(5,5),
(6,5),
(7,5),
(8,5),
(9,5),
(1,6),
(2,6),
(3,6),
(4,6),
(5,6),
(6,6),
(7,6),
(8,6),
(9,6),
(1,7),
(2,7),
(3,7),
(4,7),
(5,7),
(6,7),
(7,7),
(8,7),
(9,7),
(1,10),
(2,10),
(3,10),
(4,10),
(5,10),
(6,10),
(7,10),
(8,10),
(9,10),
(1,11),
(2,11),
(3,11),
(4,11),
(5,11),
(6,11),
(7,11),
(8,11),
(9,11);

INSERT INTO propuesta_partido(id_propuesta,id_partido ) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1);

--Actualizacion de datos 

UPDATE lugar_procedencia SET nombre = 'Timbio' WHERE id_lugar_procedencia = 1;
UPDATE lugar_procedencia SET nombre = 'La vega' WHERE id_lugar_procedencia = 2;
UPDATE lugar_procedencia SET nombre = 'La yunga' WHERE id_lugar_procedencia = 3;
UPDATE lugar_procedencia SET nombre = 'Las torres' WHERE id_lugar_procedencia = 4;
UPDATE lugar_procedencia SET nombre = 'Santa rosa' WHERE id_lugar_procedencia = 5;

UPDATE persona SET nombre = 'andres' WHERE id_persona = 1;
UPDATE persona SET nombre = 'fabian' WHERE id_persona = 2;
UPDATE persona SET nombre = 'pablo' WHERE  id_persona = 3;
UPDATE persona SET nombre = 'victor' WHERE id_persona = 4;
UPDATE persona SET nombre = 'camilo' WHERE id_persona = 5;

UPDATE partido_politico SET nombre ='conservador' WHERE id_partido = 1;

UPDATE reunion SET fecha = '11/04/2023' WHERE id_reunion = 1;
UPDATE reunion SET fecha = '31/04/2023' WHERE id_reunion = 2;
UPDATE reunion SET fecha = '24/04/2023' WHERE id_reunion = 3;
UPDATE reunion SET fecha = '02/04/2023' WHERE id_reunion = 4;
UPDATE reunion SET fecha = '07/04/2023' WHERE id_reunion = 5;


UPDATE lugar_reunion SET nombre ='Lomas' WHERE id_lugar_reunion = 1;
UPDATE lugar_reunion SET nombre ='Parque caldas' WHERE id_lugar_reunion = 2;
UPDATE lugar_reunion SET nombre ='La rejoya' WHERE id_lugar_reunion = 3;
UPDATE lugar_reunion SET nombre ='Moscopan' WHERE id_lugar_reunion = 4;
UPDATE lugar_reunion SET nombre = 'El empedrado' WHERE id_lugar_reunion = 5;

UPDATE item SET nombre_item ='Agua de panela' WHERE id_item = 1;
UPDATE item SET nombre_item ='Mazamorra' WHERE id_item = 2;
UPDATE item SET nombre_item ='mesas' WHERE id_item = 3;
UPDATE item SET nombre_item ='Equipos de sonido' WHERE id_item = 4;
UPDATE item SET nombre_item ='camaras' WHERE id_item = 5;

UPDATE propuesta SET descripcion_propuesta ='mantenimiento de vias' WHERE id_propuesta = 1;
UPDATE propuesta SET descripcion_propuesta ='mayor inversion en campo academico' WHERE id_propuesta = 2;
UPDATE propuesta SET descripcion_propuesta ='Ubicar mas puntos de vigilancia en popayan' WHERE id_propuesta = 3;
UPDATE propuesta SET descripcion_propuesta  ='mas inversion en campo de salud' WHERE id_propuesta = 4;
UPDATE propuesta SET descripcion_propuesta ='construccion de nuevas bibliotecas' WHERE id_propuesta = 5;

UPDATE pregunta SET id_propuesta = 1 WHERE id_pregunta = 1;
UPDATE pregunta SET id_propuesta = 2 WHERE id_pregunta = 2;
UPDATE pregunta SET id_propuesta = 5 WHERE id_pregunta = 3;
UPDATE pregunta SET id_propuesta = 3 WHERE id_pregunta = 4;
UPDATE pregunta SET id_propuesta = 4 WHERE id_pregunta = 5;

--consultas 

-- Todos los ítems para las reuniones.
SELECT * FROM item;

-- Los lugares de procedencia de los asistentes.
SELECT * FROM lugar_procedencia;

-- Todos los lugares de reuniones.
SELECT * FROM lugar_reunion;

-- Partidos políticos como ejemplo.
SELECT * FROM partido_politico;

-- Todas las reuniones.
SELECT * FROM reunion;

-- Todos los nombres de las personas.
SELECT nombre FROM persona;

-- Reuniones con el mayor presupuesto.
SELECT * FROM reunion ORDER BY presupuesto DESC LIMIT 1;

-- Reuniones con el menor presupuesto.
SELECT * FROM reunion ORDER BY presupuesto ASC LIMIT 1;

-- Reuniones que tengan que ver con debates.
SELECT * FROM reunion WHERE tematica LIKE '%debate%';

-- Nombres de las personas que empiezan con "a".
SELECT nombre FROM persona WHERE nombre LIKE 'a%';

-- Nombres de las personas que terminan con "o".
SELECT nombre FROM persona WHERE nombre LIKE '%o';

-- Personas cuyo número de celular inicie con "321".
SELECT * FROM persona WHERE telefono LIKE '321%';

-- Personas cuyo número de teléfono termine en "3".
SELECT * FROM persona WHERE telefono LIKE '%3';

-- Personas que son de tipo "invitado" a las reuniones.
SELECT * FROM persona WHERE tipo_asistente = 'invitado';

-- Personas que no son de tipo "invitado" a las reuniones.
SELECT * FROM persona WHERE tipo_asistente != 'invitado';

-- Personas cuyo número de teléfono inicie con "321" y su nombre termine con "a".
SELECT * FROM persona WHERE telefono LIKE '321%' AND nombre LIKE '%a';

-- Personas cuyo número de teléfono termine en "3" y su nombre empiece con "a".
SELECT * FROM persona WHERE telefono LIKE '%3' AND nombre LIKE 'a%';

-- Ítems que terminan con la letra "s".
SELECT * FROM item WHERE nombre_item LIKE '%s';

-- Ítems que empiezan con la letra "c".
SELECT * FROM item WHERE nombre_item LIKE 'c%';

-- Listado de las personas y su lugar de procedencia.
SELECT p.id_persona, p.nombre, lp.id_lugar_procedencia, lp.nombre AS lugar_procedencia
FROM persona p
INNER JOIN lugar_procedencia lp
ON p.id_lugar_procedencia = lp.id_lugar_procedencia;

-- Personas que provienen de "La yunga".
SELECT p.id_persona, p.nombre, lp.id_lugar_procedencia, lp.nombre AS lugar_procedencia
FROM persona p
INNER JOIN lugar_procedencia lp
ON p.id_lugar_procedencia = lp.id_lugar_procedencia
WHERE lp.nombre = 'La yunga';

-- Personas que no provienen de "La yunga".
SELECT p.id_persona, p.nombre, lp.id_lugar_procedencia, lp.nombre AS lugar_procedencia
FROM persona p
INNER JOIN lugar_procedencia lp
ON p.id_lugar_procedencia = lp.id_lugar_procedencia
WHERE lp.nombre != 'La yunga';

-- Ítems usados en la reunión de "presentacion".
SELECT i.id_item, i.nombre_item, r.id_reunion, r.tematica
FROM item i
JOIN item_reunion ir
ON i.id_item = ir.id_item
JOIN reunion r
ON ir.id_reunion = r.id_reunion
WHERE r.tematica = 'presentacion';

-- Número de ítems usados en la reunión de "presentacion".
SELECT COUNT(*) AS numero_items, r.tematica
FROM item i
JOIN item_reunion ir
ON i.id_item = ir.id_item
JOIN reunion r
ON ir.id_reunion = r.id_reunion
WHERE r.tematica = 'presentacion';

-- Listado de asistentes en la reunión "debates".
SELECT p.id_persona, p.nombre, r.id_reunion, r.tematica
FROM persona p
JOIN persona_reunion pr
ON p.id_persona = pr.id_persona
JOIN reunion r
ON pr.id_reunion = r.id_reunion
WHERE r.tematica = 'debates';

-- Número de asistentes en la reunión "debates".
SELECT COUNT(*) AS numero_personas
FROM persona p
JOIN persona_reunion pr
ON p.id_persona = pr.id_persona
JOIN reunion r
ON pr.id_reunion = r.id_reunion
WHERE r.tematica = 'debates';

-- Reuniones que se hicieron en el lugar "lomas".
SELECT r.id_reunion, r.tematica, lr.id_lugar_reunion, lr.nombre
FROM reunion r
JOIN reunion_lugarreunion rl
ON r.id_reunion = rl.id_reunion
JOIN lugar_reunion lr
ON rl.id_lugar_reunion = lr.id_lugar_reunion
WHERE lr.nombre = 'lomas';

-- Número de reuniones que se hicieron en el lugar "lomas".
SELECT COUNT(*) AS numero_reuniones, r.tematica
FROM reunion r
JOIN reunion_lugarreunion rl
ON r.id_reunion = rl.id_reunion
JOIN lugar_reunion lr
ON rl.id_lugar_reunion = lr.id_lugar_reunion
WHERE lr.nombre = 'lomas';

-- Número de asistentes en todas las reuniones.
SELECT COUNT(*) AS numero_asistentes
FROM persona p
JOIN persona_reunion pr
ON p.id_persona = pr.id_persona
JOIN reunion r
ON pr.id_reunion = r.id_reunion;

-- Personas que asistieron a la reunión "lomas" y el lugar donde se realizó la reunión.
SELECT lr.nombre AS lugar_reunion, r.tematica, p.nombre
FROM reunion r
JOIN persona_reunion pr
ON r.id_reunion = pr.id_reunion
JOIN persona p
ON pr.id_persona = p.id_persona
JOIN reunion_lugarreunion rl
ON r.id_reunion = rl.id_reunion
JOIN lugar_reunion lr
ON rl.id_lugar_reunion = lr.id_lugar_reunion
WHERE lr.nombre = 'lomas';

-- Pregunta de la propuesta y la persona que la respondió y su respuesta.
SELECT p.tema_propuesta, pg.descripcion_pregunta, pe.nombre, pp.respuesta
FROM pregunta pg
JOIN propuesta p
ON p.id_propuesta = pg.id_propuesta
JOIN persona_pregunta pp
ON pp.id_pregunta = pg.id_pregunta
JOIN persona pe
ON pp.id_persona = pe.id_persona;

-- Lugares que no tienen una reunión establecida.
SELECT lr.*
FROM lugar_reunion lr
LEFT JOIN reunion_lugarreunion rl
ON lr.id_lugar_reunion = rl.id_lugar_reunion
WHERE rl.id_reunion IS NULL;
