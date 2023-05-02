--Creacion de tablas
CREATE TABLE lugar_procedencia(
	id_lugar_procedencia INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50)
);

CREATE TABLE persona(
	id_persona INT(10)PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_lugar_procedencia INT(10),
    nombre VARCHAR(50),
    telefono INT(10),
    tipo_asistente VARCHAR(10),
    FOREIGN KEY(id_lugar_procedencia) REFERENCES lugar_procedencia(id_lugar_procedencia) ON DELETE CASCADE
);

CREATE TABLE partido_politico(
	id_partido INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
   	nombre VARCHAR(50),
    url_logo VARCHAR(50)
);

CREATE TABLE reunion(
	id_reunion INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_partido INT(10),
    fecha VARCHAR(10),
    tematica VARCHAR(50),
    hora VARCHAR(10),
    dirigida_por VARCHAR(50),
    presupuesto INT(10),
    FOREIGN KEY (id_partido) REFERENCES partido_politico(id_partido)
);

CREATE TABLE lugar_reunion(
	id_lugar_reunion INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50)
);

CREATE TABLE item(
	id_item INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre_item VARCHAR(50)   
);

CREATE TABLE propuesta(
	id_propuesta INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tema_propuesta VARCHAR(500),
    descripcion_propuesta VARCHAR(500)
);

CREATE TABLE pregunta(
	id_pregunta INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_propuesta INT(10),
    descripcion_pregunta VARCHAR(250),
    FOREIGN KEY (id_propuesta) REFERENCES propuesta(id_propuesta) ON DELETE CASCADE
);

CREATE TABLE persona_pregunta(
	id_perso_pregun INT(10)PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_persona INT(10),
    id_pregunta	INT(10),
    respuesta VARCHAR(50),
    FOREIGN KEY(id_persona) REFERENCES persona(id_persona) ON DELETE CASCADE,
    FOREIGN KEY(id_pregunta) REFERENCES pregunta(id_pregunta) ON DELETE CASCADE
);

CREATE TABLE persona_reunion(
	id_perso_reu INT(10)PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_persona INT(10),
    id_reunion	INT(10),
    FOREIGN KEY(id_persona) REFERENCES persona(id_persona) ON DELETE CASCADE,
    FOREIGN KEY(id_reunion) REFERENCES reunion(id_reunion) ON DELETE CASCADE
);

CREATE TABLE reunion_lugarreunion(
	id_reu_lugarreu INT(10)PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_lugar_reunion INT(10),
    id_reunion	INT(10),
    FOREIGN KEY(id_lugar_reunion) REFERENCES lugar_reunion(id_lugar_reunion) ON DELETE CASCADE,
    FOREIGN KEY(id_reunion) REFERENCES reunion(id_reunion) ON DELETE CASCADE
);

CREATE TABLE item_reunion(
	id_item_reunion INT(10)PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_item INT(10),
    id_reunion	INT(10),
    FOREIGN KEY(id_item) REFERENCES item(id_item) ON DELETE CASCADE,
    FOREIGN KEY(id_reunion) REFERENCES reunion(id_reunion) ON DELETE CASCADE
);

CREATE TABLE propuesta_partido(
	id_propuesta_partido INT(10)PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_propuesta INT(10),
    id_partido	INT(10),
    FOREIGN KEY(id_propuesta) REFERENCES propuesta(id_propuesta) ON DELETE CASCADE,
    FOREIGN KEY(id_partido) REFERENCES partido_politico(id_partido) ON DELETE CASCADE
);
