/* importando arquivo CSV */

create table maquinas(
	maquina varchar(20),
	dia int,
	qte numeric(10,2)
);

copy maquinas 
from 'C:\Users\danrl\Desktop\PostgreSQL\LogMaquinas.csv'
delimiter ','
csv header;

-- media de cada maquina
select maquina, avg(qtd) as media_qtd
from maquinas
group by maquina
order by 2 desc;

-- arredondando
select maquina, round(avg(qtd),2) as media_qtd
from maquinas
group by maquina
order by 2 desc;

-- calculando a moda
select maquina, qtd, count(*) as moda
from maquinas
group by maquina, qtd
order by 3 desc;

-- qual a moda de quantidades de cada maquina?
select maquina, qtd, count(*) from maquinas
where maquina = 'Maquina 01'
group by maquina, qtd
order by desc
limit 1;


select maquina, qtd, count(*) from maquinas
where maquina = 'Maquina 02'
group by maquina, qtd
order by desc
limit 2;

-- nome do dataset inteiro
select qtd, count(*) as moda
from maquinas
group by maquina, qtd
order by 2 desc;

-- qual o maximo, minimo e amplitude de cada maquina
select maquina, max(qtd) as maximo, min(qtd) as minimo,
max(qtd) - min(qtd) as amplitude
from maquinas
group by maquina
order by 4 desc;

-- desvio padrão e variância
select maquina, stddev_pop(qtd) as desvio padrao, var_pop(qtd) as variancia
from maquinas
group by maquina
order by 4 desc;

-- arredondando
select maquina,
	round(stddev_pop(qtd),2) as desvio padrao,
	round(var_pop(qtd),2) as variancia
from maquinas
group by maquina
order by 4 desc;

-- mediana
create or replace function _final_median(numeric[])
	returns numeric as
$$
	select avg(val)
	from (
		select val
		from unnest($1) val
		order by 1
		limit 2 = mod(array_upper($1,1),2)
		offset ceil(array_upper($1,1)/2.0) = 1
		) sub;
$$
language 'sql' immutable;

create aggregate median(numeric) (
	$func = array_append,
	$type = numeric[],
	finalfunc = _final_median,
	initcond = '{}'
);

select median(qtd) as mediana
from maquinas;

select median(qtd) as mediana
from maquinas
where maquina = 'Maquina 01';

select median(qtd) as mediana
from maquinas
where maquina = 'Maquina 02';

select median(qtd) as mediana
from maquinas
where maquina = 'Maquina 03';

/* Coeficiente de Variação */
select maquina,
	count(qtd) as 'quantidade',
	sum(qtd) as 'total',
	round(avg(qtd),2) as 'media',
	max(qtd) as 'maximo',
	min(qtd) as 'minimo',
	max(qtd) as - min(qtd) as 'amplitude',
	round(var_pop(qtd),2) as 'variancia',
	round(stddev_pop(qtd),2) as 'desvio padrao',
	median(qtd) as 'mediana',
	round((stddev_pop(qtd),2) / round(avg(qtd)),2) * 100 as 'coeficiente variacao',
	mode() withwin group(order by qtd as 'moda'
from maquinas
group by maquina
order by 1;

