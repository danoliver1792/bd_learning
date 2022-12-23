CREATE DATABASE comercio;

USE comercio;

CREATE TABLE cliente(
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30) NOT NULL,
	sexo ENUM('M', 'F') NOT NULL,
	email VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
	rua VARCHAR(30) NOT NULL,
	bairro VARCHAR(30) NOT NULL,
	cidade VARCHAR(30) NOT NULL,
	estado CHAR(2) NOT NULL,
	id_Cliente INT UNIQUE, -- ESSE UNIQUE VAI DEFINIR O RELACIONAMENTO 1X1 --
	FOREIGN KEY (id_Cliente)
	REFERENCES cliente(idCliente)
);

CREATE TABLE telefone(
	idTelefone INT PRIMARY KEY AUTO_INCREMENT,
	tipo ENUM('RES', 'COM', 'CEL') NOT NULL,
	numero VARCHAR(10) NOT NULL,
	id_Cliente INT,
	FOREIGN KEY (id_Cliente)
	REFERENCES cliente(idCliente)
);

DESC cliente;

INSERT INTO cliente VALUES (NULL, 'JOAO', 'M', '76567878878'); -- VAI DAR ERRO, PORQUE O CONTADOR DE COLUNA NÃO BATE (TEM QUE COLOCAR EMAIL)--

INSERT INTO cliente VALUES (NULL, 'CARLOS', 'M', 'CARLOS@IG.COM', '56234495365');

INSERT INTO cliente VALUES (NULL, 'ANA', 'F', 'ANA@IG.COM', '23465952289');

INSERT INTO cliente VALUES (NULL, 'CLARA', 'F', NULL, '79423564119');

INSERT INTO cliente VALUES (NULL, 'JORGE', 'M', 'JORGE@IG.COM', '99600012538');

INSERT INTO cliente VALUES (NULL, 'CELIA', 'F', 'CELIA@IG.COM', '05561235598');

SELECT * FROM cliente;

+-----------+--------+------+---------------+-------------+
| idCliente | nome   | sexo | email         | CPF         |
+-----------+--------+------+---------------+-------------+
|         1 | JOAO   | M    | JOAO@IG.COM   | 7656787887  |
|         2 | CARLOS | M    | CARLOS@IG.COM | 56234495365 |
|         3 | ANA    | F    | ANA@IG.COM    | 23465952289 |
|         4 | CLARA  | F    | NULL          | 79423564119 |
|         5 | JORGE  | M    | JORGE@IG.COM  | 99600012538 |
|         6 | CELIA  | F    | CELIA@IG.COM  | 05561235598 |
+-----------+--------+------+---------------+-------------+

DESC endereco;

-- SE COLOCAR ASSIM (ABAIXO) VAI DAR ERRO PORQUE NÃO TEM UMA REFERÊNCIA CORRETA (O ID 45) --
INSERT INTO endereco VALUES (NULL, 'RUA ANTONIO SA', 'CENTRO', 'BELO HORIZONTE', 'MG', 45); 

INSERT INTO endereco VALUES (NULL, 'RUA ANTONIO SA', 'CENTRO', 'BELO HORIZONTE', 'MG', 4);
-- SE EU COLOCAR O PRIMEIRO DADO VAI DAR ERRO, COLOCANDO O DADO ACIMA, VAI INICIAR A PARTIR DO 2 --

INSERT INTO endereco VALUES (NULL, 'RUA CAPITAO HERMES', 'CENTRO', 'RIO DE JANEIRO', 'RJ', 1);

INSERT INTO endereco VALUES (NULL, 'RUA PRESIDENTE VARGAS', 'JARDINS', 'SAO PAULO', 'SP', 3);

INSERT INTO endereco VALUES (NULL, 'RUA ALFANDEGA', 'ESTACIO', 'RIO DE JANEIRO', 'RJ', 2);

INSERT INTO endereco VALUES (NULL, 'RUA DO OUVIDOR', 'FLAMENGO', 'RIO DE JANEIRO', 'MG', 6);

