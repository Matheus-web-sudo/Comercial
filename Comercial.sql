show databases;
use comercial;

alter table comclien add column c_estaclien varchar(50);

alter table comclien modify column c_estaclien varchar(100);

insert into comclien
	values ("1",
    "0001",
    "AARONSON",
    "AARONSON FURNITURE LUDA",
    "2015-02-17",
    "17.807.928/0001-85",
    "(21) 8167-6584",
    "QUEIMADOS",
    "RJ");
    
update comclien set c_nomeclien = "AARONSON FORNITURE"
where n_numeclien = 1;
commit;

update comclien set c_nomeclien = "AARONSON FURNITURE",
c_cidaclien = "LONDRINA",
c_estaclien = "PR"
	where n_numeclien = 1;
commit;

delete from comclien 
	where n_numeclien = 1;
commit;
SET SQL_SAFE_UPDATES=0;
delete from comclien;
commit;

select * from comclien;

select n_numeclien, c_codiclien, c_razaclien
	from comclien;
    
desc comclien;

select n_numeclien, c_codiclien, c_razaclien
	from comclien
    where c_codiclien = "0001";
    
select n_numeclien, c_codiclien, c_razaclien
	from comclien 
    where c_codiclien <> "0001"; #para ver os diferentes

select n_numeclien, c_codiclien, c_razaclien
	from comclien
    where c_razaclien like "L%";
    
select n_numeclien from comvenda; #clientes que fizeram uma compra

select distinct n_numeclien
	from comvenda; #o distinct é usado para não haver repetição do nome
    
select c_codiclien, c_razaclien 
	from comclien
    where n_numeclien in (1,2); # o in é usado para fazer consultas com um ou mais valores 
    
select c_razaclien 
	from comclien
	where n_numeclien in (select n_numeclien
								from comvenda
								where n_numeclien); #irá retornar a razão social dos clientes
                                
select c_razaclien
	from comclien
    where n_numeclien not in (select n_numeclien
								from comvenda); #para ver os clientes que não compraram 
                                
select c_codivenda Cod_Venda,
	(select c_razaclien
		from comclien 
        where n_numeclien = comvenda.n_numeclien) Nome_Cliente
from comvenda;

select c_codiclien CODIGO, c_nomeclien CLIENTE
	from comclien 
    where n_numeclien not in (1,2,3,4);
    
select c_codivenda Cod_Venda,
	(select c_razaclien
		from comclien 
        where n_numeclien = comvenda.n_numeclien) Nome_Cliente
	from comvenda;
    
select c_codiclien, c_razaclien, c_codivenda Cod_Venda
	from comvenda, comclien
    where comvenda.n_numeclien = comclien.n_numeclien
    order by c_razaclien; #order by é usado para ordernar uma coluna e nesse select é possível ver os dados de duas tabelas

create table comclien_bkp as(
	select *
		from comclien
        where c_estaclien = "SP"); #foi criado uma tabela e uma coluna igual a do comclien que seria a c_estaclien com o valor SP

create table comcontato(
	n_numecontato int not null auto_increment,
	c_nomecontato varchar(200),
	c_fonecontato varchar(30),
	c_cidacontato varchar(200),
	c_estacontato varchar(2),
	n_numeclien int,
	primary key(n_numecontato));
    
insert into comcontato(
	select n_numeclien,
    c_nomeclien,
    c_foneclien,
    c_cidaclien,
    c_estaclien,
    n_numeclien
from comclien);

update comcontato set c_cidacontato = "LONDRINA",
	c_estacontato = "PR"
where n_numeclien in (select n_numeclien 
							from comclien_bkp);#alterando registros por meio do select
                            
delete from comcontato
where n_numeclien not in (select n_numeclien
							from comvenda);
commit;

select c_codiclien, c_razaclien
	from comclien, comvenda
    where comvenda.numeclien = comclien.n_numeclien
    group by c_codiclien, c_razaclien
    order by c_razaclien; #o group by é usado para agregação de valores, assim não aparecendo valores repetidos
    
