-- Criar a tabela
CREATE TABLE professores(
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
disciplina VARCHAR(100) NOT NULL,
idade INT NOT NULL
);

-- Adicionar os professores na tabela!
INSERT INTO professores(nome, disciplina, idade)
VALUES('Enzo', 'Matemática', 18);

INSERT INTO professores(nome, disciplina, idade)
VALUES('Bruna', 'Ciências', 28);

INSERT INTO professores(nome, disciplina, idade)
VALUES('Lopes', 'Geografia', 19);

INSERT INTO professores(nome, disciplina, idade)
VALUES('Anderson', 'História', 36);

INSERT INTO professores(nome, disciplina, idade)
VALUES('Pedro', 'Artes', 44);

INSERT INTO professores(nome, disciplina, idade)
VALUES('Otávio', 'Inglês', 37);

INSERT INTO professores(nome, disciplina, idade)
VALUES('Ana', 'Português', 39);

-- Mostrar os professores!
SELECT * FROM professores;

-- Mostrar somente os nomes!
SELECT nome FROM professores;

-- Fitrar professores com idade maior que 35
SELECT * FROM professores WHERE idade > 35;

-- Filtrar professores com idade entre 30 e 40 anos
SELECT * FROM professores WHERE idade BETWEEN 30 AND 40;

-- Ordenar os professores pela idade!
SELECT * FROM professores ORDER BY idade;

-- Ordenar ao contrário
SELECT * FROM professores ORDER BY idade DESC;