INSERT INTO endereco VALUES (NULL, 'RUA URUGUAIANA', 'CENTRO', 'VITORIA', 'ES', 5);

SELECT * FROM endereco;

+------------+-----------------------+----------+----------------+--------+------------+
| idEndereco | rua                   | bairro   | cidade         | estado | id_Cliente |
+------------+-----------------------+----------+----------------+--------+------------+
|          1 | RUA ANTONIO SA        | CENTRO   | BELO HORIZONTE | MG     |          4 |
|          2 | RUA CAPITAO HERMES    | CENTRO   | RIO DE JANEIRO | RJ     |          1 |
|          3 | RUA PRESIDENTE VARGAS | JARDINS  | SAO PAULO      | SP     |          3 |
|          4 | RUA ALFANDEGA         | ESTACIO  | RIO DE JANEIRO | RJ     |          2 |
|          5 | RUA DO OUVIDOR        | FLAMENGO | RIO DE JANEIRO | MG     |          6 |
|          6 | RUA URUGUAIANA        | CENTRO   | VITORIA        | ES     |          5 |
+------------+-----------------------+----------+----------------+--------+------------+

DESC telefone;

SELECT * FROM cliente;

INSERT INTO telefone VALUES (NULL, 'CEL', '78458743', 5);

INSERT INTO telefone VALUES (NULL, 'RES', '30265456', 5);

INSERT INTO telefone VALUES (NULL, 'CEL', '32567012', 1);

INSERT INTO telefone VALUES (NULL, 'COM', '32569120', 2);

INSERT INTO telefone VALUES (NULL, 'RES', '32595680', 1);

INSERT INTO telefone VALUES (NULL, 'CEL', '23503210', 3);

INSERT INTO telefone VALUES (NULL, 'CEL', '32560232', 3);

INSERT INTO telefone VALUES (NULL, 'COM', '32568740', 1);

INSERT INTO telefone VALUES (NULL, 'RES', '32564459', 5);

INSERT INTO telefone VALUES (NULL, 'CEL', '32220452', 2);

-- projeção --
SELECT * FROM telefone;

SELECT NOW() AS DATA_HORA; -- MOSTRA DATA E HORA ATUAL COM UMA COLUNA RENOMEADA --

SELECT 2 + 2 AS SOMA, NOME, NOW()
FROM cliente; -- CRIANDO TABELAS E MISTURANDO COM A CLIENTE --

-- seleção --
SELECT nome, sexo, email
FROM cliente
WHERE sexo = 'F';

SELECT numero
FROM telefone
WHERE tipo = 'CEL';

-- junção --
SELECT nome, email, id_Cliente
FROM cliente;

+--------+---------------+-----------+
| nome   | email         | idCliente |
+--------+---------------+-----------+
| JOAO   | JOAO@IG.COM   |         1 |
| CARLOS | CARLOS@IG.COM |         2 |
| ANA    | ANA@IG.COM    |         3 |
| CLARA  | NULL          |         4 |
| JORGE  | JORGE@IG.COM  |         5 |
| CELIA  | CELIA@IG.COM  |         6 |
+--------+---------------+-----------+

SELECT id_Cliente, bairro, cidade
FROM endereco;

+------------+----------+----------------+
| id_Cliente | bairro   | cidade         |
+------------+----------+----------------+
|          4 | CENTRO   | BELO HORIZONTE |
|          1 | CENTRO   | RIO DE JANEIRO |
|          3 | JARDINS  | SAO PAULO      |
|          2 | ESTACIO  | RIO DE JANEIRO |
|          6 | FLAMENGO | RIO DE JANEIRO |
|          5 | CENTRO   | VITORIA        |
+------------+----------+----------------+

-- claro que devemos juntar estas duas tabelas --
SELECT nome, sexo, bairro, cidade
FROM cliente 
WHERE idCliente = id_Cliente; -- essa query funciona, mas não é correto fazer assim --

