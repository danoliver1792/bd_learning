/* Criando um banco para alteração de uma tabela */
CREATE DATABASE tabela;

USE tabela;

CREATE TABLE tabela_teste(
	Coluna1 VARCHAR(30),
	Coluna2 VARCHAR(30),
	Coluna3 VARCHAR(30)
);

-- Alterando uma PK --
ALTER TABLE tabela_teste
ADD PRIMARY KEY (Coluna1);

DESC tabela_teste;

-- Adicionando coluna sem posição (última coluna) --
ALTER TABLE tabela_teste
ADD Coluna4 VARCHAR(30);

DESC tabela_teste;

ALTER TABLE tabela_teste
ADD Coluna100 INT;

-- Adicionando uma coluna com posição --
ALTER TABLE tabela_teste
ADD COLUMN Coluna5 VARCHAR(30) NOT NULL UNIQUE
AFTER Coluna4;

DESC tabela_teste;

-- Modificando o tipo de um campo
ALTER TABLE tabela_teste MODIFY Coluna2 DATE NOT NULL;

DESC tabela_teste;

-- renomeando a tabela --
ALTER TABLE tabela_teste RENAME pessoa;


SHOW TABLES;

-- Criando a tabela time para teste --
CREATE TABLE time(
	idTime INT PRIMARY KEY AUTO_INCREMENT,
	elenco VARCHAR(30),
	idPessoa VARCHAR(30)
);

-- FOREIGN KEY --
ALTER TABLE time
ADD FOREIGN KEY (idPessoa)
REFERENCES pessoa(Coluna1);

DESC time;

-- Verificando as chaves - com essa query, posso ver mais detalhes da tabela --
SHOW CREATE TABLE time;

-- Organização de chaves - chave é CONSTRAINT (REGRA) --
-- Chave Primaria -> Vai garantir que nosso registro seja único e não se repita
-- Chave Estrangeira -> Vai garantir que eu não tenho nenhum registro em nenhuma tabela sem referência em outra

CREATE TABLE jogador(
	idJogador INT PRIMARY KEY AUTO_INCREMENT,
	Nome VARCHAR(30)
);

CREATE TABLE times(
	idTimes INT PRIMARY KEY AUTO_INCREMENT,
	NomeTime VARCHAR(30),
	id_jogador INT,
	FOREIGN KEY(id_jogador)
	REFERENCES jogador(idJogador)
);

INSERT INTO jogador VALUES (NULL, 'GUERRERO');

INSERT INTO times VALUES (NULL, 'AVAI', 1); -- 1 porque no primeiro registro vai ser 1 (por causa do null vai entrar automático)

SELECT * FROM jogador;
SELECT * FROM times;

