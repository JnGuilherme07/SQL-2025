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

CREATE TABLE Aluno (
AlunoID INT PRIMARY KEY,
NomeAluno VARCHAR(50)
);

CREATE TABLE SalasDeAula (
SalaID INT PRIMARY KEY,
NomeSala VARCHAR(50),
Disponivel INT --0 indiponovel, 1 disponivel
);

INSERT INTO Aluno (AlunoID, NomeAluno) VALUES
(1, 'João'),
(2, 'Maria');

INSERT INTO SalasDeAula (SalaID, NomeSala, Disponivel) VALUES
(1, 'Sala A', 1),
(2, 'Sala B', 1),
(3, 'Sala C', 0);


CREATE TABLE Disciplinas (
DisciplinaID INT PRIMARY KEY,
NomeDisciplina VARCHAR(50)
);

CREATE TABLE Matriculas (
AlunoID INT,
DisciplinaID INT,
PRIMARY KEY (AlunoID, DisciplinaID)
);

INSERT INTO Disciplinas (DisciplinaID, NomeDisciplina) VALUES
(1, 'Matemática'),
(2, 'História');


INSERT INTO Matriculas (AlunoID, DisciplinaID) VALUES
(1, 1);


CREATE PROCEDURE ReservarSalaDeAula
	@SalaID INT,
	@AlunoID INT,
	@DisciplinaID INT
AS
BEGIN

DECLARE @SalaDisponivel INT, @AlunoMatriculado INT;

BEGIN TRANSACTION;
	SELECT @SalaDisponivel = Disponivel
	FROM SalasDeAula
	WHERE SalaID = @SalaID;

	SELECT @AlunoMatriculado = COUNT(*)
	FROM Matriculas m
	INNER JOIN Disciplinas d ON m.DisciplinaID = d.DisciplinaID
	WHERE m.AlunoID = @AlunoID AND d.DisciplinaID = @DisciplinaID;

	IF @SalaDisponivel = 1 AND @AlunoMatriculado = 1
	BEGIN

		UPDATE SalasDeAula SET Disponivel = 0 WHERE SalaID = @SalaID;

		COMMIT;
		PRINT 'Reserva concluída com sucesso.';
	END

	ELSE 
	BEGIN
		ROLLBACK;
		PRINT 'Reserva não concluída. A sala não está disponível ou o aluno não está matriculado na disciplina correspondente.';
	END
END;



EXEC ReservarSalaDeAula @SalaID = 2, @AlunoID = 1, @DisciplinaID = 1;

update SalasDeAula set Disponivel=1 where SalaID=1

SELECT * FROM Aluno
SELECT * FROM SalasDeAula
SELECT * FROM Disciplinas
SELECT * FROM Matriculas