select c_codiclien, c_razaclien, count(n_numevenda) Qtde
	from comclien, comvenda
    where comvenda.n_numeclien = comclien.n_numeclien
    group by c_cidaclien, c_razaclien
    order by c_razaclien; #o count é usado para contar quantas vezes se repetiu
    
select c_razaclien, count(n_numevenda)
	from comclien, comvenda
    where comvenda.n_numeclien = comclien.n_numeclien
    group by c_razaclien
    having count(n_numevenda) > 2; #O having count é usado como uma condição para o count
    
select max(n_totavenda) maior_venda
	from comvenda; #o max ai foi usado para verificar o valor com maior venda
    
select min(n_totavenda) menor_venda, max(n_totalvenda)
	maior_venda from comvenda;
    
select sum(n_valovenda) valor_venda,
	sum(n_descvenda) descontos,
    sum(n_totavenda) total_venda
    from comvenda
    where d_datavenda between "2015-01-01" and "2015-01-01"; #O sum é usado para somar valores de valores de uma coluna e o between é usado para identificar valores entre duas variáveis

select format(avg(n_totavenda), 2)
	from comvenda; #O avg é usado para identificar a média dos valores
    
select c_codiprodu, c_descprodu
	from comprodu
    where substr(c_codiprodu,1,3) = "123"
    and length(c_codiprodu) > 4; #O Substr mostra os valores em uma determinada referencia ja o length mostra 
    
select concat(c_razaforne,"-fone:",c_foneforne)
	from comforne
    order by c_razaforne; #O concat é usado para concatenar dois ou mais campos
    
select concat_ws(";",c_codiclien, c_razaclien, c_nomeclien)
	from comclien
    where c_razaclien like "GREA%"; #O concat_ws e usado para especificar uma separação que irá ocorrer em todas as colunas
    
select lcase(c_razaclien)
	from comclien; #Para requisitar os registros em letra minuscula 
    
select ucase("banco de dados mysql")
	from dual; #Para deixar em maiuscula
    
alter table comvende add n_porcvende float(10,2);
alter table comvenda add n_vcomvenda float(10,2);

delimiter $$
create procedure processa_comissionamento(
in data_inicial date,
in data_final date ,
out total_processado int )
begin
declare total_venda float(10,2) default 0;
declare venda int default 0;
declare vendedor int default 0;
declare comissao float(10,2) default 0;
declare valor_comissao float(10,2) default 0;
declare aux int default 0;
## cursor para buscar os registros a serem
## processados entre a data inicial e data final
## e valor total de venda é maior que zero
declare busca_pedido cursor for
select n_numevenda,
n_totavenda,
n_numevende
from comvenda
where d_datavenda between data_inicial
and data_final
and n_totavenda > 0 ;

## abro o cursor
open busca_pedido;
## inicio do loop
vendas: LOOP
##recebo o resultado da consulta em cada variável
fetch busca_pedido into venda, total_venda,
vendedor;
## busco o valor do percentual de cada vendedor
select n_porcvende
into comissao
from comvende
where n_numevende = vendedor;
## verifico se o percentual do vendedor é maior
## que zero logo após a condição deve ter o then
if (comissao > 0 ) then
## calculo o valor da comissao
set valor_comissao =
((total_venda * comissao) / 100);
## faço o update na tabela comvenda com o
## valor da comissão
update comvenda set
n_vcomvenda = valor_comissao
where n_numevenda = vendedor;
commit;
## verifico se o percentual do vendedor é igual
## zero na regra do nosso sistema se o vendedor
## tem 0 ele ganha 0 porcento de comissão
elseif(comissao = 0) then
update comvenda set n_vcomvenda = 0
where n_numevenda = vendedor;
commit;
## se ele não possuir registro no percentual de
## comissão ele irá ganhar 1 de comissão
## isso pela regra de negócio do nosso sistema
else
set comissao = 1;
set valor_comissao =
((total_venda * comissao) / 100);
update
comvenda set n_vcomvenda = valor_comissao
where n_numevenda = vendedor;
commit;
## fecho o if
end if;
set comissao = 0;
##utilizo a variável aux para contar a quantidade
set aux = aux +1 ;
end loop vendas;
## atribuo o total de vendas para a variável de
## saída
set total_processado = aux;
## fecho o cursor
close busca_pedido;
##retorno o total de vendas processadas