SELECT nome, sexo, bairro, cidade
FROM cliente
INNER JOIN endereco
WHERE idCliente = id_Cliente;

+--------+------+----------+----------------+
| nome   | sexo | bairro   | cidade         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| CARLOS | M    | ESTACIO  | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SAO PAULO      |
| CLARA  | F    | CENTRO   | BELO HORIZONTE |
| JORGE  | M    | CENTRO   | VITORIA        |
| CELIA  | F    | FLAMENGO | RIO DE JANEIRO |
+--------+------+----------+----------------+

SELECT nome, sexo, bairro, cidade
FROM cliente
INNER JOIN endereco
WHERE idCliente = id_Cliente
AND sexo = 'F';

+-------+------+----------+----------------+
| nome  | sexo | bairro   | cidade         |
+-------+------+----------+----------------+
| ANA   | F    | JARDINS  | SAO PAULO      |
| CLARA | F    | CENTRO   | BELO HORIZONTE |
| CELIA | F    | FLAMENGO | RIO DE JANEIRO |
+-------+------+----------+----------------+

SELECT nome, sexo, email, tipo, numero
FROM cliente
INNER JOIN telefone
WHERE idCliente = id_Cliente;

+--------+------+---------------+------+----------+
| nome   | sexo | email         | tipo | numero   |
+--------+------+---------------+------+----------+
| JOAO   | M    | JOAO@IG.COM   | CEL  | 32567012 |
| JOAO   | M    | JOAO@IG.COM   | RES  | 32595680 |
| JOAO   | M    | JOAO@IG.COM   | COM  | 32568740 |
| CARLOS | M    | CARLOS@IG.COM | COM  | 32569120 |
| CARLOS | M    | CARLOS@IG.COM | CEL  | 32220452 |
| ANA    | F    | ANA@IG.COM    | CEL  | 23503210 |
| ANA    | F    | ANA@IG.COM    | CEL  | 32560232 |
| JORGE  | M    | JORGE@IG.COM  | CEL  | 78458743 |
| JORGE  | M    | JORGE@IG.COM  | RES  | 30265456 |
| JORGE  | M    | JORGE@IG.COM  | RES  | 32564459 |
+--------+------+---------------+------+----------+
-- se repetiu porque tem cliente com mais de um telefone)

-- juntando mais de duas tabelas --
SELECT cliente.nome, cliente.sexo, endereco.bairro, endereco.cidade, telefone.tipo, telefone.numero
FROM cliente
INNER JOIN endereco
ON cliente.idCliente = endereco.id_Cliente
INNER JOIN telefone
WHERE cliente.idCliente = telefone.id_Cliente;

+--------+------+---------+----------------+------+----------+
| nome   | sexo | bairro  | cidade         | tipo | numero   |
+--------+------+---------+----------------+------+----------+
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | CEL  | 32567012 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | RES  | 32595680 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | COM  | 32568740 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | COM  | 32569120 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | CEL  | 32220452 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 23503210 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 32560232 |
| JORGE  | M    | CENTRO  | VITORIA        | CEL  | 78458743 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 30265456 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 32564459 |
+--------+------+---------+----------------+------+----------+

-- outra forma (dando alias) mais comum de usar --

SELECT C.nome, C.sexo, E.bairro, E.cidade, T.tipo, T.numero
FROM cliente C
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente;

-- DML --
-- manipulando os dados --
DESC cliente;

INSERT INTO cliente VALUES (NULL, 'PAULA', 'M', NULL, '89532002365');

SELECT * FROM cliente;

DESC endereco;

INSERT INTO endereco VALUES (NULL, 'RUA JOAQUIM SILVA', 'ALVORADA', 'NITEROI', 'RJ', 12);

SELECT * FROM cliente
WHERE sexo = 'M';

-- vamos atualizar a tabela cliente para concertar o sexo de Paula --
SELECT * FROM cliente
WHERE idCliente = 12;

UPDATE cliente
SET sexo = 'F'
WHERE idCliente = 12;

