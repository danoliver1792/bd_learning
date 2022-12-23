/* Projeto Livraria */

CREATE DATABASE livraria;

USE LIVRARIA;

CREATE TABLE livros(
	Livro VARCHAR(100),
	Autor VARCHAR(100),
	Sexo CHAR(1),
	Paginas INT(5),
	Editora VARCHAR(30),
	Valor FLOAT(10, 2),
	UF CHAR(2),
	Ano INT(4)
);

SHOW DATABASE;

USE livraria;

STATUS; /* Mostrando o banco conectado */

INSERT INTO LIVROS VALUES ();

mysql> INSERT INTO LIVROS VALUES ('SQL para Leigos', 'Joao Nunes', 'M', 450, 'Addison',
    -> 98, 'SP', 2018);
Query OK, 1 row affected (0.05 sec)

mysql> INSERT INTO LIVROS VALUES ('Receitas Caseiras', 'Celia Tavares', 'F', 210, 'Atlas',
    -> 45, 'RJ', 2008);
Query OK, 1 row affected (0.03 sec)

mysql> INSERT INTO LIVROS VALUES ('Pessoas Efetivas', 'Eduardo Santos', 'M', 390, 'Beta',
    -> 78.99, 'RJ', 2018);
Query OK, 1 row affected (0.05 sec)

mysql> INSERT INTO LIVROS VALUES ('Habitos Saudaveis', 'Eduardo Santos', 'M', 630, 'Beta',
    -> 150.98, 'RJ', 2019);
Query OK, 1 row affected (0.23 sec)

mysql> INSERT INTO LIVROS VALUES ('A Casa Marrom', 'Hermes Macedo', 'M', 250, 'Bubba',
    -> 60, 'MG', 2016);
Query OK, 1 row affected (0.05 sec)

mysql> INSERT INTO LIVROS VALUES ('Estacio Querido', 'Geraldo Francisco', 'M', 310, 'Insigna',
    -> 100, 'ES', 2015);
Query OK, 1 row affected (0.23 sec)

mysql> INSERT INTO LIVROS VALUES ('Pra Sempre Amigas', 'Leda Silva', 'F', 510, 'Insigna',
    -> 78.98, 'ES', 2011);
Query OK, 1 row affected (0.17 sec)

mysql> INSERT INTO LIVROS VALUES ('Copas Inesqueciveis', 'Marco Alcantara', 'M', 200, 'Larson',
    -> 130.98, 'RS', 2018);
Query OK, 1 row affected (0.03 sec)

mysql> INSERT INTO LIVROS VALUES ('O poder da Mente', 'Clara Mafra', 'F', 120, 'Continental',
    -> 56.58, 'SP', 2017);
Query OK, 1 row affected (0.03 sec)

SELECT * FROM LIVROS;

SELECT NOME, EDITORA FROM LIVROS;

SELECT NOME, UF FROM LIVROS WHERE SEXO='M';

SELECT NOME, PAGINAS FROM LIVROS WHERE SEXO='F';

SELECT NOME, VALOR FROM LIVROS WHERE UF='SP';

SELECT AUTOR, SEXO FROM LIVROS WHERE SEXO = 'M' AND UF = 'SP' OR UF = 'RJ';

