create database revisao
use revisao

create table Produtos(
id_produto int primary key identity,
nome_produto varchar(100) not null,
estoque int not null,
preco decimal(10,2) not null,
)

create table HistoricoProdutos(
id_historico int primary key identity,
id_produto int,
foreign key (id_produto) references Produtos(id_produto),
data_alteracao datetime not null,
quantidade_anterior int,
quantidade_nova int
)

create trigger atualizacao
on Produtos
for update
as
begin
	DECLARE @id_produto int;
	DECLARE @data_alteracao int;
	DECLARE @quantidade_anterior int;
	DECLARE @quantidade_nova int;

select
	@id_produto = id_produto,
	@quantidade_anterior = estoque
from deleted;

select
	@quantidade_nova = estoque
from Produtos
where 
	@id_produto = id_produto;

insert into HistoricoProdutos(id_produto, data_alteracao, quantidade_anterior, quantidade_nova)
values (@id_produto, GETDATE(), @quantidade_anterior, @quantidade_nova)

end;



insert into Produtos(nome_produto, estoque, preco)
values ('macarrão', 10, '10.99')

insert into Produtos(nome_produto, estoque, preco)
values ('hamburguer', 10, '25.00')

insert into Produtos(nome_produto, estoque, preco)
values ('strogonoff', 20, '30.00')

update Produtos
set estoque = 40
where id_produto = 3;

select * from HistoricoProdutos
select * from Produtos

