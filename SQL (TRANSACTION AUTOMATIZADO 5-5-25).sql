create database AutomatizacaoTransacao

use AutomatizacaoTransacao

Create table Clientes (
	id_clientes int primary key,
	nome varchar(100),
	saldo decimal(10,2)
);

insert into Clientes (id_clientes, nome, saldo)
values
	(1, 'Cliente A', 1000.00),
	(2, 'Cliente B', 500.00);

create procedure TransferirSaldoEntreClientes
	@clienteOrigem int,
	@clienteDestino int,
	@valorTransferencia DECIMAL(10,2)
as
begin

begin transaction TransferirSaldo;

	if((SELECT saldo from Clientes where id_clientes = @clienteOrigem) >=
	@valorTransferencia)
	begin

		update Clientes
		set saldo = saldo - @valorTransferencia
		where id_clientes = @clienteOrigem;

		update Clientes
		set saldo = saldo + @valorTransferencia
		where id_clientes = @clienteDestino;

		commit Transaction TransferirSaldo
		print 'Transferencia feita';
	end
	else
	begin
		rollback transaction TransfeirSaldo;
		print 'Saldo insuficiente';
	end
end;

exec TransferirSaldoEntreClientes 
@clienteOrigem = 1,@clienteDestino = 2,@valorTransferencia = 100.00;

select * from Clientes
