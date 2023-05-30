--Triggers

--Triggers para la tabla item 
--Disparador que valida si el nombre del item ya existe en los items ingresados
DELIMITER //
CREATE TRIGGER verificarnombre BEFORE INSERT ON item
IF EXISTS(SELECT 1 FROM item WHERE nombre = NEW.nombre) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error:El item ingresado ya existe';
END IF;//
--Disparador que valida que el nombre no sea vacio al momento de actualizar 
DELIMITER //
CREATE TRIGGER verificarupdate BEFORE UPDATE ON item
FOR EACH ROW IF NEW.nombre_item='' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error: El campo "nombre" del item no puede ser vacio';
END IF;//
--No permitir el ingreso del item denominado como "armas" al momento de insertar
DELIMITER //
CREATE TRIGGER nombrenopermitido BEFORE INSERT ON item
FOR EACH ROW IF NEW.nombre_item LIKE '%Armas%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El item "armas" no es permitido ingresar';
END IF;//

--Disparadores para la tabla reunion
--Disparador que coloca el presupuesto en 0 si este es un numero negativo al momento de ingresar
DELIMITER //
CREATE TRIGGER verificarpresupuesto BEFORE INSERT ON reunion
FOR EACH ROW IF NEW.presupuesto < 0 
THEN SET NEW.presupuesto = 0;
END IF;//
--Verificar que el campo tematica tenga por lo menos 10 caracteres al momento de insertar
DELIMITER //
CREATE TRIGGER verificarcaracteres2 BEFORE INSERT ON reunion
FOR EACH ROW IF LENGTH(NEW.tematica)<10 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error: El campo "tematica" tiene que tener por lo menos 10 caracteres';
END IF;//
--Disparador que valida que el dirigente de la reunion no sea vacio al momento de ingresar
DELIMITER //
CREATE TRIGGER verificardirigente BEFORE INSERT ON reunion	
FOR EACH ROW IF NEW.dirigida_por='' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error: Tiene que haber un dirigente para la reunion';
END IF;//

--Disparadores para la tabla persona 
--Verificar que numero de telefono tenga por lo menos 10 caracteres al momento de ingresar
DELIMITER //
CREATE TRIGGER verificartelefono BEFORE INSERT ON persona
FOR EACH ROW IF LENGTH(NEW.telefono)<10 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error: El campo "telefono" tiene que tener por lo menos 10 caracteres';
END IF;//
--Verificar que el nombre de la persona no sea vacia al momento de insertar
DELIMITER //
CREATE TRIGGER verificarname BEFORE INSERT ON persona
FOR EACH ROW IF NEW.Nombre='' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error: El campo "Nombre" de la persona no puede ser vacio';
END IF;//
--Disparador que coloca la primer letra del nombre en mayuscula y el resto en minuscula al momento de insertar
DELIMITER //
CREATE TRIGGER PrimeraMayus BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
    SET NEW.nombre = CONCAT(UPPER(LEFT(NEW.nombre, 1)), LOWER(SUBSTRING(NEW.nombre, 2)));
END;//

--Trigger de la tabla persona_pregunta
--Validar que la respuesta no tenga menos de 5 caracteres
DELIMITER //
CREATE TRIGGER validar_pregunta_pocos_caracteres
BEFORE INSERT ON persona_pregunta
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.respuesta) < 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El campo "respuesta" no puede tener menos de 5 caracteres';
    END IF;
END;//
--Validar que la respuesta no este vacia
DELIMITER //
CREATE TRIGGER validar_pregunta_vacia
BEFORE UPDATE ON persona_pregunta
FOR EACH ROW
BEGIN
    IF NEW.respuesta = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El campo "respuesta" no puede estar vacio';
    END IF;
END;//
--Validar que no hayan numeros en la respuesta
DELIMITER //
CREATE TRIGGER validar_pregunta_sin_numeros
BEFORE UPDATE ON persona_pregunta
FOR EACH ROW
BEGIN
    IF NEW.respuesta REGEXP '^[0-9]+$' THEN
        SIGNAL SQLSTATE '45000'
        	SET MESSAGE_TEXT = 'No se pueden ingresar números en el campo "respuesta"';
    END IF;
END;//

--Trigger de la tabla propuesta
--no puede haber espacios en blanco en la propuesta
DELIMITER //
CREATE TRIGGER verificar_tema_propuesta
BEFORE INSERT ON propuesta
FOR EACH ROW
BEGIN
  IF LENGTH(NEW.tema_propuesta) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No puede dejar campos vacíos en el tema de la propuesta.';
  END IF;
