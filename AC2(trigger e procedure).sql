create database ac2rev
use ac2rev


create table Motoristas(
id_motoristas int primary key identity,
nome varchar(100) not null,
cnh int,
pontos_cnh int,
)

create table Carros(
id_carros int primary key identity,
palca varchar(100) not null,
modelo varchar(100),
ano date,
id_motoristas int,
foreign key (id_motoristas) references Motoristas(id_motoristas)
)

create table Multas (
id_multas int primary key identity,
id_carros int,
foreign key (id_carros) references Carros(id_carros),
data_multa date,
pontos int
)

create table Prontuarios(
id_prontuario int primary key identity,
id_motoristas int,
foreign key (id_motoristas) references Motoristas(id_motoristas),
id_multas int,
foreign key (id_multas) references Multas(id_multas),
data_assiciacao date
)

create trigger Vinculando_multa
on Multas
after Insert
as
begin
	declare @id_multas int;
	declare @id_carros int;
	declare @pontos int;
	declare @id_motoristas int
	
	select
	@id_multas = id_multas,
	@id_carros = id_carros,
	@pontos = pontos
	from inserted

	select
	@id_motoristas = id_motoristas
	from Carros
	where Carros.id_carros = @id_carros;

	insert into Multas(id_multas, id_carros, data_multa, pontos)
	values(@id_multas, @id_carros, GETDATE(), @pontos)

	update Motoristas
	set pontos_cnh = pontos_cnh + @pontos
	where Motoristas.id_motoristas = @id_motoristas

end;

CREATE PROCEDURE TodosMotoristasEMultas 
AS BEGIN 
SELECT Motoristas.nome, Carros.palca, Multas.data_multa, Multas.pontos 
FROM Motoristas 
JOIN Carros ON Motoristas.id_motoristas = Carros.id_motoristas
JOIN Multas ON Carros.id_carros = Multas.id_carros; 
END

CREATE PROCEDURE MotoristaESuasMultas 
@id_motoristas INT 
AS BEGIN 
SELECT Motoristas.Nome, Carros.palca, Multas.data_multa, Multas.pontos 
FROM Motoristas 
JOIN Carros ON Motoristas.id_motoristas = Carros.id_motoristas
JOIN Multas ON Carros.id_carros = Multas.id_carros
WHERE Motoristas.id_motoristas = @id_motoristas; 
END  

CREATE PROCEDURE TotalPontosCNH 
@id_motoristas INT 
AS BEGIN 
SELECT pontos_cnh
FROM Motoristas 
WHERE id_motoristas = @id_motoristas; 
END  


insert into Carros(palca, modelo, ano)
values
('2345', 'modelo2', '03-11-2009'),
('6789', 'modelo3', '21-11-2020'),
('3456','modelo4','07-03-2012'),
('1234', 'modelo1', '20-10-2008')

insert into Motoristas(nome, cnh, pontos_cnh)
values
('João', '123456', '0'),
('Pedro', '789123', '0'),
('Gustavo', '521422', '0'),
('Luana', '987654', '0')

select * from Carros
select * from Motoristas
