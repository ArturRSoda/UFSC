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

-- Responda utilizando subconsultas com EXISTS:
-- 1) Buscar o nome e o CPF dos médicos que também são pacientes do hospital
SELECT m.nome, m.CPF FROM Medicos m WHERE
    EXISTS (SELECT * FROM Consultas c WHERE m.codm = c.codm);

-- 2) Buscar o nome e o CPF dos médicos ortopedistas, e a data das suas consultas, para os ortopedistas que têm consulta marcada com a paciente Ana
SELECT m.nome, m.CPF, c.data FROM
    (SELECT nome, CPF, codm FROM Medicos WHERE especialidade='ortopedia') AS m JOIN (SELECT codp, codm, data FROM Consultas) AS c ON
        m.codm = c.codm WHERE
            EXISTS (SELECT * FROM Pacientes p WHERE c.codp = p.codp AND p.nome LIKE '%Ana%');

-- 3) Buscar o nome e o CPF dos médicos que têm consultas marcadas com todos os pacientes
SELECT m.nome, m.CPF FROM Medicos m WHERE
    NOT EXISTS (SELECT * FROM Pacientes p WHERE
        NOT EXISTS (SELECT * FROM Consultas c WHERE
            c.codm=m.codm AND c.codp=p.codp));

-- 4) Buscar o nome e o CPF dos médicos ortopedistas que têm consultas marcadas com todos os pacientes de Florianópolis
SELECT m.nome, m.CPF FROM Medicos m WHERE
    m.especialidade='ortopedia' AND NOT EXISTS (SELECT * FROM Pacientes p WHERE
        p.cidade!='Florianopolis' AND NOT EXISTS (SELECT * FROM Consultas c WHERE
            c.codm=m.codm AND c.codp=p.codp));

--Responda utilizando subconsultas na cláusula FROM:
-- 1) Buscar a data e a hora das consultas marcadas para a médica Maria
SELECT c.data, c.hora FROM
    (SELECT data, hora, codm FROM Consultas c) AS c JOIN
        (SELECT codm FROM Medicos WHERE nome LIKE '%Maria%') AS m ON
            m.codm=c.codm;

-- 2) Buscar o nome e a cidade dos pacientes que têm consultas marcadas com ortopedistas
SELECT DISTINCT(p.nome), p.cidade FROM
    (SELECT nome, cidade, codp FROM Pacientes) AS p JOIN
        (SELECT c.codp FROM
            (SELECT codp, codm FROM Consultas) AS c JOIN
                (SELECT codm FROM Medicos WHERE
                    especialidade='ortopedia') AS m ON
                        c.codm=m.codm) AS c ON
                            c.codp=p.codp;

-- 3) Buscar o nome e o CPF dos médicos que atendem no mesmo ambulatório do médico Pedro
SELECT DISTINCT m.cpf, m.nome FROM
    (SELECT nome, CPF, nroa FROM Medicos) AS m JOIN
        (SELECT nroa FROM Medicos WHERE nome LIKE '%Pedro%') as mp ON
            m.nroa = mp.nroa;

