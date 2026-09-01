-- Aula 2 MySQL
-- ===================================
-- Conteúdos:
-- UPDATE
-- DELETE
-- COUNT
-- AVG
-- MIN
-- MAX
-- SUM
-- GROUP BY
-- HAVING
-- ORDER BY em consultas agrupadas
-- ==================================

-- Usar o banco
USE universidade;

-- 1. Retomada da Aula 1
-- Relembrar SELECT, WHERE e ORDER BY
SELECT * FROM alunos;

-- Mostrar apenas nome e curso
SELECT nome, curso FROM alunos;

-- Filtrar alunos do curso ADS
SELECT * FROM alunos WHERE curso ="ADS";

-- Filtrar alunos com idade entre 21 e 23
SELECT * FROM alunos WHERE idade BETWEEN 21 AND 23;

-- Ordenar aluno da menor para maior idade
SELECT * FROM alunos ORDER BY idade ASC;
SELECT * FROM alunos ORDER BY idade DESC;

-- Ordenar por curso e depois por nome
SELECT * FROM alunos ORDER BY curso, nome;

-- ==========================
-- 2. Inserir mais Registros
INSERT INTO alunos(nome, curso, idade)
VALUES
("Fernanda", "ADS", 22),
("Pedro", "Engenharia", 24),
("Juliana", "Ciência de Dados", 23),
("Rafael", "ADS", 21),
("Camila", "Engenharia", 22),
("Bruno", "Ciência de Dados", 25),
("Larissa", "ADS", 20),
("Patricia", "ADS", 24),
("Daniel", "Engenharia", 26),
("Marcos", "Ciência de Dados", 21);

-- VERIFICAR COMO FICOU A TABELA
SELECT * FROM alunos ORDER BY idade;

-- ==========================
-- 3. UPDATE
-- UPDATE altera registra
UPDATE alunos SET curso = "Ciência de Dados" WHERE id=15;

-- Alterar idade da ana
SET SQL_SAFE_UPDATES = 0;
UPDATE alunos SET idade = 22 WHERE nome = "Ana";

-- Verificar
SELECT * FROM alunos WHERE nome="Ana";

-- Exemplo 2: Alterar o curso do João
UPDATE alunos SET curso = 'Ciência de Dados' WHERE nome = 'João';
SELECT * FROM alunos WHERE nome='João';

-- Exemplo 3: Aumentar em 1 ano na idade dos alunos de ADS
UPDATE alunos SET idade = idade + 1 WHERE curso = 'ADS';
SELECT * FROM alunos WHERE curso = 'ADS' ORDER BY idade;

-- Atenção: SEM WHERE, todos os registros serão alterados
-- UPDATE alunos
-- SET idade = 30; -- Jamais!!!

-- ======================================================
-- 4. DELETE: Remove registros da tabela
-- Sintaxe: 
-- DELETE FROM nome_tabela
-- WHERE condição;
-- ======================================================

-- Antes de apagar, visualizar Rafael
SELECT * FROM alunos WHERE nome='Rafael';
DELETE FROM alunos WHERE nome='Rafael';
SELECT * FROM alunos;

-- Exemplo 2: Excluir alunos com idade menor que 21
SELECT * FROM alunos WHERE idade < 21;
DELETE FROM alunos WHERE idade < 21;
SELECT * FROM alunos ORDER BY idade;

-- Atenção: Sem WHERE, todos os registros serão apagados
-- Exemplo perigoso:
-- DELETE FROM nome_tabela; 

-- ====================================
-- 5. FUNÇÕES DE AGREGAÇÃO
-- Servem para resumir dados
-- ====================================

-- Contar as linhas da tabela
SELECT COUNT(*) AS total_alunos FROM alunos;

-- COUNT com filtro, curso de ADS
SELECT COUNT(*) AS total_ads FROM alunos WHERE curso='ADS';

-- AVG: Média das idades
SELECT ROUND(AVG(idade),2) AS media_idade FROM alunos;

-- MIN: menor idade
SELECT MIN(idade) AS menor_idade FROM alunos;

-- MAX: Maior idade
SELECT MAX(idade) AS maior_idade FROM alunos;

-- SUM: Somar idade
SELECT SUM(idade) AS soma_idades FROM alunos;

-- Várias funções juntas
SELECT 
	COUNT(*) as quantidade_linhas,
	ROUND(AVG(idade), 2) as media_idade,
	MIN(idade) as menor_idade,
	MAX(idade) as maior_idade 
FROM alunos WHERE curso='ADS';

-- =============================================
-- 6. GROUP BY: Agrupa linhas com valores iguais
-- =============================================

-- Quantidade de alunos por curso
SELECT curso, COUNT(*) AS quantidade_curso FROM alunos GROUP BY curso;

