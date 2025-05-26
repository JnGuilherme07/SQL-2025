create database subConsutas

use subConsutas

CREATE TABLE clientes (
 id_cliente INT PRIMARY KEY,
 nome VARCHAR(100),
 cidade VARCHAR(100)
);

CREATE TABLE pedidos (
 id_pedido INT PRIMARY KEY,
 id_cliente INT,
 valor DECIMAL(10, 2),
 data_pedido DATE,
 FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO clientes (id_cliente, nome, cidade) 
VALUES
(1, 'João', 'São Paulo'),
(2, 'Maria', 'Rio de Janeiro'),
(3, 'Pedro', 'Salvador');

INSERT INTO pedidos (id_pedido, id_cliente, valor, data_pedido) 
VALUES
(1, 1, 100.00, '2025-05-01'),
(2, 2, 150.00, '2025-05-02'),
(3, 3, 200.00, '2025-05-03'),
(4, 1, 50.00, '2025-05-04');


--os nomes dos clientes que o valor de seus pedidos foram maior que 100 reais
select nome from clientes
where id_cliente IN (	--IN mostra quantidade de vezes em que a pessoa gastou mais de 100 reais	
	select id_cliente from pedidos
	where valor > 100
);

--os nomes dos clientes que o valor de seus pedidos foram maior que 100 reais
select nome from clientes
where EXISTS (	--EXISTS mostra apenas se a pessoa gatou mais de 100 rais
	select 1 from pedidos
	where pedidos.id_cliente = clientes.id_cliente
	and pedidos.valor > 100
);

--nome do cliente e o valor do seu pedido mais caro.
SELECT nome,
 (SELECT MAX(valor)
 FROM pedidos
 WHERE id_cliente = clientes.id_cliente) AS maior_pedido
FROM clientes;

--MAX é o valor mais alto
--MIN é valor mais baixo
--AVG é média dos valores