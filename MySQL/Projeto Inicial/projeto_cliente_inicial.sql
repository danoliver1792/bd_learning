/* Modelagem Basica - 
ENTIDADE = TABELA 
CAMPOS = ATRIBUTOS
*/

CLIENTE

NOME - CARACTER(30)
CPF - NUMERIC(11)
EMAIL - CARACTER(30)
TELEFONE - CARACTER(30)
ENDERECO - CARACTER(100)
SEXO - CARACTER(1)

/* PROCESSOS DE MODELAGEM */

/* TEMOS TRES FASES: MODELAGEM CONCEITUAL, MODELAGEM LOGICA E MODELAGEM FISICA */

/* FASE 01 E FASE 02 - QUEM FAZ E O AD OU ADM DE DADOS */
MODELAGEM CONCEITUAL - RASCUNHO
MODELAGEM LOGICA - QUALQUER PROGRAMA DE MODELAGEM

/* FASE 03 - DBA OU AD */
MODELAGEM FISICA - SCRIPTS DE BANCO

/* INICIANDO A MODELAGEM FISICA */

/* CRIANDO O BANCO DE DADOS */

CREATE DATABASE PROJETO;

/* CONECTANDO-SE AO BANCO DE DADOS */
USE PROJETO;

/* CRIANDO A TABELA CLIENTE */
CREATE TABLE CLIENTE(
	NOME VARCHAR(30),
	SEXO CHAR(1),
	EMAIL VARCHAR(30),
	CPF INT(11),
	TELEFONE VARCHAR(30),
	ENDERECO VARCHAR(100)
);

/* VERIFICANDO AS TABELAS DO BANCO */
SHOW TABLES;

/* DESCOBRINDO COMO E A ESTRUTURA DE UMA TABELA */
DESC CLIENTE;

/* FORMA DE INSERIR DADOS OMITINDO COLUNAS */
INSERT INTO CLIENTE VALUES ('JOAO', 'M' 'JOAO@GMAIL.COM', 988638273, '22923110', 'MAIA LACERDA - ESTACIO - RIO DE JANEIRO - RJ');

INSERT INTO CLIENTE VALUES ('CELIA', 'F', 'CELIA@GMAIL.COM', 541521556, '25078869', 'RIACHUELO - CENTRO - RIO DE JANEIRO - RJ');

INSERT INTO CLIENTE VALUES ('JORGE', 'M', NULL, 885755896, '58748895', 'OSCAR CURY - BOM RETIRO - PATOS DE MINAS - MG');

/* FORMA DE INSERIR DADOS COLOCANDO AS COLUNAS */
INSERT INTO CLIENTE (NOME, SEXO, ENDERECO, TELEFONE, CPF) VALUES ('LILIAN', 'F', 'SENADOR SOARES - TIJUCA - RIO DE JANEIRO - RJ',
'947785693', 887774856);

/* FORMA DE INSERIR DADOS COMPACTO */
INSERT INTO CLIENTE VALUES ('ANA', 'F', 'ANA@GLOBO.COM', 85548962, '548556985', 'PRES ANTONIO CARLOS - CENTRO - SAO PAULO - SP'),
('CARLA', 'F', 'CARLA@TERATI.COM', 7745828, '66587458', 'SAMUEL SILVA - CENTRO - BELO HORIZONTE - MG');

/* O COMANDO SELECT */
SELECT NOW() AS DATA_HORA; /* MOSTRA DATA E HORA */
SELECT 'BANCO DE DADOS'; /* MOSTRA 'BANCO DE DADOS' */

/* ALIAS DE COLUNAS */
SELECT NOME AS CLIENTE, SEXO, EMAIL FROM CLIENTE;

SELECT NOME, SEXO, EMAIL, ENDERECO FROM CLIENTE;

SELECT EMAIL, SEXO, ENDERECO, NOME FROM CLIENTE;

/* PARA FINS ACADEMICOS */
SELECT * FROM CLIENTE; /* FULL SCAN */

/* MISTURANDO */
SELECT EMAIL, SEXO, ENDERECO, NOME, NOW() AS DATA_HORA FROM CLIENTE;

/* FILTRANDO DADOS COM WHERE E LIKE */
SELECT NOME, SEXO FROM CLIENTE WHERE SEXO = 'F';

/* EMPTY SET -> SET DE DADOS VAZIO */
SELECT NOME, SEXO FROM CLIENTE WHERE = 'RJ'; 
/* NESSE CASO, PODEMOS USAR O LIKE QUE SUBSTITUI O IGUAL */
SELECT NOME, SEXO FROM CLIENTE WHERE ENDERECO LIKE '%RJ';

SELECT NOME, SEXO ENDERECO FROM CLIENTE WHERE ENDERECO LIKE '%OSCAR CURY%';

/* FILTRANDO TODOS OS BAIRROS CENTRO */
SELECT NOME, SEXO, ENDERECO FROM CLIENTE WHERE ENDERECO LIKE = '%CENTRO%';

/* Para trazer valores nulo */
SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE EMAIL IS NULL;

/* Para trazer valores não nulos */
SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE EMAIL IS NOT NULL;

/* Para atualizar os registros que já estão na tabela */
UPDATE CLIENTE
SET EMAIL = 'LILIAN@HOTMAIL.COM'
WHERE NOME = 'LILIAN';

/* Usando DELETE */
DELETE FROM CLIENTE
WHERE NOME = 'ANA';

DELETE FROM CLIENTE
WHERE NOME = 'CARLA'
AND EMAIL = 'CARLACLOPES@GMAIL.COM';

/* Módulo de modelagem */
UPDATE cliente
SET TELEFONE = '97865434'
WHERE NOME = 'JOAO';

SELECT SEXO, COUNT(*) AS QTD
FROM CLIENTE
GROUP BY SEXO;
 

