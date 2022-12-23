-- trigger --

-- Estrutura de uma trigger --

/*
CRETAE TRIGGER <NOME>
BEFORE/AFTER INSERT/DELETE/UPDATE ON <TABELA>
FOR EACH ROW (PARA CADA LINHA)
BEGIN -> INICIO
	QUALQUER COMANDO SQL
END -> FIM
*/

CREATE DATABASE AULA40;

USE AULA40;

CREATE TABLE USUARIO(
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)
);

-- criando uma tabela de backup -> para salvar as exclusões da tabela usuario --
CREATE TABLE BACKUP_USUARIO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)
);	

-- criando a trigger --
DELIMITER $

CREATE TRIGGER BACKUP_USER
BEFORE DELETE ON USUARIO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP_USUARIO VALUES (NULL, OLD.IDUSUARIO, OLD.NOME, OLD.LOGIN);		
END
$

DELIMITER ;

INSERT INTO USUARIO VALUES (NULL, 'ANDRADE', 'ANDRADE2009', 'HEXACAMPEAO');

DELETE FROM USUARIO WHERE IDUSUARIO = 1;

SELECT * FROM BACKUP_USUARIO;
+----------+-----------+---------+-------------+
| IDBACKUP | IDUSUARIO | NOME    | LOGIN       |
+----------+-----------+---------+-------------+
|        1 |         1 | ANDRADE | ANDRADE2009 |
+----------+-----------+---------+-------------+

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10, 2)
);

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBKP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR FLOAT(10, 2)
);

USE LOJA;

-- INSERINDO EM OUTRO BANCO --
INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL, 1000, 'TESTE', 0.0);

SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);	
END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL, 'LIVRO MODELAGEM', 50.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO BI', 80.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO ORACLE', 70.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO SQL SERVER', 60.00);

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR);
END
$

DELIMITER ;

DELETE FROM PRODUTO WHERE IDPRODUTO = 2;

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;

--apagando uma trigger --
DROP TRIGGER BACKUP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);
END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL, 'LIVRO C#', 100.00);

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;

ALTER TABLE BACKUP.BKP_PRODUTO
ADD EVENTO CHAR(1);

SELECT * FROM BACKUP.BKP_PRODUTO;

DROP TRIGGER BACKUP_PRODUTO_DEL;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR, 'D');
END
$

DELIMITER ;

DELETE FROM PRODUTO WHERE IDPRODUTO = 4;

SELECT * FROM BACKUP.BKP_PRODUTO;

-- TRIGGER DE AUDITORIA --
DELIMITER ;
DROP DATABASE LOJA;

DROP DATABASE BACKUP;

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10, 2)
);

INSERT INTO PRODUTO VALUES(NULL, 'LIVRO MODELAGEM', 50.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO BI', 80.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO ORACLE', 70.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO SQL SERVER', 60.00);

SELECT CURRENT_USER();

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR_ORIGINAL FLOAT(10, 2),
	VALOR_ALTERADO FLOAT(10, 2),
	DATA DATETIME,
	USUARIO VARCHAR(30),
	EVENTO CHAR(1)
);

USE LOJA;

-- quero logar toda a alteração ao mudar o preço de um produto --
DELIMITER $

CREATE TRIGGER AUDIT_PROD
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR, NEW.VALOR, NOW(), CURRENT_USER(), 'U');
END
$

DELIMITER ;

UPDATE PRODUTO SET VALOR = 110.00 WHERE IDPRODUTO = 4;

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;