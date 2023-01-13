/* podemos criar uma tabela com o resultado de uma query
e essa é a forma de realizar uma modelagem colunar 

CREATE TABLE AS SELECT
*/


create table genero(
	idGenero int primary key,
	nome varchar(30)
);

insert into genero values(1,'fantasia');
insert into genero values(2,'aventura');
insert into genero values(3,'suspense');
insert into genero values(4,'acao');
insert into genero values(5,'drama');

create table filme(
	idFilme int primary key,
	nome varchar(30),
	ano int,
	id_genero int,
	foreign key(id_genero)
	references genero(idGenero)
);

insert into filme values(100,'kill bill',2007,2);
insert into filme values(200,'dracula',1998,3);
insert into filme values(300,'senhor dos aneis',2008,1);
insert into filme values(400,'um sonho de liberdade',2008,5);
insert into filme values(500,'os bad boys',2008,4);
insert into filme values(600,'guerra civil',2016,2);
insert into filme values(700,'cadillac records',2009,5);
insert into filme values(800,'o hobbit',2008,1);
insert into filme values(900,'tomates verdes fritos',2008,5);
insert into filme values(1000,'corrida mortal',2008,4);

create table locacao(
	idLocacao int primary key,
	data date,
	midia int,
	dias int,
	id_filme int,
	foreign key(id_filme)
	references filme(idFilme)
);

insert into locacao values(1,'01/08/2019',23,3,100);
insert into locacao values(2,'01/02/2019',56,1,400);
insert into locacao values(3,'02/07/2019',23,3,400);
insert into locacao values(4,'02/07/2019',43,1,500);
insert into locacao values(5,'02/02/2019',23,2,100);
insert into locacao values(6,'03/07/2019',76,3,700);
insert into locacao values(7,'03/02/2019',45,1,700);
insert into locacao values(8,'04/08/2019',89,3,100);

select F.nome, G.nome, L.data, L.dias, L.midia
from genero G
inner join filme F
on G.idGenero = F.id_genero
inner join locacao L
on L.id_filme = F.idFilme;

create table rel_locadora as
select F.nome as filme, G.nome as genero, L.data as data, L.dias as dias, L.midia as midia
from genero G
inner join filme F
on G.idGenero = F.id_genero
inner join locacao L
on L.id_filme = F.idFilme;

select * from rel_locadora;

copy rel_locadora to
'C:\Users\danrl\Desktop\PostgreSQL\rel_locadora.csv'
delimiter ';'
csv header;

/* sincronizando tabelas e relatorios */
drop table locacao

create table locacao(
	idLocacao int primary key,
	data date,
	midia int,
	dias int,
	id_filme int,
	foreign key(id_filme)
	references filme(idFilme)
);

create sequence seq_locacao;

nextval('seq_locacao');

insert into locacao values(nextval('seq_locacao'),'01/08/2018',23,3,100);
insert into locacao values(nextval('seq_locacao'),'01/02/2018',56,1,400);

drop rel_locadora;

select L.idLocacao, F.nome as filme, G.nome as genero, L.data as data, L.dias as dias, L.midia as midia
from genero G
inner join filme F
on G.idGenero = F.id_genero
inner join locacao L
on L.id_filme = F.idFilme;

create table relatorio_locadora as
select L.idLocacao, F.nome as filme, G.nome as genero, L.data as data, L.dias as dias, L.midia as midia
from genero G
inner join filme F
on G.idGenero = F.id_genero
inner join locacao L
on L.id_filme = F.idFilme;

select * from relatorio_locadora;
select * from locacao;

/* select para trazer os novos registros */
select max(idLocacao) as relatorio, (select max(idLocacao) from locacao) as locacao
from relatorio_locacao;

select L.idLocacao, F.nome as filme, G.nome as genero, L.data as data, L.dias as dias, L.midia as midia
from genero G
inner join filme F
on G.idGenero = F.id_genero
inner join locacao L
on L.id_filme = F.idFilme
where idLocacao not in (select idLocacao from relatorio_locadora);

/* inserindo os registros novos */
insert into relatorio_locadora
select L.idLocacao, F.nome as filme, G.nome as genero, L.data as data, L.dias as dias, L.midia as midia
from genero G
inner join filme F
on G.idGenero = F.id_genero
inner join locacao L
on L.id_filme = F.idFilme
where idLocacao not in (select idLocacao from relatorio_locacao);

/* automatizando com uma trigger */
create on replace function atualiza_rel()
returns trigger as $$
begin
	insert into relatorio_locadora
	select L.idLocacao, F.nome as filme, G.nome as genero, L.data as data, L.dias as dias, L.midia as midia
	from genero G
	inner join filme F
	on G.idGenero = F.id_genero
	inner join locacao L
	on L.id_filme = F.idFilme
	where idLocacao not in (select idLocacao from relatorio_locacao);
	
	copy relatorio_locadora to
	'C:\Users\danrl\Desktop\PostgreSQL\relatorio_locadora.csv'
	delimiter ';'
	csv header;
	
	return new;
end;
$$

@language PLPGSQL;

/* comando para apagar uma trigger */
drop trigger tg_relatorio on locacao;

/* criando trigger */
create trigger tg_relatorio
after insert on locacao
for each row
	execute procedure atualiza_rel();
	
/* sincronizando com registros deletados */
create on replace function delete_locacao()
returns trigger as
$$
begin
	delete from relatorio_locadora
	where idLocacao = OLD.idLocacao;
	copy relatorio_locadora to
	'C:\Users\danrl\Desktop\PostgreSQL\relatorio_locadora.csv'
	delimiter ';'
	csv header;
end;
$$
@language PLPGSQL;

create trigger delete_reg
	after delete on locacao
	for each row
	execute procedure delete_locacao;
	
delete from locacao
where idLocacao = 1;