END//
--al menos 4 caracteres para el tema de la propuesta
DELIMITER //
CREATE TRIGGER verificar_tema_propuesta_largo_4_caracteres
BEFORE INSERT ON propuesta
FOR EACH ROW
BEGIN
  IF LENGTH(NEW.tema_propuesta) < 4 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: el tema de la propuesta debe tener al menos 4 caracteres';
  END IF;
END//
--el tema de la propuesta debe empezar con mayusculas
DELIMITER //
CREATE TRIGGER empezar_mayuscula BEFORE INSERT ON propuesta
FOR EACH ROW
BEGIN
  IF NOT(NEW.tema_propuesta REGEXP BINARY '[[:upper:]]') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El tema de la propuesta debe comenzar con mayúscula.';
  END IF;
END//

--Trigger de la tabla de lugar procedencia
--no se admiten caracteres especiales en el lugar de la procedencia
DELIMITER //
CREATE TRIGGER verificar_caracteres_especiales BEFORE INSERT ON lugar_procedencia
FOR EACH ROW
BEGIN
  IF NEW.nombre REGEXP '[^a-zA-Z0-9 ]' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: el nombre de la procedencia no puede contener caracteres especiales.';
  END IF;
END//
--no se permite repetir nombre de lugar de procedencia
DELIMITER //
CREATE TRIGGER evitar_nombres_duplicados 
BEFORE INSERT ON lugar_procedencia
FOR EACH ROW
BEGIN
  IF EXISTS(SELECT 1 FROM lugar_procedencia WHERE nombre = NEW.nombre) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El nombre del lugar de procedencia ya existe en la tabla.';
  END IF;
END
--no se permite repetir la id si se quiere ingresar de forma manual
DELIMITER //
CREATE TRIGGER evitar_id_duplicados 
BEFORE INSERT ON lugar_procedencia
FOR EACH ROW
BEGIN
  IF EXISTS(SELECT 1 FROM lugar_procedencia WHERE id_lugar_procedencia = NEW.id_lugar_procedencia) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El id del lugar de procedencia ya existe en la tabla.';
  END IF;
END

--Triggers de la tabla lugar reunion
--no se permite numeros en lugar_Reunion
DELIMITER //
CREATE TRIGGER verificar_numeros BEFORE INSERT ON lugar_reunion
FOR EACH ROW
BEGIN
  IF NEW.nombre REGEXP '[0-9 ]' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: el lugar de la reunión no puede contener numeros.';
  END IF;
END//
--el lugar de la reunión debe empezar en mayusculas
DELIMITER //
CREATE TRIGGER empezar_mayuscula_lugar_reunion BEFORE INSERT ON lugar_reunion
FOR EACH ROW
BEGIN
  IF NOT(NEW.nombre REGEXP BINARY '[[:upper:]]') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El lugar de la reunion debe comenzar con mayúscula.';
  END IF;
END//
--el id del lugar de la reunion no puede ser 0
DELIMITER //
CREATE TRIGGER evitar_ID_0
BEFORE INSERT ON lugar_reunion
FOR EACH ROW
BEGIN
IF NEW.id_lugar_reunion <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID no puede ser 0';
  END IF;
END;

--Disparadores para tabla de pregunta
--Disparador que impide colocar una descripcion de pregunta vacia 
DELIMITER //
CREATE TRIGGER campo_vacio BEFORE INSERT ON pregunta
FOR EACH ROW 
BEGIN
  IF NEW.descricion_pregunta = "" THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La descripción de la pregunta no puede estar vacia';
  END IF;
--Disparador que verifica la cantidad de caracteres para la descripcion de la pregunta 
END//
DELIMITER //
CREATE TRIGGER verificar_descripcion BEFORE INSERT ON pregunta
FOR EACH ROW IF LENGTH(NEW.descricion_pregunta)<10 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Error: El campo "descripcion_pregunta" tiene que tener por lo menos 10 caracteres';
END IF;//
--Colocar los signos de pregunta en caso de que no esten
DELIMITER //
CREATE TRIGGER agregar_signos BEFORE INSERT ON pregunta
FOR EACH ROW
BEGIN
    BEGIN
    IF NEW.descricion_pregunta NOT LIKE '¿%' AND NEW.descricion_pregunta NOT LIKE '%?' THEN
        SET NEW.descricion_pregunta = CONCAT('¿', NEW.descricion_pregunta, '?');
    ELSEIF NEW.descricion_pregunta NOT LIKE '¿%' THEN
        SET NEW.descricion_pregunta = CONCAT('¿', NEW.descricion_pregunta);
    ELSEIF NEW.descricion_pregunta NOT LIKE '%?' THEN
        SET NEW.descricion_pregunta = CONCAT(NEW.descricion_pregunta,'?');
    END IF;
END //
DELIMITER;