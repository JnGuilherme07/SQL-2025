--exercicio 1-----------------------------------------------------------

create database ac1ex1
use ac1ex1

CREATE TABLE Aluno (
AlunoID INT PRIMARY KEY,
NomeAluno VARCHAR(50),
Matricula varchar(50),
ano_letivo int
);

INSERT INTO Aluno (AlunoID, NomeAluno, Matricula, ano_letivo) 
VALUES 
(1, 'Aluno A', 'Matriculado', 2025), 
(2, 'Aluno B', 'Não Matriculado', 2025)

 
CREATE PROCEDURE ConfirmaMatricula
    @alunoID INT,
    @anoletivo INT
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @matriculas VARCHAR(50);
    SELECT @matriculas = Matricula
    FROM Aluno

    WHERE AlunoID = @alunoID;

    IF @matriculas = 'Não Matriculado'
    BEGIN
        UPDATE Aluno
        SET Matricula = 'Matriculado'
        WHERE AlunoID = @alunoID;
 
		INSERT INTO Aluno (AlunoID,Matricula, ano_letivo)
		VALUES (@alunoID, @matriculas, @anoletivo);
 
        COMMIT TRANSACTION;
        PRINT 'o aluno foi matriculado';
    END
    ELSE 
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Aluno já foi matriculado';
    END;
END;
 
 
EXEC ConfirmaMatricula @alunoID = 3 ,@anoletivo = 2025
select*from Aluno
 
 
--exercicio 2-----------------------------------------------------------
 
create database ac1ex2
use ac1ex2

create table Medicamento(
    id_medicamento int primary key identity,
    nome_medicamento varchar(100)
);
 
create table Paciente(
    id_paciente int primary key identity,
    nome_paciente varchar(50),
    id_medicamento int,
    foreign key (id_medicamento) references medicamento(id_medicamento),
    medicado varchar(50)
);
 
insert into Medicamento (nome_medicamento)
values
    ('Dipirona'),
    ('Amoxicilina'),
    ('Sinvastatina')
 
insert into Paciente(nome_paciente, medicado)
values
    ('Roberto', 'nao uso'),
    ('Bruna', 'nao uso'),
    ('Joao', 'nao uso')
 
create procedure verificar_paciente
    @id_paciente int,
    @nome_medicamento varchar(100)
as
begin
    begin transaction

    declare @medicado varchar(50)
    declare @id_medicamento int

    select @medicado = medicado, @id_medicamento = id_medicamento
    from Paciente
    where id_paciente = @id_paciente

    select @id_medicamento = id_medicamento
    from Medicamento
    where nome_medicamento = @nome_medicamento
 
	if @id_medicamento is null
	begin
		rollback transaction
		print 'medicamento não registrado'
		return
	end
    if @medicado = 'nao uso'
    begin
        update Paciente
        set medicado = @nome_medicamento, id_medicamento = @id_medicamento
        where id_paciente = @id_paciente
        commit transaction
        print 'medicacao alterada com exito'
    end
    else
    begin
        rollback transaction
        print 'o paciente ja esta medicado'
    end
end;
select * from Medicamento
exec verificar_paciente @id_paciente = 1, @nome_medicamento = 'Dipirona'
select * from Paciente