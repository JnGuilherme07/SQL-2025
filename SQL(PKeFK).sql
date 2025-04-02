CREATE DATABASE teste

use teste

create table pessoa (
	id int primary key,
	nome varchar(50),
	sobrenome varchar(50)
)

create table compra (
	id int,
	foreign key (id) references pessoa(id),
	compra varchar(50),
	dataCompra date
)
select * from pessoa
select * from compra


insert into pessoa(id, nome, sobrenome)
values(1,'João Guilherme', 'Souza Couto');
insert into pessoa(id, nome, sobrenome)
values(2,'Luiz', 'Henrique');
insert into pessoa(id, nome, sobrenome)
values(3,'Jorge', 'Mateus');

insert into compra(id, compra, dataCompra)
values(1,'biscoito', '20-11-08');
insert into compra(id, compra, dataCompra)
values(2,'biscoito', '20-11-08');
insert into compra(id, compra, dataCompra)
values(3,'bolacha', '20-11-08');

select pessoa.nome as nome, compra.compra as compra, compra.dataCompra as data_da_compra
from compra join pessoa
on pessoa.id = compra.id
where pessoa.nome = 'Jorge';