end $$

delimiter  $$
create function rt_nome_cliente(vn_numeclien int)
		returns varchar(50)
        
        begin
        
			declare nome varchar(50);
            
            select c_nomeclien into nome
				from comclien
			where n_numeclien = vn_numeclien;
            
            return nome;
            
            end $$
delimiter  ;

select rt_nome_cliente(1);

select c_codivenda,
	rt_nome_cliente(n_numeclien),
	d_datavenda
from comvenda
order by 2,3;

set global event_scheduler = on;

delimiter $$
create event processa_comissao
on schedule every 1 week starts "2015-03-01 23:38:00"
do
	begin
		call processa_comissionamento(
			current_date() - interval 7 day,
		current_date(), @a );
	end
$$
delimiter  ;

select c_codivenda Codigo,
		n_totavenda Total,
        n_vcomvenda Comissao
	from comvenda
	where
		d_datavenda between current_date() - interval 60 day
        and current_date();
        
alter event processa_comissao_event disable;#Para desabilitar o evento automatico

delimiter $$
create event processa_comissao_event
on schedule every 10 minute
starts current_timestamp()
ends current_timestamp() + interval 30 minute
do
	begin
    call processa_comissinamento(
		current_date() - interval 7 day,
	current_date(), @a);
end
$$

delimiter $$
create function rt_percentual_comissao(vn_n_numevende int)
returns float
deterministic
begin
	declare percentual_comissao float(10,2);
	select n_porcvende
	into percentual_comissao
	from convende
where n_numevende = vn_n_numevende;
return percentual_comissao;
end 
$$
demiliter  ;

delimiter $$
create trigger tri_vendas_bi
before insert on comvenda
for each row
begin
	declare percentual_comissao float(10,2);
	## busco o percentual de comissão que o vendedor deve
	## receber
	select rt_percentual_comissao(new.n_numevende)
	into percentual_comissao;
	## calculo a comissão
	set valor_comissao = ((total_venda * comissao) / 100);
	## recebo no novo valor de comissão
	set new.n_vcomvenda = valor_comissao;
end
$$
delimiter ;

delimiter $$
create trigger tri_vendas_bu
before update on comvenda
for each row
begin
	declare percentual_comissao float(10,2);
	declare total_venda float(10,2);
	declare valor_comissao float(10,2);
		## No update, verifico se o valor total novo da venda
		## é diferente do total anterior, pois se forem iguais,
		## não há necessidade do cálculo
		if (old.n_totavenda <> new.n_totavenda) then
			select rt_percentual_comissao(new.n_numevende)
			into percentual_comissao;
			## cálculo da comissão
			set
			valor_comissao = ((total_venda * comissao) / 100);
			## recebo no novo valor de comissão
			set new.n_vcomvenda = valor_comissao;
		end if;
end
$$
delimiter ;

delimiter $$
create trigger tri_vendas_ai
after insert on comivenda
for each row
begin
	## declaro as variáveis que utilizarei
	declare vtotal_itens float(10,2);
	declare vtotal_item float(10,2);
	declare total_item float(10,2);
	## cursor para buscar os itens já registrados da venda
	declare busca_itens cursor for
	select n_totaivenda
	from comivenda
	where n_numevenda = new.n_numevenda;
	## abro o cursor
	open busca_itens;
	## declaro e inicio o loop
	itens : loop
	fetch busca_itens into total_item;
	## somo o valor total dos itens(produtos)
	set vtotal_itens = vtotal_itens + total_item;
	end loop itens;
    close busca_itens;
	## atualizo o total da venda
	update comvenda set n_totavenda = vtotal_itens
	where n_numevenda = new.n_numevenda;
