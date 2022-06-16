/* ---------------------------------- PSET3 --------------------------------- */
/*          Comandos utilizados para a seleção da query hierarquica           */
/*                         da tabela "classificacao"                          */
/* -------------------------------------------------------------------------- */
/*        Aluno: Rafael Barcelos Ricarto                                      */
/* -------------------------------------------------------------------------- */



/* ---------------------------------- CONEXÃO ------------------------------- */

-- Conectando o meu usuário ao banco de dados "uvv".
\c "dbname=uvv user=rafael password=12345"

-- Setando o SEARCH_PATH para o esquema "elmasri".
set search_path to elmasri;

/* -------------------------------------------------------------------------- */




/* -------------------------- QUERY HIERARQUICA ----------------------------- */

-- Código recursivo para selecionar as categorias da tabela de forma hierarquica.
with recursive
anchor as		  
(select       codigo,
              concat(nome) as hierarquia,
              codigo_pai
 
from classificacao
where codigo_pai is null

union all

select        c.codigo,
              concat(a.hierarquia || '  //  ' || c.nome),
              c.codigo_pai
 
from classificacao as c
join anchor as a
on
a.codigo = c.codigo_pai
where c.codigo_pai is not null)

select *
from anchor
order by anchor.hierarquia;

/* --------------------------------- FIM ;) -------------------------------- */
