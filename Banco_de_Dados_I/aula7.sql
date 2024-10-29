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

--Buscar o que se pede utilizando ORDER BY ou GROUP BY:
--1) os dados de todos os funcionários ordenados pelo salário (decrescente) e pela idade (crescente). Buscar apenas os três primeiros funcionários nesta ordem
SELECT salario, idade FROM Funcionarios ORDER BY salario DESC, idade LIMIT 3;

--2) o nome dos médicos e o número e andar do ambulatório onde eles atendem, ordenado pelo número do ambulatório
SELECT m.nome, m.nroa, a.andar FROM
    (SELECT nome, nroa FROM Medicos) AS m JOIN (SELECT nroa, andar FROM Ambulatorios) AS a ON
        m.nroa = a.nroa
            ORDER BY m.nroa;

--3) andares dos ambulatórios e a capacidade total por andar
SELECT andar, SUM(capacidade) FROM Ambulatorios GROUP BY andar;

--4) andares dos ambulatórios cuja média de capacidade no andar seja >= 40
SELECT andar FROM Ambulatorios GROUP BY andar HAVING AVG(capacidade) >= 40;

--5) nome dos médicos que possuem mais de uma consulta marcada
SELECT m.nome FROM (SELECT nome, codm FROM Medicos) AS m JOIN Consultas AS c ON
    m.codm = c.codm
        GROUP BY
            m.nome
            HAVING 
            count(c) > 1;

--Realizar as seguintes atualizações:
--6) excluir os ambulatórios que não possuem médicos atendendo neles
DELETE FROM Ambulatorios WHERE
    nroa NOT IN
        (SELECT nroa FROM Medicos WHERE nroa IS NOT NULL);

--7) o médico Pedro passa a residir na mesma cidade do paciente Paulo e sua idade passa a ser o dobro da idade da paciente Ana. Realizar essa alteração.
UPDATE Medicos
    SET
        cidade = (SELECT cidade FROM Pacientes WHERE nome LIKE '%Paulo%'),
        idade = 2*(SELECT idade FROM Pacientes WHERE nome LIKE '%Ana%')
            WHERE nome LIKE '%Pedro%';

--8) o funcionário Caio (codf = 3) tornou-se médico. Sua especialidade é a mesma da médica Maria (codm = 2) e ele vai atender no mesmo ambulatório dela. Inserir Caio na tabela Médicos, aproveitando os dados em comum.
INSERT INTO Medicos VALUES
    (
        6,
        (SELECT nome FROM Funcionarios WHERE codf = 3),
        (SELECT idade FROM Funcionarios WHERE codf = 3),
        (SELECT especialidade FROM Medicos WHERE codm = 2),
        (SELECT CPF FROM Funcionarios WHERE codf = 3),
        (SELECT cidade FROM Funcionarios WHERE codf = 3),
        (SELECT nroa FROM Medicos WHERE codm = 2)
    );
        
    
