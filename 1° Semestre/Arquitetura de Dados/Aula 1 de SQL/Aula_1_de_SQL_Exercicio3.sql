CREATE DATABASE loja;
DROP TABLE produtos;

USE loja;

CREATE TABLE produtos(
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
categoria VARCHAR(50) NOT NULL,
preco DECIMAL(10,2) NOT NULL
);

-- ADICIONANDO PRODUTOS
INSERT INTO produtos(nome, categoria, preco)
VALUE('Tênis', 'Calçados', 250);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Condicionador', 'Higiene', 25.14);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Shampoo', 'Higiene', 38.99);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Caderno', 'Material Escolar', 50.49);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Garrafa', 'Acessório', 19.29);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Monitor', 'Gamer', 728.99);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Fone de Ouvido', 'Eletronicos', 145.99);

INSERT INTO produtos(nome, categoria, preco)
VALUE('Mouse', 'Eletronicos', 65.49);

-- Corrigindo categoria
UPDATE produtos
SET categoria = 'Gamer', categoria = 'Eletronicos'
WHERE id = 6;

-- Mostrando produtos
SELECT * FROM produtos;

-- Filtro preco > 100
SELECT * FROM produtos WHERE preco > 100;

-- Filtro de eletônicos
SELECT * FROM produtos WHERE categoria = 'Eletronicos';

-- Filtro com preco entre 50 e 200
SELECT * FROM produtos WHERE preco BETWEEN 50 AND 200;

-- Ordene os produtos pelo preço
SELECT * FROM produtos ORDER BY preco;