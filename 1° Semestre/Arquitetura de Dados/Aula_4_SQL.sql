-- Aula 3 - SQL
-- FOREIGN KEY, RELACIONAMENTOS E JOIN

DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola;
USE escola;

-- 1 - Tabela Cursos (1:N)
-- Um curso pode ter vários alunos
CREATE TABLE  cursos(
id_curso INT PRIMARY KEY AUTO_INCREMENT,
nome_curso VARCHAR(100)
);

-- 3. INSERIR DADOS EM CURSO
INSERT INTO cursos(nome_curso) 
VALUES
('ADS'),
('Engenharia'),
('Direito'),
('Medicina'),
('Arquitetura');

SELECT * FROM cursos;

-- 4. TABELA DE ALUNOS
-- FOREIGN KEYS -> Liga com cursos
CREATE TABLE alunos(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(100),
    id_curso INT, 
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

SELECT * FROM alunos;

-- 5. INSERIR ALUNOS
INSERT INTO alunos(nome_aluno, id_curso) 
VALUES
('Ana', 1),
('João', 2),
('Maria', 2),
('Pedro', 3),
('Bianca', 2),
('Felipe', 4),
('Lucas', NULL);

SELECT * FROM alunos;

-- 6. TABELA DISCIPLINAS
CREATE TABLE disciplinas(
	id_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina VARCHAR(100) NOT NULL
);

SELECT * FROM disciplinas;

-- 7. INSERIR DISCIPLINAS
INSERT INTO disciplinas(nome_disciplina) 
VALUES
('SQL'),
('Python'),
('Power BI'),
('Estatística'),
('História');

SELECT * FROM disciplinas;

-- 8. TABELA INTERMEDIÁRIA
CREATE TABLE aluno_disciplina(
	id_aluno INT,
    id_disciplina INT,
    PRIMARY KEY (id_aluno, id_disciplina),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

SELECT * FROM aluno_disciplina;

-- 9. INSERIR RELACIONAMENTOS
INSERT INTO aluno_disciplina(id_aluno, id_disciplina)
VALUES 
(1,1),
(1,2),
(2,1),
(2,3),
(3,2),
(3,4),
(4,1),
(5,3),
(6,4);

SELECT * FROM aluno_disciplina;

-- 10. INNER JOIN
-- Só alunos com curso 
SELECT * FROM alunos as a INNER JOIN cursos as c ON a.id_curso = c.id_curso;
SELECT a.id_aluno, a.nome_aluno as aluno, c.nome_curso as cursos FROM alunos as a INNER JOIN cursos as c ON a.id_curso = c.id_curso;

-- 11. LEFT JOIN
-- Todos os alunos (Inclusive sem curso)

SELECT * FROM alunos as a LEFT JOIN cursos as c ON a.id_curso = c.id_curso;
SELECT a.nome_aluno as aluno, c.nome_curso as curso FROM alunos as a LEFT JOIN cursos as c ON a.id_curso = c.id_curso;

-- 12. RIGHT JOIN
-- Todos os cursos (Inclusive sem alunos)

SELECT * FROM alunos as a RIGHT JOIN cursos as c ON a.id_curso = c.id_curso;
SELECT a.nome_aluno as aluno, c.nome_curso as curso 
FROM alunos as a 
RIGHT JOIN cursos as c 
ON a.id_curso = c.id_curso;

-- OU INVERTER A CHAMADA DAS TABELAS E UTILIZAR LEFT JOIN!
SELECT a.nome_aluno as aluno, c.nome_curso as curso 
FROM cursos as c
LEFT JOIN alunos as a 
ON c.id_curso = a.id_curso;

-- 13. JOIN N:N (Aluno + Disciplina)
SELECT * 
FROM aluno_disciplina as ad 
INNER JOIN alunos as a 
ON ad.id_aluno = a.id_aluno 
INNER JOIN disciplinas as d 
ON ad.id_disciplina = d.id_disciplina;

SELECT 
a.nome_aluno as aluno, d.nome_disciplina as disciplina
FROM aluno_disciplina as ad 
INNER JOIN alunos as a 
ON ad.id_aluno = a.id_aluno 
INNER JOIN disciplinas as d 
ON ad.id_disciplina = d.id_disciplina;

-- 14. JOIN COMPLETO (ALUNO + CURSO + DISCIPLINA)
SELECT 
a.id_aluno,
a.nome_aluno as aluno,
c.nome_curso as curso,
d.nome_disciplina as disciplina
FROM aluno_disciplina as ad
INNER JOIN alunos as a
ON ad.id_aluno = a.id_aluno
INNER JOIN disciplinas as d
ON ad.id_disciplina = d.id_disciplina
INNER JOIN cursos as c
ON a.id_curso = c.id_curso ORDER BY id_aluno;

-- 15. ALUNOS SEM DISCIPLINA
SELECT a.nome_aluno as aluno,
d.nome_disciplina as disciplina
FROM alunos as a
LEFT JOIN aluno_disciplina as ad
ON a.id_aluno = ad.id_aluno
LEFT JOIN disciplinas as d
ON ad.id_disciplina = d.id_disciplina;

-- 16. DISCIPLINAS SEM ALUNOS
SELECT
*
FROM disciplinas as d
LEFT JOIN aluno_disciplina as ad
ON d.id_disciplina = ad.id_disciplina 
WHERE ad.id_aluno IS NULL; -- Aqui voê usa IS não =, por algum motivo o = não funciona!

-- ============================================================
-- 1. DISTINCT
-- "REMOVE VALORES REPETIDOS"
-- Apenas os cursos presentes na tabela alunos, sem repetição
-- ============================================================
SELECT DISTINCT id_curso
FROM alunos
WHERE id_curso IS NOT NULL;

-- ===========================================
-- 2. DISTINCT COM JOIN
-- Mostrar nome dos cursos que possuem alunos
-- ===========================================

SELECT DISTINCT c.nome_curso
FROM alunos as a
INNER JOIN cursos as c
ON a.id_curso = c.id_curso;

-- ==============================================================================
-- 3. DISTINCT COM MAIS DE UMA COLUNA
-- DISTINCT considera a combinação das colunas e não cada coluna separadamente
-- ==============================================================================
SELECT DISTINCT id_curso, nome_aluno 
FROM alunos 
WHERE id_curso IS NOT NULL;

-- ===========================================================
-- 4. LIMIT
-- Mostrar os 3 primeiros alunos (Ordem 'natural' dos dados)
-- ===========================================================
SELECT * FROM alunos 
LIMIT 3;

-- ==================================================
-- 5. ORDER BY + LIMIT
-- Mostrar os 3 primeiros alunos em ordem alfabética
-- ==================================================
SELECT * FROM alunos
ORDER BY nome_aluno
LIMIT 3;

-- =====================================
-- 6. MULTÍPLOS FILTROS COM AND
-- Aluno do curso 1 e Com id maior que 1
-- =====================================
SELECT * FROM alunos
WHERE id_curso = 2 AND id_aluno > 1;

-- =======================================
-- 7. MULTÍPLOS FILTROS COM OR
-- Alunos do curso 1 ou do 2
-- Basta uma das condições ser verdadeira
-- =======================================
SELECT * FROM alunos
WHERE id_curso = 1 OR id_curso = 2;

-- ===========================================
-- 8. AND + IS NOT NULL
-- Alunos que têm curso e pertence ao curso 2
-- ===========================================
SELECT * FROM alunos
WHERE id_curso = 2 AND id_curso IS NOT NULL;

-- =====================================
-- 9. AND + OR JUNTOS (SEM PARENTÊSES)
-- SQL Executa AND antes do OR
-- =====================================
SELECT * FROM alunos
WHERE id_curso = 1 OR id_curso = 2 AND id_aluno > 2;

-- ====================================
-- 10. AND + OR JUNTOS (COM PARENTÊSES)
-- ====================================
SELECT * FROM alunos
WHERE (id_curso = 1 OR id_curso = 2)
AND id_aluno > 2;

-- ================================================
-- 11. CONSULTA COMPLETA COM JOIN + FILTRO + ORDEM
-- ================================================
SELECT 
a.nome_aluno AS aluno,
c.nome_curso AS curso
FROM alunos AS a
LEFT JOIN cursos AS c
ON a.id_curso = c.id_curso
WHERE a.id_curso IS NOT NULL
ORDER BY c.nome_curso ASC, a.nome_aluno ASC;

-- ===============================
-- 12. GROUP BY 
-- Quantidade de alunos por curso
-- ===============================
SELECT 
c.nome_curso,
COUNT(a.id_aluno) AS quantidade_alunos
FROM cursos AS c
LEFT JOIN alunos AS a
ON c.id_curso = a.id_curso
GROUP BY c.nome_curso;

-- ==========================================
-- 13. HAVING
-- Mostrar apenas cursos com mais de 1 aluno
-- ==========================================
SELECT 
c.nome_curso,
COUNT(a.id_aluno) AS quantidade_aluno
FROM cursos AS c
LEFT JOIN alunos AS a
ON c.id_curso = a.id_curso
GROUP BY c.nome_curso
HAVING quantidade_aluno > 1;

-- ================================================
-- 14. CASE WHEN
-- Classificar alunos conforme possuem ou não curso
-- ================================================
SELECT
nome_aluno,
CASE
	WHEN id_curso IS NULL THEN 'Sem curso'
    ELSE 'Com curso'
    END AS situacao
FROM alunos;

-- =======================================
-- 15. CASE WHEN COM MAIS DE UMA CONDIÇÃO 
-- Classificar alunos conforme o curso
-- =======================================
SELECT 
nome_aluno,
	CASE
		WHEN id_curso = 1 THEN 'Curso ADS'
		WHEN id_curso = 2 THEN 'Curso Engenharia'
		WHEN id_curso = 3 THEN 'Curso Direito'
		WHEN id_curso = 4 THEN 'Curso Medicina'
		WHEN id_curso = 5 THEN 'Curso Arquitetura'
		ELSE 'Sem curso'
	END AS classificacao
FROM alunos
ORDER BY classificacao;

-- =============================================
-- 16. CASE WHEN + RELATÓRIO
-- Classificar cursos pela quantidade de alunos
-- =============================================
SELECT
	c.nome_curso,
    COUNT(a.id_aluno) AS total_alunos,
    CASE
		WHEN COUNT(a.id_aluno) >= 2 THEN 'Turma Maior'
        WHEN COUNT(a.id_aluno) = 1 THEN 'Turma Pequena'
        ELSE 'Sem alunos'
	END AS situacao_turma
FROM cursos AS c
LEFT JOIN alunos AS a
ON c.id_curso = a.id_curso
GROUP BY c.nome_curso;

-- =============================================
-- 17. CTE = Common Table Expression
-- Ajuda a organizar consultas mais complexas
-- =============================================
WITH alunos_com_curso AS(
	SELECT
		id_aluno,
        nome_aluno,
        id_curso
	FROM alunos
    WHERE id_curso IS NOT NULL
)

SELECT * FROM alunos_com_curso;

-- =============================================
-- 18. CTE + JOIN
-- Primeiro organizarmos os alunos com curso
-- Depois ligamos com a tabela cursos
-- =============================================
WITH alunos_com_curso AS(
	SELECT 
		id_aluno,
        nome_aluno,
        id_curso
    FROM alunos 
    WHERE id_curso IS NOT NULL
)
SELECT 
	ac.nome_aluno,
    c.nome_curso
FROM alunos_com_curso AS ac
INNER JOIN cursos c
ON ac.id_curso = c.id_curso;

-- ====================================================
-- 19. CTE + AGREGAÇÃO 
-- Calcular total de alunos por curso e depois filtrar
-- ====================================================
WITH total_por_curso AS(
	SELECT 
		id_curso,
		COUNT(*) AS total
	FROM alunos
    WHERE id_curso IS NOT NULL
    GROUP BY id_curso
)
SELECT * FROM total_por_curso
WHERE total > 1;

-- =======================================================
-- 20. WINDOW FUNCTION - ROW_NUMBER()
-- Gera uma numeração linha a linha, sem agrupar os dados
-- Vamos criar um ranking alfabético geral
-- =======================================================
SELECT 
	nome_aluno, 
	ROW_NUMBER() OVER(ORDER BY nome_aluno ASC) AS ranking_alfabetico
FROM alunos;

-- =============================================
-- 21. WINDOW FUNCTION COM PARTICION BY
-- A numeração RECOMEÇA dentro de cada curso
-- =============================================
SELECT
	nome_aluno,
    id_curso,
    ROW_NUMBER() OVER(
		PARTITION BY id_curso
        ORDER BY nome_aluno ASC
    ) AS ranking_no_curso
FROM alunos
WHERE id_curso IS NOT NULL;

-- =========================================================
-- 22. WINDOW FUNCTION COM RANK
-- Ranking dentro de cada curso
-- Ranking tem um comportamento diferente em casos de empate
-- =========================================================
SELECT
	nome_aluno,
    id_curso,
    RANK() OVER(
		PARTITION BY id_curso
        ORDER BY nome_aluno ASC
    ) AS ranking_no_curso
FROM alunos
WHERE id_curso IS NOT NULL;

-- =========================================================
-- 23. CONSULTA FINAL COMPLETA JOIN + CASE + ORDER BY
-- =========================================================
SELECT 
	a.nome_aluno AS aluno,
    c.nome_curso AS curso,
    CASE
		WHEN a.id_curso IS NULL THEN 'Sem curso'
        ELSE 'Com curso'
	END AS situacao
FROM alunos AS a
LEFT JOIN cursos AS c
ON a.id_curso = c.id_curso
ORDER BY a.nome_aluno ASC;