USE universidade;

DROP TABLE filmes;

CREATE TABLE filmes(
id INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL UNIQUE,
genero VARCHAR(50) NOT NULL,
duracao INT NOT NULL,
nacionalidade VARCHAR(50) NOT NULL,
personagem_principal VARCHAR(50) NOT NULL);

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Vingadores Ultimato', 'Heróis', 180, 'Americano', 'Capitão América');

UPDATE filmes
SET duracao = 120, duracao = 180
WHERE id = 1;

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Vingadores Ultimato', 'Heróis', 120, 'Americano', 'Capitão América');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Coraline', 'Animação', 90, 'Americano', 'Coraline');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Sherlock Holmes', 'Investigação', 100, 'Americano', 'Sherlock Holmes');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Agente Secreto', 'Ação', 172, 'Brasileiro', 'Wagner Moura');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Panico 7', 'Slasher', 88, 'Americano', 'GhostFace');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Ainda estou aqui', 'Drama', 140, 'Brasileiro', 'Fernanda Torres');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Pecadores', 'Drama', 100, 'Americano', 'Michael B. Jordan');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Tik Tik BOOM', 'Drama', 130, 'Americano', 'Andrew Garfield');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Todo mundo em pânico', 'Slasher', 86, 'Americano', 'Assassino');

INSERT INTO filmes(titulo, genero, duracao, nacionalidade, personagem_principal)
VALUES('Tudo em todo lugar ao mesmo tempo', 'Multiverso', 147, 'Americano', 'Evelyn');

-- Mostrando todos os filmes
SELECT * FROM filmes;

-- Títulos dos filmes
SELECT titulo FROM filmes;

-- Filtro com duração maior que 120
SELECT * FROM filmes WHERE duracao > 120;

-- Filtro com duração entre 90 e 150 minutos
SELECT * FROM filmes WHERE duracao BETWEEN 90 AND 150;

-- Filtro com nacionalidade brasileira
SELECT * FROM filmes WHERE nacionalidade = 'Brasileiro';

-- Ordenando filmes pela duração
SELECT * FROM filmes ORDER BY duracao;
