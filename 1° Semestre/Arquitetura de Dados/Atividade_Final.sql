-- PARTE 1
DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa;
USE empresa;

CREATE TABLE departamentos(
	id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE funcionarios(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2),
    id_departamento INT,
    FOREIGN KEY(id_departamento) REFERENCES departamentos(id_departamento)
);

CREATE TABLE projetos(
	id_projeto INT PRIMARY KEY AUTO_INCREMENT,
    nome_projeto VARCHAR(100) NOT NULL
);

CREATE TABLE funcionario_projeto(
	id_funcionario INT,
    id_projeto INT,
    PRIMARY KEY(id_funcionario, id_projeto),
    FOREIGN KEY(id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY(id_projeto) REFERENCES projetos(id_projeto)
);

-- PARTE 2
INSERT INTO departamentos(nome_departamento) VALUES
('Tecnologia'),
('Financeiro'),
('Marketing'),
('Recursos Humanos'),
('Jurídico');

INSERT INTO funcionarios(nome_funcionario, cargo, salario, id_departamento) VALUES
('Ana', 'Analista', 4500.00, 1);