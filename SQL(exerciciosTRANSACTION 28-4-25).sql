create database exetransaction

use exetransaction

--Suponha que você tenha uma tabela Pedidos com os campos ID, ClienteID, Valor e Status. Crie uma
--transação que insira um novo pedido na tabela Pedidos com um valor de $500 para o cliente com ID igual
--a 3 e altere o status desse pedido para 'Pendente'. Em seguida, atualize o saldo do cliente com ID 3,
-- $500. No entanto, se o saldo do cliente ficar negativo após a atualização, faça um rollback da
--transação.

create table Cliente (
	id_cliente int primary key identity,
	saldo decimal(10, 2),
);

create table Pedidos (
	id int primary key identity,
	id_cliente int,
	foreign key (id_cliente) references Cliente(id_cliente),
	stat varchar(50)
);

insert into Cliente
values (1000.00)
insert into Cliente
values (900.00)
insert into Cliente
values (700.00)

insert into Pedidos(id_cliente, stat)
values (1, 'FEITO')
insert into Pedidos(id_cliente, stat)
values (2, 'FEITO')
insert into Pedidos(id_cliente, stat)
values (3, 'FEITO')

begin transaction;
update Cliente
set saldo = saldo - 500
where id_cliente = 3;
update Cliente
set saldo = saldo + 500
where id_cliente = 1;
update Pedidos
set stat = 'Pendente'
where id_cliente = 3;

rollback;
commit;

select * from Cliente
select * from Pedidos

------------------------------------------------------------------------------
create database exetransaction2

use exetransaction2

--Suponha que você tenha duas tabelas: Clientes e Pedidos, onde Pedidos possui uma chave estrangeira
--ClienteID referenciando Clientes.ID. Crie uma transação que insira um novo cliente na tabela Clientes e,
--em seguida, insira um novo pedido para esse cliente na tabela Pedidos. Certifique-se de que ambas as
--inserções tenham sucesso antes de confirmar a transação. Se ocorrer algum erro durante qualquer uma
--das inserções, reverta a transação

create table Clientes (
	id_clientes int primary key identity,
	nome varchar(100)
);

create table Pedidos (
	id_pedidos int primary key identity,
	id_clientes int,
	foreign key (id_clientes) references Clientes(id_clientes),
	nome varchar(100)
);

insert into Clientes
values ('João')
insert into Clientes
values ('Roberto')
insert into Clientes
values ('Ana')

insert into Pedidos(id_clientes, nome)
values (1, 'pedido1')
insert into Pedidos(id_clientes, nome)
values (2, 'pedido2')
insert into Pedidos(id_clientes, nome)
values (3, 'pedeido3')

select * from Clientes
select * from Pedidos

select Clientes.id_clientes as Cliente, Clientes.nome as Cliente, Pedidos.nome as Pedido
from Pedidos join Clientes
on Clientes.id_clientes = Pedidos.id_clientes


begin transaction;

insert into Clientes
values ('Paulo Ruttherford')
insert into Pedidos(id_clientes, nome)
values (4, 'pedido4')

rollback;
commit;