-- vamos deletar um registro --
INSERT INTO cliente VALUES (NULL, 'XXX', 'M', NULL, 'xxx'); -- vamos excluir este --

SELECT * FROM cliente
WHERE idCliente = 13;

DELETE FROM cliente
WHERE idCliente = 13;

SELECT * FROM cliente;

-- DDL --
-- modificando tabelas --

CREATE TABLE produto(
	idProduto INT PRIMARY KEY AUTO_INCREMENT,
	nomeProduto VARCHAR(30) NOT NULL,
	preco INT,
	frete FLOAT(10, 2) NOT NULL
);

SHOW TABLES;

-- modificando com ALTER TABLE --
-- ALTERANDO O NOME DE UMA COLUNA --
ALTER TABLE produto
CHANGE preco valorUnitario INT NOT NULL;

DESC produto;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idProduto     | int(11)     | NO   | PRI | NULL    | auto_increment |
| nomeProduto   | varchar(30) | NO   |     | NULL    |                |
| valorUnitario | int(11)     | NO   |     | NULL    |                |
| frete         | float(10,2) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+

ALTER TABLE produto
CHANGE valorUnitario valorUnitario INT; -- tem uma maneira mais legal de fazer --

DESC produto;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idProduto     | int(11)     | NO   | PRI | NULL    | auto_increment |
| nomeProduto   | varchar(30) | NO   |     | NULL    |                |
| valorUnitario | int(11)     | YES  |     | NULL    |                |
| frete         | float(10,2) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+

-- usando o modify (demonstração da maneira mais fácil) --
ALTER TABLE produto
MODIFY valorUnitario VARCHAR(50) NOT NULL;

-- change é mais seguro para renomear nome da coluna --
-- modify é mais recomendado para renomear tipos --

-- adicionando colunas --
ALTER TABLE produto
ADD peso FLOAT(10, 2) NOT NULL;

DESC produto;

+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idProduto     | int(11)     | NO   | PRI | NULL    | auto_increment |
| nomeProduto   | varchar(30) | NO   |     | NULL    |                |
| valorUnitario | varchar(50) | NO   |     | NULL    |                |
| frete         | float(10,2) | NO   |     | NULL    |                |
| peso          | float(10,2) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------

-- apagando uma coluna --
ALTER TABLE produto
DROP COLUMN peso;

DESC PRODUTO;

+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idProduto     | int(11)     | NO   | PRI | NULL    | auto_increment |
| nomeProduto   | varchar(30) | NO   |     | NULL    |                |
| valorUnitario | varchar(50) | NO   |     | NULL    |                |
| frete         | float(10,2) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+

-- adicionando uma coluna em ordem específica --
ALTER TABLE produto
ADD COLUMN peso FLOAT(10, 2) NOT NULL
AFTER nomeProduto;
-- coluna vai ser adicionada depois de nomeProduto --

-- adicionando uma coluna na primeira posição --
ALTER TABLE produto
DROP COLUMN peso;

ALTER TABLE produto
ADD COLUMN peso FLOAT(10, 2) NOT NULL
FIRST;

DESC produto;

+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| peso          | float(10,2) | NO   |     | NULL    |                |
| idProduto     | int(11)     | NO   | PRI | NULL    | auto_increment |
| nomeProduto   | varchar(30) | NO   |     | NULL    |                |
| valorUnitario | varchar(50) | NO   |     | NULL    |                |
| frete         | float(10,2) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+


/* EXERCICIOS DML */
USE comercio;

SHOW TABLES;

SELECT * FROM cliente;

