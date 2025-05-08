--Desenvolva uma stored procedure que realize uma transa��o para atualizar o estoque de
--produtos em uma loja online. A transa��o deve primeiro verificar se h� estoque dispon�vel para o produto
--em quest�o. Se houver estoque dispon�vel, a stored procedure deve diminuir a quantidade dispon�vel
--pelo n�mero de unidades vendidas e registrar a transa��o de venda. Se n�o houver estoque suficiente, a
--transa��o deve ser revertida

create database exTransationProcedure1
use exTransationProcedure1

drop database exTransationProcedure1

create table Produto (
	id_produto int primary key identity,
	nome varchar(50),
	estoque int
);

insert into Produto (nome, estoque)
values ('macarr�o', 50)



create procedure atualizar_estoque
	@id_produto int,
	@perdaEstoque int
as
begin
	begin transaction;
	if ((select estoque from Produto WHERE id_produto = @id_produto) >= @perdaEstoque)
	begin
		update Produto
		set estoque = estoque - @perdaEstoque where id_produto = @id_produto;
		commit;	
		print 'estoque alterado';
	end
	else
	begin
		rollback;
		print 'estoque insufuciente';
	end
end;

exec atualizar_estoque
@id_produto = 1, @perdaEstoque = 90;

select * from Produto