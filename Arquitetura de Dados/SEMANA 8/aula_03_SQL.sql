CREATE DATABASE atividades;
USE atividades;

-- 1 - Criar tabela
CREATE TABLE funcionarios(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100),
    departamento VARCHAR(100),
    idade INT,
    salario DECIMAL(10,2)
);

-- 2 - Inserir funcionários
INSERT INTO funcionarios(nome, departamento, idade, salario)
VALUES
("Ana", "TI", 28, 5000),
("Bruno", "RH", 39, 3200),
("Carla", "Financeiro", 45, 4500),
("Daniel", "TI", 32, 5500),
("Eduarda", "Administrativo", 59, 2800),
("Felipe", "Financeiro", 29, 4700),
("Gabriela", "RH", 28, 3100),
("Henrique", "TI", 42, 6000);

-- 3 - Mostrar os funcionários
SELECT * FROM funcionarios;

-- 4. Mostrar funcionários em ordem descrecente
SELECT * FROM funcionarios ORDER BY salario DESC;

-- 5. Atualizar salário da Gabriela
UPDATE funcionarios SET salario = 3300 WHERE id=7;
SELECT * FROM funcionarios WHERE id=7;

-- 6. Mudar o departamento do Bruno
UPDATE funcionarios SET departamento = "TI" WHERE id=2;
SELECT * FROM funcionarios WHERE id=2;

-- 7. Demitindo a Eduarda, coitada...
DELETE FROM funcionarios WHERE id = 5;
SELECT * FROM funcionarios;

-- 8. Contar quantos funcionários existem na empresa
SELECT COUNT(*) AS total_funcionarios FROM funcionarios;

-- 9. Mostrar quantidade de funcionários por departamento
SELECT departamento, COUNT(*) AS total_por_departamento FROM funcionarios GROUP BY departamento; 

-- 10. Mostrar média salarial por departamento
SELECT departamento, ROUND(AVG(salario),2) AS media_salarial FROM funcionarios GROUP BY departamento;

-- 11. Salário total por departamento
SELECT departamento, SUM(salario) AS total_salario FROM funcionarios GROUP BY departamento;

-- 12. Relatório por departamento
SELECT departamento, 
COUNT(*) AS total_pessoas_departamento,
ROUND(AVG(salario),2) AS media_salario,
MAX(salario) AS maior_salario,
MIN(salario) AS menor_salario,
SUM(salario) AS total_salario FROM funcionarios GROUP BY departamento;

-- 13. Mostrar Apenas departamentos
SELECT departamento, COUNT(*) AS total_funcionarios, ROUND(AVG(salario),2) AS media_salario FROM funcionarios GROUP BY departamento HAVING total_funcionarios > 1 AND media_salario > 3000;

-- 14. Ordene o relatório pelo total pago, do maior para o menor
SELECT departamento, 
COUNT(*) AS total_pessoas_departamento,
ROUND(AVG(salario),2) AS media_salario,
MAX(salario) AS maior_salario,
MIN(salario) AS menor_salario,
SUM(salario) AS total_salario FROM funcionarios GROUP BY departamento ORDER BY total_salario DESC;

-- 15. RESPOSTA: O departamento de TI é o mais caro da empresa, pois a soma de todos os salário resulta em R$19.700,00 - Superior a soma dos outros dois departamentos juntos




-- Atividade 2 - Vendas:
-- 1. Criar tabela e inserir 8 registros
CREATE TABLE vendas(
	id INT PRIMARY KEY AUTO_INCREMENT,
	produto VARCHAR(100),
	categoria VARCHAR(100),
	quantidade INT,
	valor DECIMAL(10,2)
);

INSERT INTO vendas(produto, categoria, quantidade, valor)
VALUES
("Notebook", "Eletronicos", 2, 3500),
("Mouse", "Eletronicos", 5, 80),
("Mesa", "Moveis", 1, 900),
("Cadeira", "Moveis", 4, 450),
("Curso SQL", "Educacao", 10, 200),
("Livro Python", "Educacao", 6, 120),
("Monitor", "Eletronicos", 3, 1200),
("Estante", "Moveis", 2, 700);

-- 2. Mostrar todas as vendas:
SELECT * FROM vendas;

-- 3. Mostre todos os produtos ordenados do maior valor para o menor
SELECT * FROM vendas ORDER BY valor DESC;

-- 4. O Livro Python teve um aumento de 25% no valor, atualizar e verificar a alteração (No caso o produto que custava 120 passrá a custar 150)
UPDATE vendas SET valor=valor * 1.25 WHERE id=6; 
SELECT produto, valor FROM vendas WHERE id=6;