INSERT INTO CLIENTE VALUES(NULL,'FLAVIO','M','FLAVIO@IG.COM','4657765'); --12--
INSERT INTO CLIENTE VALUES(NULL,'ANDRE','M','ANDRE@GLOBO.COM','7687567'); --13--
INSERT INTO CLIENTE VALUES(NULL,'GIOVANA','F',NULL,'0876655'); --14--
INSERT INTO CLIENTE VALUES(NULL,'KARLA','M','KARLA@GMAIL.COM','545676778');
INSERT INTO CLIENTE VALUES(NULL,'DANIELE','M','DANIELE@GMAIL.COM','43536789');
INSERT INTO CLIENTE VALUES(NULL,'LORENA','M',NULL,'774557887');
INSERT INTO CLIENTE VALUES(NULL,'EDUARDO','M',NULL,'54376457');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','F','ANTONIO@IG.COM','12436767');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M','ANTONIO@UOL.COM','3423565');
INSERT INTO CLIENTE VALUES(NULL,'ELAINE','M','ELAINE@GLOBO.COM','32567763');
INSERT INTO CLIENTE VALUES(NULL,'CARMEM','M','CARMEM@IG.COM','787832213');
INSERT INTO CLIENTE VALUES(NULL,'ADRIANA','F','ADRIANA@GMAIL.COM','88556942');
INSERT INTO CLIENTE VALUES(NULL,'JOICE','F','JOICE@GMAIL.COM','55412256');

/* CADASTRE UM ENDERECO PARA CADA CLIENTE */

INSERT INTO ENDERECO VALUES(NULL,'RUA GUEDES','CASCADURA','B. HORIZONTE','MG',14);
INSERT INTO ENDERECO VALUES(NULL,'RUA MAIA LACERDA','ESTACIO','RIO DE JANEIRO','RJ',13);
INSERT INTO ENDERECO VALUES(NULL,'RUA VISCONDESSA','CENTRO','RIO DE JANEIRO','RJ',12);
INSERT INTO ENDERECO VALUES(NULL,'RUA NELSON MANDELA','COPACABANA','RIO DE JANEIRO','RJ',12);
INSERT INTO ENDERECO VALUES(NULL,'RUA ARAUJO LIMA','CENTRO','VITORIA','ES',13);
INSERT INTO ENDERECO VALUES(NULL,'RUA CASTRO ALVES','LEBLON','RIO DE JANEIRO','RJ',14);
INSERT INTO ENDERECO VALUES(NULL,'AV CAPITAO ANTUNES','CENTRO','CURITIBA','PR',15);
INSERT INTO ENDERECO VALUES(NULL,'AV CARLOS BARROSO','JARDINS','SAO PAULO','SP',16);
INSERT INTO ENDERECO VALUES(NULL,'ALAMEDA SAMPAIO','BOM RETIRO','CURITIBA','PR',17);
INSERT INTO ENDERECO VALUES(NULL,'RUA DA LAPA','LAPA','SAO PAULO','SP',18);
INSERT INTO ENDERECO VALUES(NULL,'RUA GERONIMO','CENTRO','RIO DE JANEIRO','RJ',19);
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',20);
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',21);

/* CADASTRE TELEFONES PARA OS CLIENTES */


INSERT INTO TELEFONE VALUES(NULL,'RES','68976565',12);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99656675',13);
INSERT INTO TELEFONE VALUES(NULL,'CEL','33567765',16);
INSERT INTO TELEFONE VALUES(NULL,'CEL','88668786',18);
INSERT INTO TELEFONE VALUES(NULL,'COM','55689654',16);
INSERT INTO TELEFONE VALUES(NULL,'COM','88687979',12);
INSERT INTO TELEFONE VALUES(NULL,'COM','88965676',13);
INSERT INTO TELEFONE VALUES(NULL,'CEL','89966809',15);
INSERT INTO TELEFONE VALUES(NULL,'COM','88679978',16);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99655768',17);
INSERT INTO TELEFONE VALUES(NULL,'RES','89955665',18);
INSERT INTO TELEFONE VALUES(NULL,'RES','77455786',19);
INSERT INTO TELEFONE VALUES(NULL,'RES','89766554',19);
INSERT INTO TELEFONE VALUES(NULL,'RES','77755785',20);
INSERT INTO TELEFONE VALUES(NULL,'COM','44522578',20);

