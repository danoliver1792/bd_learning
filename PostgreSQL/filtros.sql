/* filtros de grupo */
-- baseados em valores numericos
select nome, departamento, salario
from funcionarios
where salario > 100000;

-- baseado em strings
select nome, departamento, salario
from funcionarios
where departamento = 'Ferramentas';

-- baseados em multiplas colunas e multiplos tipos
select nome, departamento, salario
from funcionarios
where departamento = 'Ferramentas'
and
salario > 100000;

-- baseado em um unico tipo e coluna
select nome, departamento, salario
from funcionarios
where departamento = 'Ferramentas'
and
departamento = 'Books';

-- baseado em padrao de caracteres
select nome, departamento, salario
from funcionarios
where departamento like 'B%'
group by departamento;

select nome, departamento, salario
from funcionarios
where departamento like 'Bo%'
group by departamento;

-- utilizando o caracter coringa no meio da palavra
select departamento, sum(salario) as "Total"
from funcionarios
where
departamento like '%B' and sum()
group by departamento;

select departamento, sum(salario) as "Total"
from funcionarios
where
departamento like 'B%' and sum(salario) > 400000
group by departamento;

-- multiplos contadores
select count(*) from funcionarios;

select sexo, count(*)
from funcionarios
where sexo = 'Masculino'
group by sexo;


select count(*) as "Quantidade Total",
count(*) filter(where sexo = 'Masculino') as "Masculino"
from funcionarios;

select count(*) as "Quantidade Total",
count(*) filter ( where sexo = 'Masculino') as "Masculino"
count(*) filter ( where departamento = 'Books') as "Books"
from funcionarios;

-- reformatacao de strings
-- listando
select departamento from funcionarios;

select distinct departamento from funcionarios;

-- upper case
select distinct upper departamento from funcionarios;

-- lower case
select distinct lower departamento from funcionarios;

-- concatenacao
select cargo || ' - ' || departamento as "Cargo Completo"
from funcionarios;

select upper cargo || ' - ' || departamento as "Cargo Completo"
from funcionarios;

-- remover espacos
select '    unidados   ';

-- contando caracteres
select length('    unidados    '); 

select trin('    unidados     ');
select length trin('     unidados     ');
