create database aulaTransacao

use aulaTransacao

create table Contas (
	id_conta int primary key,
	saldo decimal(10, 2)
);

insert into Contas (id_conta, saldo)
values(1, 1000.00);

insert into Contas (id_conta, saldo)
values (2, 500.00)

begin transaction;

update Contas
set saldo = saldo - 100 where id_conta = 1;
update Contas
set saldo = saldo + 100 where id_conta = 2;

rollback; --desfazer(voltar antes de dar begin)

commit; --confirmador

select * from Contas