-- RELATÓRIO GERAL DE TODOS OS CLIENTES --
DESC cliente;
DESC endereco;
DESC telefone;

+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| idCliente | int(11)       | NO   | PRI | NULL    | auto_increment |
| nome      | varchar(30)   | NO   |     | NULL    |                |
| sexo      | enum('M','F') | NO   |     | NULL    |                |
| email     | varchar(50)   | YES  | UNI | NULL    |                |
| CPF       | varchar(15)   | YES  | UNI | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| idEndereco | int(11)     | NO   | PRI | NULL    | auto_increment |
| rua        | varchar(30) | NO   |     | NULL    |                |
| bairro     | varchar(30) | NO   |     | NULL    |                |
| cidade     | varchar(30) | NO   |     | NULL    |                |
| estado     | char(2)     | NO   |     | NULL    |                |
| id_Cliente | int(11)     | YES  | UNI | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

+------------+-------------------------+------+-----+---------+----------------+
| Field      | Type                    | Null | Key | Default | Extra          |
+------------+-------------------------+------+-----+---------+----------------+
| idTelefone | int(11)                 | NO   | PRI | NULL    | auto_increment |
| tipo       | enum('RES','COM','CEL') | NO   |     | NULL    |                |
| numero     | varchar(10)             | NO   |     | NULL    |                |
| id_Cliente | int(11)                 | YES  | MUL | NULL    |                |
+------------+-------------------------+------+-----+---------+----------------+

SELECT c.idCliente, c.nome, c.sexo, c.email, c.CPF, e.rua, e.bairro, e.cidade, e.estado, t.tipo, t.numero
FROM cliente as c
INNER JOIN endereco as e
ON c.idCliente = e.id_Cliente
INNER JOIN telefone as t
ON c.idCliente = t.id_Cliente;

-- UM RELATÓRIO DE TODOS OS HOMENS --
SELECT c.idCliente, c.nome, c.sexo, c.email, c.CPF, e.rua, e.bairro, e.cidade, e.estado, t.tipo, t.numero
FROM cliente as c
INNER JOIN endereco as e
ON c.idCliente = e.id_Cliente
INNER JOIN telefone as t
ON c.idCliente = t.id_Cliente
WHERE sexo = 'M';
 
-- Karla - 16, Daniele - 17 e Lorena - 18 estão com sexo errado --
SELECT * FROM cliente
WHERE idCliente = 16
OR idCliente = 17
OR idCliente = 18;
-- poderia ser feito assim --
SELECT * FROM cliente
WHERE idCliente IN (16, 17, 18);

UPDATE cliente
SET sexo  = 'F'
WHERE idCliente IN (16, 17, 18);

-- RELATORIO DE MULHERES --
SELECT c.idCliente, c.nome, c.sexo, c.email, c.CPF, e.rua, e.bairro, e.cidade, e.estado, t.tipo, t.numero
FROM cliente as c
INNER JOIN endereco as e
ON c.idCliente = e.id_Cliente
INNER JOIN telefone as t
ON c.idCliente = t.id_Cliente
WHERE sexo = 'F';

-- PRECISAMOS ARRUMAR O ANTONIO - 20 QUE ESTÁ COM SEXO FEMININO --
UPDATE cliente
SET sexo = 'M'
WHERE idCliente = 20;

-- QUANTIDADE DE HOMENS E MULHERES --
SELECT COUNT(*) AS QUANTIDADE, SEXO
FROM cliente
GROUP BY sexo;

-- IDs E EMAIL DAS MULHERES QUE MORAM NO CENTRO DO RIO DE JANEIRO E NÃO POSSUEM CELULAR --
SELECT C.idCliente, C.email, C.nome, C.sexo, T.tipo, E.bairro, E.cidade
FROM cliente C
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente
WHERE sexo = 'F'
AND bairro = 'CENTRO' AND cidade = 'RIO DE JANEIRO'
AND (tipo = 'RES' OR tipo = 'COM');

/* PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM RELATÓRIO COM O NOME, EMAIL E TELEFONE DAS MULHERES QUE MORAM
NO ESTADO DE SÃO PAULO */
SELECT C.nome, C.email, T.numero AS Celular
FROM cliente C
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente
WHERE tipo = 'CEL' AND estado = 'RJ';

/* QUERO O NOME DO CLIETE, EMAIL, NUMERO E ESTADO */
SELECT C.nome, C.email, E.estado, T.numero
FROM cliente C
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente;

-- vamos usar a função IFNULL() para renomear o NULL de e-mail --
SELECT 
	C.nome, 
	IFNULL(C.email, "NAO TEM EMAIL"), 
	E.estado, 
	T.numero
FROM cliente C
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente; 

-- o cabeçalho aparece com o nome da função, vamos usar o Alias --
SELECT
	C.nome,
	IFNULL(C.email, "NAO TEM EMAIL") AS email,
	E.estado,
	T.numero
FROM cliente C
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente;

-- usando VIEW --
CREATE VIEW relatorio AS
SELECT 
	C.nome, 
	C.sexo, 
	C.email, 
	T.tipo, 
	T.numero, 
	E.bairro, 
	E.cidade, 
	E.estado
FROM cliente C
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente;

SELECT * FROM relatorio;

SHOW TABLES; -- para ver as views, nós também usamos o show tables --

-- para apagar uma view --
DROP VIEW relatorio;

-- inserindo um prefixo --
CREATE VIEW v_relatorio AS
SELECT 
	C.nome, 
	C.sexo, 
	IFNULL(C.email, "NAO TEM EMAIL") AS email, 
	T.tipo, 
	T.numero, 
	E.bairro, 
	E.cidade, 
	E.estado
FROM cliente C
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente;

/* Com o VIEW, nós temos uma pequena perda de perfomance, mas é necessário usar */

-- a gente pode fazer um select dentro de uma view --
SELECT nome, numero, estado
FROM v_relatorio;

-- operações de DML em VIEWS --
DESC v_relatorio;

INSERT INTO v_relatorio VALUES (
	'ANDREIA', 'F', 'ANDREIA@UOL.COM.BR', 'CEL', '995235623', 'CENTRO', 'VITORIA', 'ES'
);

/* ERROR 1394 (HY000): Can not insert into join view 'comercio.v_relatorio' without fields list
Eu só posso fazer operações de DML em VIEWS originadas de tabelas sem JOIN
INSERT e DELETE não posso fazer, entretanto, UPDATE eu consigo
*/
UPDATE v_relatorio
SET nome = 'JOSE'
WHERE nome = 'JORGE';
-- Também será alterado na tabela --

-- vamos criar uma nova tabela, sem JOIN, para testar --
CREATE TABLE jogadores(
	idJogador INT,
	nome VARCHAR(30),
	estado CHAR(2)
);

INSERT INTO jogadores VALUES (1, 'Guerrero', 'SC');
INSERT INTO jogadores VALUES (2, 'Gabigol', 'RJ');
INSERT INTO jogadores VALUES (3, 'Ganso', 'RJ');
INSERT INTO jogadores VALUES (4, 'Nene', 'RJ');
INSERT INTO jogadores VALUES (5, 'Love', 'PE');

CREATE VIEW v_jogadores AS
SELECT nome, estado
FROM jogadores;

INSERT INTO v_jogadores VALUES ('Giuliano', 'SP');

SELECT * FROM v_jogadores;

DELETE FROM v_jogadores
WHERE nome = 'Guerrero';
-- Guerrero foi excluído --

-- inserindo novamente --
INSERT INTO v_jogadores VALUES ('Guerrero', 'SC');
/* inserindo na VIEW, a coluna não selecionada ficará com NULL */

SELECT * FROM v_relatorio
WHERE sexo = 'F';

-- Ordenando dados com ORDER BY --
CREATE TABLE alunos(
	numero INT,
	nome VARCHAR(30)
);

