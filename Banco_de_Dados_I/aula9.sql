DROP TABLE IF EXISTS Ambulatorios, Medicos, Pacientes, Funcionarios, Consultas CASCADE;

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

-- 1) criar uma visão que enxerga o código, nome, CPF e idade os dados dos funcionários de Florianopolis;
CREATE VIEW FuncFloripa (codf, nome, cpf, idade)
    AS (SELECT codf, nome, cpf, idade FROM Funcionarios WHERE cidade = 'Florianopolis');

-- 2) consulte os dados da visão;
SELECT * FROM FuncFloripa;

-- 3) incremente a idade de todos os funcionários da visão;
UPDATE FuncFloripa
    SET idade = idade+1;

-- 4) consulte novamente os dados da visão. A atualização funcionou?
SELECT * FROM FuncFloripa;
-- R: Sim, a atualizacao funcionou

-- 5) inserir o funcionário de nome Rodrigo, CPF 22200022233, 41 anos e código 10 através da visão;
INSERT INTO FuncFloripa (codf, nome, cpf, idade)
    VALUES (10, 'Rodrigo', 22200022233, 41);

-- 6) consulte os dados da visão. A inserção funcionou?
SELECT * FROM FuncFloripa;
SELECT * FROM Funcionarios;
-- R: Nao funcionou para a visao, mas a tupla foi inserida diretamente na tabela sem cidade definida.

-- 7) definir uma trigger que, ao invés de inserir na visão, insere diretamente na tabela Funcionários preenchendo o atributo cidade com ‘Florianopolis’;
CREATE RULE insercaoFuncFloripa
    AS ON INSERT TO FuncFloripa
        DO INSTEAD
            INSERT INTO Funcionarios (codf, nome, idade, cidade, cpf, salario)
                VALUES (NEW.codf, NEW.nome, NEW.idade, 'Florianopolis', NEW.cpf, NULL);

-- 8) inserir o funcionário de nome Raul, CPF 44400044433, 53 anos e código 11;
INSERT INTO FuncFloripa (codf, nome, cpf, idade)
    VALUES (11, 'RAUL', 44400044433, 53);

-- 9) consulte os dados da visão. A inserção funcionou?
SELECT * FROM FuncFloripa;
SELECT * FROM Funcionarios;
-- R: Funcionou, pois foi adicionado o trigger

-- 10) criar uma visão que enxerga o código, nome, idade, CPF e número do ambulatório dos médicos que atendem em ambulatórios com número igual ou superior à 2. Defina essa visão com a cláusula WITH CHECK OPTION;
CREATE VIEW MedicMaior2 (codm, nome, idade, cpf, nroa)
    AS (SELECT codm, nome, idade, cpf, nroa FROM Medicos WHERE nroa >= 2)
        WITH CHECK OPTION;

-- 11) consulte os dados da visão;
SELECT * FROM MedicMaior2;

-- 12) inserir o médico de nome Soraia, CPF 55500055533, 47 anos, ambulatório 2 e código 7;
INSERT INTO MedicMaior2 (codm, nome, idade, cpf, nroa)
    VALUES (7, 'Soraia', 47, 55500055533, 2);

-- 13) consulte os dados da visão. A inserção funcionou?
SELECT * FROM MedicMaior2;
-- R: Sim, a insersao funcionou, pois todos os dados confere.

-- 14) inserir o méd ico de nome Saulo, CPF 66600066633, 52 anos, ambulatório 1 e código 8. A inserção funcionou?
INSERT INTO MedicMaior2 (codm, nome, idade, cpf, nroa)
    VALUES (8, 'Saulo', 52, 66600066633, 1);
-- Nao, a insersao nao foi possivel, por causa da clausula with check option.
