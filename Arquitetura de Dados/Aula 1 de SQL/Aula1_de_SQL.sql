-- Apagar o banco de dados caso ele já existe
DROP DATABASE IF EXISTS universidade;

-- Criar banco de dados
CREATE DATABASE universidade;

-- Selecionar o banco para uso
USE universidade;

-- Criar tabela alunos
CREATE TABLE alunos(
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
curso VARCHAR(100) NOT NULL,
idade INT NOT NULL CHECK(idade>=0)
);

-- Para excluir a tabela, por favor, não rodar!
DROP TABLE alunos;

-- Inserir Regitros na tabela
INSERT INTO alunos (nome, curso, idade)
VALUES('Ana', 'Ciência de Dados', 21);

INSERT INTO alunos (nome, curso, idade)
VALUES('Carlos', 'Engenharia', 23);

INSERT INTO alunos (nome, curso, idade)
VALUES('Maria', 'ADS', 20);

INSERT INTO alunos (nome, curso, idade)
VALUES('João', 'ADS', 25);

-- Visualizar todos os registros
SELECT * FROM alunos;

-- Visualizar apenas a coluna nome
SELECT nome FROM alunos;

-- Visualizar nome e curso
SELECT nome, curso FROM alunos;

-- Filtrar alunos maiores de 21 anos
SELECT * FROM alunos WHERE idade > 21;

-- Filtrar alunos igual ou maiores a 21 anos 
SELECT * FROM alunos WHERE idade >= 21;

-- Filtrar alunos do curso de ADS
SELECT * FROM alunos WHERE curso = 'ADS';

-- Filtrar alunos com idade entre um intervalo
SELECT * FROM alunos WHERE idade BETWEEN 21 AND 23;

-- Outra forma de filtrar intervalo
SELECT * FROM alunos WHERE idade >= 21 and idade <= 23;

-- Ordenar alunos pela idade
SELECT * FROM alunos ORDER BY idade;

-- Ordenar alunos pela idade (maior para o menor)
SELECT * FROM alunos ORDER BY idade DESC;