SHOW CREATE TABLE jogador;
| jogador | CREATE TABLE `jogador` (
  `idJogador` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idJogador`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 |

SHOW CREATE TABLE times;
| times | CREATE TABLE `times` (
  `idTimes` int(11) NOT NULL AUTO_INCREMENT,
  `NomeTime` varchar(30) DEFAULT NULL,
  `id_jogador` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTimes`),
  KEY `id_jogador` (`id_jogador`),
  CONSTRAINT `times_ibfk_1` FOREIGN KEY (`id_jogador`) REFERENCES `jogador` (`idJogador`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 |

/* `times_ibfk_1` -> foi feito isso porque quando a gente cria constraint o banco dá um nome aleatório, isso não é uma boa prática */
/* Precisamos sempre criar primeiro a tabela e em segundo as chaves por fora da tabela, isso por conta do nome */

CREATE DATABASE mercado;

USE mercado;

CREATE TABLE cliente(
	idCliente INT,
	Nome VARCHAR(30) NOT NULL
);

CREATE TABLE telefone(
	idTelefone INT,
	Tipo CHAR(3) NOT NULL,
	Numero VARCHAR(10) NOT NULL,
	id_cliente INT
);

ALTER TABLE cliente ADD CONSTRAINT PK_Cliente
PRIMARY KEY(idCliente);

ALTER TABLE telefone ADD CONSTRAINT FK_Cliente_Telefone
FOREIGN KEY(id_cliente) REFERENCES cliente(idCliente);

SHOW CREATE TABLE telefone;
| telefone | CREATE TABLE `telefone` (
  `idTelefone` int(11) DEFAULT NULL,
  `Tipo` char(3) NOT NULL,
  `Numero` varchar(10) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  KEY `FK_Cliente_Telefone` (`id_cliente`),
  CONSTRAINT `FK_Cliente_Telefone` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
-- conseguimos inserir o nome fornecido na query na chave --

/* Dicionario de Dados */
-- guardar os metadados -> dados dos dados ou dados organizadores --
SHOW DATABASES;
-- notemos as chamadas: information_schema, mysql e performance_schema que pertecem ao dicionário

-- procurando constraints --
USE information_schema;

SHOW TABLES;

+---------------------------------------+
| Tables_in_information_schema          |
+---------------------------------------+
| CHARACTER_SETS                        |
| COLLATIONS                            |
| COLLATION_CHARACTER_SET_APPLICABILITY |
| COLUMNS                               |
| COLUMN_PRIVILEGES                     |
| ENGINES                               |
| EVENTS                                |
| FILES                                 |
| GLOBAL_STATUS                         |
| GLOBAL_VARIABLES                      |
| KEY_COLUMN_USAGE                      |
| OPTIMIZER_TRACE                       |
| PARAMETERS                            |
| PARTITIONS                            |
| PLUGINS                               |
| PROCESSLIST                           |
| PROFILING                             |
| REFERENTIAL_CONSTRAINTS               |
| ROUTINES                              |
| SCHEMATA                              |
| SCHEMA_PRIVILEGES                     |
| SESSION_STATUS                        |
| SESSION_VARIABLES                     |
| STATISTICS                            |
| TABLES                                |
| TABLESPACES                           |
| TABLE_CONSTRAINTS                     |
| TABLE_PRIVILEGES                      |
| TRIGGERS                              |
| USER_PRIVILEGES                       |
| VIEWS                                 |
| INNODB_LOCKS                          |
| INNODB_TRX                            |
| INNODB_SYS_DATAFILES                  |
| INNODB_FT_CONFIG                      |
| INNODB_SYS_VIRTUAL                    |
| INNODB_CMP                            |
| INNODB_FT_BEING_DELETED               |
| INNODB_CMP_RESET                      |
| INNODB_CMP_PER_INDEX                  |
| INNODB_CMPMEM_RESET                   |
| INNODB_FT_DELETED                     |
| INNODB_BUFFER_PAGE_LRU                |
| INNODB_LOCK_WAITS                     |
| INNODB_TEMP_TABLE_INFO                |
| INNODB_SYS_INDEXES                    |
| INNODB_SYS_TABLES                     |
| INNODB_SYS_FIELDS                     |
| INNODB_CMP_PER_INDEX_RESET            |
| INNODB_BUFFER_PAGE                    |
| INNODB_FT_DEFAULT_STOPWORD            |
| INNODB_FT_INDEX_TABLE                 |
| INNODB_FT_INDEX_CACHE                 |
| INNODB_SYS_TABLESPACES                |
| INNODB_METRICS                        |
| INNODB_SYS_FOREIGN_COLS               |
| INNODB_CMPMEM                         |
| INNODB_BUFFER_POOL_STATS              |
| INNODB_SYS_COLUMNS                    |
| INNODB_SYS_FOREIGN                    |
| INNODB_SYS_TABLESTATS                 |
+---------------------------------------+

DESC TABLE_CONSTRAINTS;
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| CONSTRAINT_CATALOG | varchar(512) | NO   |     |         |       |
| CONSTRAINT_SCHEMA  | varchar(64)  | NO   |     |         |       |
| CONSTRAINT_NAME    | varchar(64)  | NO   |     |         |       |
| TABLE_SCHEMA       | varchar(64)  | NO   |     |         |       |
| TABLE_NAME         | varchar(64)  | NO   |     |         |       |
| CONSTRAINT_TYPE    | varchar(64)  | NO   |     |         |       |
+--------------------+--------------+------+-----+---------+-------+

SELECT CONSTRAINT_SCHEMA AS "BANCO",
	TABLE_NAME AS "TABELA",
	CONSTRAINT_TYPE AS "TIPO"
	FROM TABLE_CONSTRAINTS;

 -- vendo as constraints apenas do banco mercado --
 SELECT CONSTRAINT_SCHEMA AS "BANCO",
 	TABLE_NAME AS "TABELA",
 	CONSTRAINT_NAME AS "NOME_REGRA",
 	CONSTRAINT_TYPE AS "TIPO"
 	FROM TABLE_CONSTRAINTS
 	WHERE CONSTRAINT_SCHEMA = "COMERCIO";

-- apagando constraints --
USE mercado;

ALTER TABLE telefone
DROP FOREIGN KEY FK_Cliente_Telefone;

