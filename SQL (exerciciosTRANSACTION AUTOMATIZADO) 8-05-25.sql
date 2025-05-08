--EXERCICIO 1-----------------------------------------------------------------------------------------------------------------------

--Desenvolva uma stored procedure que realize uma transação para atualizar o estoque de
--produtos em uma loja online. A transação deve primeiro verificar se há estoque disponível para o produto
--em questão. Se houver estoque disponível, a stored procedure deve diminuir a quantidade disponível
--pelo número de unidades vendidas e registrar a transação de venda. Se não houver estoque suficiente, a
--transação deve ser revertida

create database exTransationProcedure1
use exTransationProcedure1

create table Produto (
	id_produto int primary key identity,
	nome varchar(50),
	estoque int
);

insert into Produto (nome, estoque)
values ('macarrão', 50)



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

--EXERCICIO 2-----------------------------------------------------------------------------------------------------------------------
--Desenvolva uma stored procedure para gerenciar o processo de reserva de salas de aula em uma
--universidade. A transação deve garantir que a reserva seja concluída apenas se a sala estiver disponível
--no horário solicitado e se o aluno estiver matriculado na disciplina correspondente à sala. A stored
--procedure deve verificar se a sala está disponível e se o aluno está matriculado na disciplina antes de
--realizar a reserva. Caso a sala não esteja disponível ou o aluno não esteja matriculado na disciplina
--correspondente, a transação deve ser revertida.


create database exTransationProcedure2
use exTransationProcedure2

