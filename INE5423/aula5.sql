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

-- Resolva o que se pede utilizando subconsultas [NOT] IN:
-- 1) nome dos pacientes com consultas marcadas após às 14 horas
SELECT nome FROM Pacientes WHERE codp IN (SELECT codp FROM Consultas WHERE hora > '14:00');
-- 2) nome e idade dos médicos que possuem consulta com a paciente Ana
SELECT nome, idade FROM Medicos WHERE codm IN (SELECT codm FROM Consultas WHERE codp in (SELECT codp FROM Pacientes WHERE nome LIKE 'Ana%'));
-- 3) número e andar dos ambulatórios onde nenhum médico dá atendimento
SELECT nroa, andar FROM Ambulatorios WHERE nroa NOT IN (SELECT distinct(nroa) FROM Medicos WHERE nroa IS NOT NULL);
-- Resolva o que se pede utilizando subconsultas SOME e/ou ALL:
-- 4) CPF dos médicos que atendem em ambulatórios do primeiro andar
SELECT CPF from Medicos WHERE nroa = SOME (SELECT nroa FROM Ambulatorios Where andar = 1);
-- 5) nome e CPF de todos os funcionários, exceto o de maior salário
SELECT nome, CPF FROM Funcionarios WHERE salario < SOME (SELECT salario FROM Funcionarios);
-- 6) nome dos pacientes com consultas marcadas para horários anteriores a todos os horários de consultas marcadas para o dia 14/10/2020
SELECT nome FROM Pacientes WHERE codp = SOME (SELECT codp FROM Consultas WHERE hora < ALL (SELECT hora FROM Consultas WHERE data = '2020/10/14'));
-- 7) número e andar dos ambulatórios com capacidade superior à capacidade de qualquer ambulatório que esteja no primeiro andar 
SELECT nroa, andar FROM Ambulatorios WHERE capacidade > ALL (SELECT capacidade FROM Ambulatorios WHERE andar = 1);
