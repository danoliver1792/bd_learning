/* Assunto - delimitador */
CREATE DATABASE aula_sql
GO

USE aula_sql
GO

-- ctrl + r -> tira o console --
CREATE TABLE teste(
	nome VARCHAR(30)
)
GO

/* O GO e o delimitador do SQL Server */

CREATE DATABASE banco04
GO

USE banco04
GO

CREATE TABLE teste(
	nome VARCHAR(30)
)
GO


/*
Voce consegue rodar o codigo sem delimitador, mas o GO quebra os comandos do SQL Server
em pacotes TCP/IP para chegar na ordem sincrona no servidor */

-- apagando um banco de dados --
DROP DATABASE aula_sql
GO

DROP DATABASE aula_sql02
GO




/* ORGANIZANDO FISICAMENTE E LOGICAMENTE UM BANCO DE DADOS

1 - CRIAR UM BANCO COM ARQUIVOS PARA OS SETORES DE MARKETING E VENDAS
2 - CRIAR UM ARQUIVO GERAL (QUEM NÃO É MKT OU VENDAS)
3 - DEIXAR O MDF APENAS COM O DICIONÁRIO DE DADOS
4 - CRIAR 2 GRUPOS DE ARQUIVOS

*/

-- criamos as outras tabelas pelo próprio SQL Server --

USE EMPRESA
GO

CREATE TABLE TB_EMPRESA(
	id INT,
	nome VARCHAR(50)
)
GO