-- Quantidade de alunos por idade
SELECT idade, COUNT(*) AS quantidade_idade FROM alunos GROUP BY idade ORDER BY idade;
 
-- Média da idade por curso
SELECT curso, ROUND(AVG(idade),2) AS media_idade FROM alunos GROUP BY curso;

-- Menor idade por curso
SELECT curso, MIN(idade) AS menor_idade FROM alunos GROUP BY curso;

-- Maior idade por curso
SELECT curso, MAX(idade) AS maior_idade FROM alunos GROUP BY curso;

-- Soma das idade por curso
SELECT curso, SUM(idade) AS soma_idade FROM alunos GROUP BY curso;

-- ==================================================================
-- 7. ORDER BY junto com o GROUP BY: Ordenar o resultado já agrupado!
-- ==================================================================

-- Quantidade de alunos por curso, do maior para o menor
SELECT curso, COUNT(*) quantidade FROM alunos GROUP BY curso ORDER BY quantidade DESC;

-- Média de idade por curso, da maior para a menor
SELECT curso, ROUND(AVG(idade),2) AS media_idade_curso FROM alunos GROUP BY curso ORDER BY media_idade_curso DESC;
SELECT curso, ROUND(AVG(idade),2) AS media_idade_curso FROM alunos GROUP BY curso ORDER BY ROUND(AVG(idade),2) DESC;

-- Ordenar cursos em ordem alfabética
SELECT curso, COUNT(*) AS quantidade FROM alunos GROUP BY curso ORDER BY curso; 

-- ========================================
-- 8. HAVING: Após o agrupamento/GROUP BY
-- ========================================

-- Mostra apenas cursos com mais de 2 alunos
SELECT curso, COUNT(*) AS quantidade FROM alunos GROUP BY curso HAVING quantidade > 2;

-- Mostrar apenas idades com mais de 2 alunos
SELECT idade, COUNT(*) AS quantidade FROM alunos GROUP BY idade HAVING quantidade > 2 ORDER BY idade;

-- Mostrar cursos com média de idade maior que 22
SELECT curso, ROUND(AVG(idade),2) AS media_idade FROM alunos GROUP BY curso HAVING media_idade > 22 ORDER BY media_idade;

-- Mostrar cursos cuja soma da idade é maior que 40
SELECT curso, SUM(idade) AS soma_idade FROM alunos GROUP BY curso HAVING soma_idade > 40 ORDER BY soma_idade;

-- ======================================================================================================
-- 9. WHERE X HAVING - WHERE filtra linhas antes do agrupamento, HAVING filtra grupos após o agrupamento
-- ======================================================================================================

-- Primeiro filtra linhas
-- Depois agrupa
SELECT curso, COUNT(*) AS quantidade FROM alunos WHERE idade > 22 GROUP BY curso;

-- Primeiro Agrupa
-- Depois filtra
SELECT curso, COUNT(*) AS quantidade FROM alunos GROUP BY curso HAVING quantidade > 2;

-- Exemplo combinando WHERE e HAVING
SELECT curso, COUNT(*) AS quantidade FROM alunos WHERE idade>=22 GROUP BY curso HAVING quantidade >= 2;

-- Exemplo com média
SELECT curso, AVG(idade) AS media_idade FROM alunos WHERE idade >=22 GROUP BY curso HAVING media_idade >= 23;

-- ==========================================
-- 10. RELATÓRIOS MAIS COMPLETOS
-- Misturando conteúdos da aula 1 e aula 2
-- ==========================================

-- Curso e quantidade de alunos descrecente
SELECT curso, COUNT(*) AS quantidade FROM alunos GROUP BY curso ORDER BY quantidade DESC;

-- Quantidade de alunos por curso, considerando apenas idade maior de 21
SELECT curso, COUNT(*) AS quantidade FROM alunos WHERE idade > 21 GROUP BY curso ORDER BY quantidade; 

-- Mostrar apenas cursos com pelo menos 2 alunos
SELECT curso, COUNT(*) AS quantidade FROM alunos GROUP BY curso HAVING quantidade > 2;

-- Quantidade de alunos por idade;
SELECT idade, COUNT(*) AS quantidade FROM alunos GROUP BY idade ORDER BY idade;

-- Média de idade por curso
SELECT curso, ROUND(AVG(idade),2) AS media_idade FROM alunos GROUP BY curso ORDER BY media_idade;

-- Maior e menor idade do curso
SELECT curso, MAX(idade) AS maior_idade, MIN(idade) AS menor_idade FROM alunos GROUP BY curso ORDER BY curso;

-- Relatório completo por curso
SELECT 
	curso,
    COUNT(*) AS quantidade_alunos,
    MIN(idade) AS menor_idade,
    MAX(idade) AS maior_idade,
    SUM(idade) AS soma_idade,
    ROUND(AVG(idade),2) AS media_idade
FROM alunos GROUP BY curso ORDER BY curso;