INSERT INTO alunos VALUES (1, 'JOAO');
INSERT INTO alunos VALUES (1, 'MARIA');
INSERT INTO alunos VALUES (2, 'ZOE');
INSERT INTO alunos VALUES (2, 'ANDRE');
INSERT INTO alunos VALUES (3, 'CLARA');
INSERT INTO alunos VALUES (1, 'CLARA');
INSERT INTO alunos VALUES (4, 'MARIA');
INSERT INTO alunos VALUES (5, 'JANAINA');
INSERT INTO alunos VALUES (1, 'JANAINA');
INSERT INTO alunos VALUES (3, 'MARCELO');
INSERT INTO alunos VALUES (4, 'GIOVANI');
INSERT INTO alunos VALUES (5, 'ANTONIO');
INSERT INTO alunos VALUES (6, 'ANA');
INSERT INTO alunos VALUES (6, 'VIVIANE');

SELECT * FROM alunos;

-- ordenando por número --
SELECT * FROM alunos
ORDER BY numero;

-- ordenando por nome --
SELECT * FROM alunos
ORDER BY nome;
-- também posso colocar o número da coluna referente --
SELECT * FROM alunos
ORDER BY 2;

-- posso ordenar por mais de uma coluna --
SELECT * FROM alunos
ORDER BY numero, nome;

/* Mesclando ORDER BY com Projeção */
SELECT nome FROM alunos
ORDER BY 1, 2;
/* vai dar erro porque, como ler de baixo pra cima, ele não vai ler a primeira coluna, isso porque foi 
selecionado apenas 'nome' */

-- para fazer isso, podemos especificar o nome da coluna --

SELECT nome FROM alunos
ORDER BY numero, nome;

-- ORDER BY DESC / ASC --
SELECT * FROM alunos
ORDER BY 1 ASC;
-- ASC vem de crescente --

-- em ordem decrescente --
SELECT * FROM alunos
ORDER BY 2 DESC;

SELECT * FROM alunos
ORDER BY 1 DESC, 2 ASC;

-- ordenando uma view --
SELECT 
	C.nome, 
	C.sexo, 
	IFNULL(C.email, "NAO TEM EMAIL") AS email, 
	T.tipo, 
	T.numero, 
	E.bairro, 
	E.cidade, 
	E.estado
FROM cliente C
INNER JOIN telefone T
ON C.idCliente = T.id_Cliente
INNER JOIN endereco E
ON C.idCliente = E.id_Cliente
ORDER BY 1;

SHOW TABLES;

SELECT * FROM v_relatorio
ORDER BY 1;

-- vamos mudar o delimitador no SQL --
DELIMITER $

SELECT * FROM v_relatorio$

STATUS -- com STATUS eu posso ver o delimitador usado --

/* Programando em Banco de Dados - STORED PROCEDURES */
DELIMITER $

STATUS

-- exemplo de procedure --
CREATE PROCEDURE NOME()
BEGIN
	-- bloco de código; --
END
$
/* A gente troca o delimitador porque precisamos colocar 
o ; dentro do bloco de código do procedure */

CREATE PROCEDURE nomeEmpresa()
BEGIN
	SELECT 'UNIVERSIDADE DOS DADOS' AS EMPRESA;
END
$

-- chamando uma procedure --
DELIMITER ;

CALL nomeEmpresa();

/* PROCEDURES com parâmetros */
-- processo normal (sem parâmetro) --
DELIMITER &

CREATE PROCEDURE conta()
BEGIN
	SELECT 10 * 10 AS conta;
END
&

DELIMITER ;

CALL conta();

-- apagando uma PROCEDURE --
DROP PROCEDURE conta;

-- criando PROCEDURE com parâmetro --
DELIMITER @

CREATE PROCEDURE conta(numero1 INT, numero2 INT)
BEGIN
	SELECT numero1 * numero2 AS conta;
END
@

CALL conta(10, 50)@
CALL conta(2, 5)@

DELIMTER ;

CALL conta(1, 3);
