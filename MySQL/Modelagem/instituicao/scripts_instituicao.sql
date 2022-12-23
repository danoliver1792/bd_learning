/* Vamos criar um banco de dados chamado instituição para a aula 60 - Procedures com Query
do curso do Mafra */

SHOW DATABASES;

CREATE DATABASE instituicao;

USE instituicao;

CREATE TABLE cursos(
	idCurso INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30) NOT NULL,
	horas INT(3) NOT NULL,
	valor FLOAT(10, 2) NOT NULL
);

SHOW TABLES;

-- 
INSERT INTO cursos VALUES (NULL, 'Java', 30, 500.00);
INSERT INTO cursos VALUES (NULL, 'Fundamentos de Banco de Dados', 40, 700.00);

SELECT * FROM cursos;

-- vamos fazer duas procedures: uma para cadastrar e outra para ler os dados --
DELIMITER #

STATUS

CREATE PROCEDURE cadCurso(p_nome VARCHAR(30), p_horas INT, p_valor FLOAT(10, 2))
BEGIN
	INSERT INTO cursos VALUES (NULL, p_nome, p_horas, p_valor);
END
#

DELIMITER ;

CALL cadCurso('MySQL', 35, 250.00);
CALL cadCurso('Power BI', 10, 85.00);
CALL cadCurso('Tableau', 15, 70.00);

SELECT * FROM cursos;