-- 5. Excluindo a mesa da tabela
DELETE FROM vendas WHERE id=3;
SELECT * FROM vendas;

-- 6. Contar quantas vendas existem (Total de produtos/Total de vendas):
SELECT COUNT(*) AS total_produto FROM vendas;
SELECT SUM(quantidade) AS total_estoque FROM vendas;

-- 7. Mostrar quantidade de vendas por categoria
SELECT categoria, SUM(quantidade) AS total_vendas FROM vendas GROUP BY categoria;

-- 8. Mostre o valor médio por categoria
SELECT categoria, ROUND(AVG(valor),2) AS media_vendas FROM vendas GROUP BY categoria;

-- 9. Mostre o valor total por categoria
SELECT categoria, SUM(valor) AS total_categoria FROM vendas GROUP BY categoria;

-- 10. Monte um relatório por categoria (Lembrando que o valor total de venda por categoria precisa multiplicar 
-- a coluna valor com a coluna quantidade, assim vamos ter o valor total do que foi vendido!
SELECT categoria, 
SUM(quantidade) AS quant_vendas_categ,
ROUND(AVG(valor),2) AS media_valor,
MAX(valor) AS maior_valor,
MIN(valor) AS menor_valor,
SUM(valor * quantidade) AS valor_total FROM vendas GROUP BY categoria;

-- 11. Mostrar categorias que possuem mais de uma venda
SELECT categoria, SUM(quantidade) AS quant_vendas FROM vendas GROUP BY categoria HAVING quant_vendas > 2;

-- 12. Ordene as categorias pelo valor total vendido em ordem descrecente!
SELECT categoria, SUM(valor * quantidade) AS total_vendas FROM vendas GROUP BY categoria ORDER BY total_vendas DESC;



-- ATIVIDADE 3 - IMPACTO NA ATIVIDADE 1
-- 1. Atualizar o salário do Bruno!
SELECT * FROM funcionarios;

UPDATE funcionarios SET salario = 4000 WHERE id=2;
SELECT * FROM funcionarios WHERE id=2;

-- 2. Demitir a Gabriela
SELECT * FROM funcionarios;
DELETE FROM funcionarios WHERE id=7;
SELECT * FROM funcionarios;

-- 3. Executar o relatório novamente!
SELECT departamento, 
COUNT(*) AS total_pessoas_departamento,
ROUND(AVG(salario),2) AS media_salario,
MAX(salario) AS maior_salario,
MIN(salario) AS menor_salario,
SUM(salario) AS total_salario FROM funcionarios GROUP BY departamento;

-- 4. Responder:
-- O que mudou nos resultados? - O setor de RH desapareceu, existem apenas 6 funcionários na empresa, a média de salario da área de TI aumentou e o menor salário da área que era 3200 do Bruno, passou a ser 4000.
-- Qual operação teve maior impacto? - O UPDATE, pois ele alterou mais de um valor no relatório final, enquanto o delete apenas excluiu uma funcionária do setor de RH.



-- ATIVIDADE 4 - Conceitual: WHERE vs HAVING
-- 1. Mostrar apenas alunos com idade maior que 21
-- RESPOSTA: WHERE - Porque ele ordena e filtra colunas, não agrupamentos!
-- Exemplo:
SELECT * FROM funcionarios WHERE idade > 32;

-- 2. Mostrar apenas cursos com mais de 2 alunos
-- RESPOSTA: HAVING - Ele é usado para filtrar agrupamentos, como nesse agrupamento de alunos por curso!
-- Exemplo:
SELECT departamento, COUNT(*) AS total_func_depart FROM funcionarios GROUP BY departamento HAVING total_func_depart > 2;

-- 3. Mostrar apenas funcionários do departamento de TI
-- RESPOSTA: WHERE - Aqui estamos filtrando os funcionários por departamento especifíco, para isso não é necessário unir o departamento com os funcionários, apenas selecionar os funcionários que estão no departamento desejado! 
-- Exemplo:
SELECT * FROM funcionarios WHERE departamento ="TI";

-- 4. Mostrar apenas departamentos com média salarial maior que 4000
-- RESPOSTA: HAVING - Aqui nós precisamos unir a coluna de salários com a culuna de departamentos, para calcular a média salarial dos departamentos e a partir dessa união podemos aplicar o filtro da média!
-- Exemplo:
SELECT departamento, ROUND(AVG(salario),2) AS media_salario FROM funcionarios GROUP BY departamento HAVING media_salario > 4000;

DROP TABLE funcionarios;
DROP TABLE vendas;
DROP DATABASE atividades;