DROP TABLE IF EXISTS Ambulatorios, Medicos, Pacientes, Funcionarios, Consultas;

create table Ambulatorios (
    nroa int,
    andar numeric(2) not null,
    capacidade smallint, primary key(nroa)
);

create table Medicos (
    codm int,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar(40),
    CPF numeric(11) not null unique,
    especialidade varchar(30),
    nroa int,
    primary key(codm),
    foreign key(nroa) references Ambulatorios
);

create table Pacientes (
    codp int,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar(40), 
    CPF numeric(11) not null unique,
    doenca varchar(40) not null,
    primary key(codp)
);

create table Funcionarios (
    codf int,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar(40),
    CPF numeric(11) not null unique,
    salario numeric(10), primary key(codf)
);

create table Consultas (codm int,
    codp int,
    data date,
    hora time,
    primary key(codm, codp, data),
    foreign key(codm) references Medicos,
    foreign key(codp) references Pacientes
);

insert into Ambulatorios values
    (1,1,30),
    (2,1,50),
    (3,2,40),
    (4,2,25),
    (5,2,55);

insert into Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) values 
    (1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1), 
    (2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
    (3, 'Pedro', 51, 'pediatria', 11000100000, 'Sao Jose', 2),
    (4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', NULL),
    (5, 'Manoel', 52, 'neurologia', 11000220000, 'Palhoca', NULL);

insert into Pacientes (codp, nome, idade, cidade, CPF, doenca) values
    (1,'Ana', 21, 'Florianopolis', 20000200000, 'gripe'),
    (2,'Paulo', 24, 'Ilhota', 20000220000, 'fratura'),
    (3,'Lucia', 30, 'Biguacu', 22000200000, 'tendinite'),
    (4,'Carlos', 28, 'Joinville',11000110000, 'sarampo');

insert into Funcionarios (codf, nome, idade, CPF, cidade, salario) values
    (1,'Rita', 32, 20000100000, 'Sao Jose', 1200),
    (2,'Vera', 55, 30000110000, 'Palhoca', 1220),
    (3,'Caio', 45, 41000100000, 'Florianopolis', 1100),
    (5,'Paula', 33, 61000111000, 'Florianopolis', 2500);

insert into Consultas (codm, codp, data, hora) values 
    (1,1,'2020/10/12','14:00'),
    (1,4,'2020/11/04','12:00'),
    (2,1,'2020/10/13','09:00'),
    (2,2,'2020/10/13','11:00'),
    (2,3,'2020/10/14','14:00'),
    (2,4,'2020/10/14','17:00'),
    (3,1,'2020/10/19','18:00'),
    (3,3,'2020/10/12','10:00'),
    (3,4,'2020/10/19','14:30'),
    (4,4,'2020/10/20','13:00');

-- Responda o que se pede utilizando junção (não natural):
-- 1) Buscar o nome e CPF dos médicos que também são pacientes do hospital
SELECT Medicos.nome as nome, Pacientes.CPF as CPF FROM Medicos JOIN Pacientes ON Medicos.CPF = Pacientes.CPF;

-- 2) Buscar nomes de funcionários e de médicos (exibir pares de nomes) que residem na mesma cidade
SELECT Funcionarios.nome as FUncionarios_nomes, Medicos.nome as medicos_nomes FROM Funcionarios JOIN Medicos ON Funcionarios.cidade = Medicos.cidade;

-- 3) Buscar o nome e idade dos médicos que têm consulta marcada com a paciente cujo nome é Ana
SELECT Medicos.nome, Medicos.idade FROM Medicos JOIN
    Consultas ON Medicos.codm = Consultas.codm JOIN
        Pacientes ON Pacientes.codp = Consultas.codp
            WHERE Pacientes.nome LIKE 'Ana%';

-- 4) Buscar o número dos ambulatórios que estão no mesmo andar do ambulatório 5
SELECT DISTINCT Ambulatorios.nroa FROM Ambulatorios JOIN Ambulatorios as Ambulatorios2 ON
    Ambulatorios.andar = Ambulatorios2.andar WHERE
        Ambulatorios2.nroa = 5;

-- Responda o que se pede utilizando junção natural:
-- 5) Buscar o código e o nome dos pacientes com consulta marcada para horários após às 14 horas
SELECT DISTINCT codp, nome FROM Pacientes NATURAL JOIN Consultas WHERE hora > '14:00';

-- 6) Buscar o número e o andar dos ambulatórios cujos médicos possuem consultas marcadas para o dia 12/10/2020
SELECT DISTINCT nroa, andar FROM Ambulatorios NATURAL JOIN
    Medicos NATURAL JOIN Consultas WHERE data = '2020/10/12';

-- Responda o que se pede utilizando junção externa (e também junção, se necessário):
-- 7) Buscar os dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os códigos e nomes destes médicos
SELECT Ambulatorios.*, Medicos.codm, Medicos.nome FROM Ambulatorios LEFT JOIN Medicos on Ambulatorios.nroa = Medicos.nroa;

-- 8) Buscar o CPF e o nome de todos os médicos e, para aqueles médicos que possuem consultas marcadas, exibir também o nome dos paciente e a data da consulta
SELECT Medicos.CPF as medicos_CPF, Medicos.nome as medicos_nomes, Pacientes.nome as pacientes_nomes, Consultas.data FROM
    Medicos LEFT JOIN
        Consultas ON Medicos.codm = Consultas.codm FULL JOIN
            Pacientes ON Consultas.codp = Pacientes.codp;


