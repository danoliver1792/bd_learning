/* machine learning - criando colunas Dummy */

-- utilizando o case
select cargo from funcionarios;

select nome, cargo,
case
	when cargo = "Financial Advisor" then "Condicao 01"
	when cargo = "Structural Engineer" then "Condicao 02"
	when cargo = "Executive" then "Condicao 03"
	when cargo = "Sales Associative" then "Condicao 04"
	else "Outras Condicoes"
end as "condicoes"
from funcionarios;

select nome,
case
	when sexo = "Masculino" then "M"
	else "F" 
end as "Sexo"
from funcionarios;

/* usando valor booleano na coluna */
select nome, cargo, (sexo = "Masculino") as Masculino, (sexo = "Feminino") as Feminino
from funcionarios;

/* mesclando as tecnicas */

select nome, cargo,
case
	when (sexo = 'Masculino') = true then 1
	else 0
end as "Masculino"
from funcionarios;

select nome, cargo, 
case
	when (sexo = 'Feminino') = true then 1
	else 0
end as "Feminino"
from funcionarios;