end
$$
delimiter ;

mysql> delimiter $$
mysql> create trigger tri_ivendas_au
after update on comivenda
for each row
begin
	## declaro as variáveis que utilizarei
	declare vtotal_itens float(10,2);
	declare vtotal_item float(10,2);
	declare total_item float(10,2);
	## cursor para buscar os itens já registrados da venda
	declare busca_itens cursor for
	select n_totaivenda
	from comivenda
	where n_numevenda = new.n_numevenda;
	## verifico se há necessidade de alteração
	## faço somente se o novo valor for alterado
	if new.n_valoivenda <> old.n_valoivenda then
		## abro o cursor
		open busca_itens;
		## declaro e inicio o loop
		itens : loop
		fetch busca_itens into total_item;
		## somo o valor total dos itens(produtos)
		set vtotal_itens = vtotal_itens + total_item;
		end loop itens;
		close busca_itens;
		## atualizo o total da venda
		update comvenda set n_totavenda = vtotal_itens
		where n_numevenda = new.n_numevenda;
	end if;
end
$$
delimiter ;

delimiter $$
create trigger tri_ivendas_af
after delete on comivenda
for each row
begin
	## declaro as variáveis que utilizarei
	declare vtotal_itens float(10,2);
	declare vtotal_item float(10,2);
	declare total_item float(10,2);
	## cursor para buscar os itens já registrados da venda
	declare busca_itens cursor for
	select n_totaivenda
	from comivenda
	where n_numevenda = old.n_numevenda;
	## abro o cursor
	open busca_itens;
	## declaro e inicio o loop
	itens : loop
	fetch busca_itens into total_item;
	## somo o valor total dos itens(produtos)
	set vtotal_itens = vtotal_itens + total_item;
	end loop itens;
	close busca_itens;
	## atualizo o total da venda
	update comvenda set n_totavenda = vtotal_itens
	where n_numevenda = old.n_numevenda;
end
$$
delimiter ;

delimiter $$
create trigger tri_vendas_bf
before delete on comvenda
for each row
begin
	## declaro as variáveis que utilizarei
	declare vtotal_itens float(10,2);
	declare vtotal_item float(10,2);
	declare total_item float(10,2);
	## verifico se há necessidade de alteração
	## faço somente se o novo valor for alterado
	## cursor para buscar os itens já registrados da venda
	declare busca_itens cursor for
	select n_totaivenda
	from comivenda
	where n_numevenda = old.n_numevenda;
	## abro o cursor
	open busca_itens;
	## declaro e inicio o loop
	itens : loop
		fetch busca_itens into total_item;
		## somo o valor total dos itens(produtos)
		set vtotal_itens = vtotal_itens + total_item;
	end loop itens;
	close busca_itens;
	## atualizo o total da venda
	delete from comivenda where n_numevenda = venda;
end
$$
delimiter  ;

create table comclien(
		n_numeclien int not null auto_increment,
		c_codiclien varchar(10),
		c_nomeclien varchar(200),
        c_razaclien varchar(200),
		d_dataclien date,
		c_cnpjclien varchar(15),
		c_foneclien varchar(15),
		primary key (n_numeclien),
		index idx_comclien_2(c_codiclien));
        
alter table comclien add
	index idx_comclien_3(c_razaclien);
alter table comclien add
	index idx_comclien_4(c_codiclien);
    
alter table comvenda add unique
index idx_comvenda_1(c_codivenda);

create or replace view clientes_vendas as
	select c_razaclien,
    c_nomeclien,
	c_cnpjclien,
	c_codivenda,
	n_totavenda,
	d_datavenda
	from comclien,
	comvenda
	where comclien.n_numeclien = comvenda.n_numeclien
	order by 1;















