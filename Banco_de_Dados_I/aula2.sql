DROP TABLE IF EXISTS Ambulatorios, Medicos, Pacientes, Funcionarios, Consultas;

create table Ambulatorios (nroa int, andar numeric(2) not null, capacidade smallint, primary key(nroa));

create table Medicos (codm int, nome varchar(40) not null, idade smallint not null, cidade varchar(40), CPF numeric(11) not null unique, especialidade varchar(30), nroa int, primary key(codm), foreign key(nroa) references Ambulatorios);

create table Pacientes (codp int, nome varchar(40) not null, idade smallint not null, cidade varchar(40), CPF numeric(11) not null unique, doenca varchar(40) not null, primary key(codp));

create table Funcionarios (codf int, nome varchar(40) not null, idade smallint not null, cidade varchar(40), CPF numeric(11) not null unique, salario numeric(10), primary key(codf));

create table Consultas (codm int, codp int, data date, hora time, primary key(codm, codp, data), foreign key(codm) references Medicos, foreign key(codp) references Pacientes);

INSERT INTO Pacientes 
       VALUES (1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe'),
              (2, 'Paulo', 24, 'Palhoca', 20000220000, 'fratura'),
              (3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite'),
              (4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo');

INSERT INTO Ambulatorios
       VALUES (1, 1, 30),
              (2, 1, 50),
              (3, 2, 40),
              (4, 2, 25),
              (5, 2, 55);

INSERT INTO Medicos
       VALUES (1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1),
              (2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
              (3, 'Pedro', 51, 'pediatria', 11000100000, 'Sao Jose', 2),
              (4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', NULL),
              (5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);


INSERT INTO Funcionarios
       VALUES (1, 'Rita', 32, 'Sao Jose', 1200, 20000100000),
              (2, 'Vera', 55, 'Palhoca', 1220, 30000110000),
              (3, 'Caio', 45, 'Florianopolis', 1100, 41000100000),
              (4, 'Marcelo', 44, 'Florianopolis', 1200, 51000110000),
              (5, 'Paula', 33, 'Florianopolis', 2500, 61000111000);

INSERT INTO Consultas
        VALUES (1, 1, '2020/10/12', '14:00'),
               (1, 4, '2020/10/13', '10:00'),
               (2, 1, '2020/10/13', '9:00'),
               (2, 2, '2020/10/13', '11:00'),
               (2, 3, '2020/10/14', '14:00'),
               (2, 4, '2020/10/14', '17:00'),
               (3, 1, '2020/10/19', '18:00'),
               (3, 3, '2020/10/12', '10:00'),
               (3, 4, '2020/10/10', '13:00'),
               (4, 4, '2020/10/20', '13:00'),
               (4, 4, '2020/10/22', '19:30');

UPDATE Pacientes SET cidade='Ilhota' where nome='Pedro';

UPDATE Consultas SET hora='12:00', data='2020/11/04' WHERE codm=1 and codp=4;

UPDATE Consultas SET hora='14:30'WHERE codm=3 and codp=4;

DELETE FROM Funcionarios WHERE codf=4;

DELETE FROM Consultas WHERE hora > '19:00';

DELETE FROM Medicos Where cidade='Biguacu' or cidade='Palhoca';


