DROP TABLE IF EXISTS Ambulatorios, Medicos, Pacientes, Funcionarios, Consultas;

\! echo "1) Criar as seguintes tabelas, considerando que os atributos sublinhados fazem parte da chave primária e os em itálico são chaves estrangeiras (não acentuem as palavras!)";
\! echo "a) Ambulatorios: nroa (int), andar (numeric(2)) (não nulo), capacidade (smallint)";
CREATE TABLE Ambulatorios (
    nroa INT,
    andar NUMERIC(2) NOT NULL,
    capacidade SMALLINT,
    PRIMARY KEY (nroa)
);

\! echo "b) Medicos: codm (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), especialidade (varchar(30)), nroa (int)";
CREATE TABLE Medicos (
    codm INT,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade VARCHAR(40),
    cpf NUMERIC(11) NOT NULL UNIQUE,
    especialidade VARCHAR(40),
    nroa INT,
    PRIMARY KEY (codm),
    FOREIGN KEY (nroa) REFERENCES Ambulatorios
);

\! echo "c) Pacientes: codp (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), doenca (varchar(40)) (não nulo)";
CREATE TABLE Pacientes (
    codp INT,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade VARCHAR(40),
    cpf NUMERIC(11) NOT NULL UNIQUE,
    doenca VARCHAR(40) NOT NULL,
    PRIMARY KEY (codp)
);

\! echo "d) Funcionarios: codf (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), salário (numeric(10)), cargo (varchar(40))";
CREATE TABLE Funcionarios (
    codf INT,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade VARCHAR(40),
    cpf NUMERIC(11) NOT NULL UNIQUE,
    salario NUMERIC(10),
    cargo VARCHAR(40),
    PRIMARY KEY (codf)
);

\! echo "e) Consultas: codm (int), codp (int), data (date), hora (time)";
CREATE TABLE Consultas (
    codm INT,
    codp INT,
    data DATE,
    hora TIME,
    PRIMARY KEY (codm, codp, data),
    FOREIGN KEY (codm) REFERENCES Medicos,
    FOREIGN KEY (codp) REFERENCES Pacientes
);

\! echo "2) Alterar a tabela Funcionarios, removendo o atributo cargo";
ALTER TABLE Funcionarios
    DROP Cargo;

\! echo "3) Criar um índice para o atributo cidade na tabela Pacientes";
CREATE INDEX cidade_id
    ON Pacientes(cidade);


\! echo "Popular as tabelas";
INSERT INTO Ambulatorios (nroa, andar, capacidade)
    VALUES
        (1, 1, 30),
        (2, 1, 50),
        (3, 2, 40),
        (4, 2, 25),
        (5, 2, 55);

INSERT INTO Medicos (codm, nome, idade, especialidade, cpf, cidade, nroa)
    VALUES
        (1,   'Joao', 40,     'ortopedia', 10000100000, 'Florianopolis',    1),
        (2,  'Maria', 42, 'traumatologia', 10000110000,      'Blumenau',    2),
        (3,  'Pedro', 51,     'pediatria', 11000100000,      'Sao Jose',    2),
        (4, 'Carlos', 28,     'ortopedia', 11000110000,     'Joinville', NULL),
        (5, 'Marcia', 33,    'neurologia', 11000111000,       'Biguacu',    3);

INSERT INTO Pacientes (codp, nome, idade, cidade, cpf, doenca)
    VALUES
        (1,    'Ana', 20, 'Florianopolis', 20000200000,     'gripe'),
        (2,  'Paulo', 24,       'Palhoca', 20000220000,   'fratura'),
        (3,  'Lucia', 30,       'Biguacu', 22000200000, 'tendinite'),
        (4, 'Carlos', 28,     'Joinville', 11000110000,   'sarampo');

INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, cpf)
    VALUES
        (1,   'Rita',  32,      'Sao Jose', 1200, 20000100000),
        (2,   'Vera',  55,       'Palhoca', 1220, 30000110000),
        (3,   'Caio',  45, 'Florianopolis', 1100, 41000100000),
        (4, 'Marcelo', 44, 'Florianopolis', 1200, 51000110000),
        (5,   'Paula', 33, 'Florianopolis', 2500, 61000111000);

INSERT INTO Consultas (codm, codp, data, hora)
    VALUES
        (1, 1, '2020/10/12', '14:00'),
        (1, 4, '2020/10/13', '10:00'),
        (2, 1, '2020/10/13',  '9:00'),
        (2, 2, '2020/10/13', '11:00'),
        (2, 3, '2020/10/14', '14:00'),
        (2, 4, '2020/10/14', '17:00'),
        (3, 1, '2020/10/19', '18:00'),
        (3, 3, '2020/10/12', '10:00'),
        (3, 4, '2020/10/19', '13:00'),
        (4, 4, '2020/10/20', '13:00'),
        (4, 4, '2020/10/22', '19:30');

\! echo "Realizar as seguintes atualizações:";
\! echo "1) O paciente Paulo mudou-se para Ilhota";
UPDATE Pacientes
    SET cidade = 'Ilhota'
        WHERE nome LIKE '%Paulo%';

\! echo "2) A consulta do médico 1 com o paciente 4 passou para às 12:00 horas do dia 4 de Novembro de 2020";
UPDATE Consultas
    SET
        hora = '12:00',
        data = '2020/11/04'
            WHERE
                codm = 1
                AND codp = 4;

\! echo "3) A consulta do médico 3 com o paciente 4 passou para às 14h30";
UPDATE Consultas
    SET hora = '14:30'
        WHERE
            codm = 3
            AND codp = 4;

\! echo "4) O funcionário 4 deixou a clínica";
DELETE FROM Funcionarios
    WHERE codf = 4;

\! echo "5) As consultas após as 19 horas devem ser excluídas";
DELETE FROM Consultas
    WHERE hora > '19:00';

\! echo "6) Os médicos que residem em Biguacu e Palhoca devem ser excluídos";
DELETE FROM Medicos
    WHERE
        cidade = 'Biguacu'
        OR cidade = 'Palhoca';

\! echo "Realizar as seguintes consultas no BD:";
\! echo "1) Buscar os dados dos médicos com menos de 40 anos ou com especialidade diferente de traumatologia";
SELECT * FROM Medicos
    WHERE
        idade < 40
        OR especialidade != 'traumatologia';

\! echo "2) Buscar o nome e a idade dos pacientes que não residem em Florianópolis";
SELECT nome, idade FROM Pacientes
    WHERE cidade != 'Florianopolis';

\! echo "3) Buscar o nome e a idade (em meses) dos pacientes";
SELECT nome, idade*12 as idade_meses FROM Pacientes;

\! echo "4) Qual o horário da última consulta marcada para o dia 13/10/2020?";
SELECT MAX(hora) FROM Consultas
    WHERE
        data='2020/10/13';

\! echo "5) Qual a média de idade dos médicos e o total de ambulatórios atendidos por eles?";
SELECT AVG(idade) AS media_idade, COUNT(DISTINCT nroa) AS total_ambulatorios FROM Medicos;

\! echo "6) Buscar o código, o nome e o salário líquido dos funcionários. O salário líquido é o salário cadastrado menos 20%";
SELECT codf, nome, salario*0.8 AS salario_liquido FROM Funcionarios;

\! echo "7) Buscar o nome dos funcionários que terminam com a letra 'a'";
SELECT nome FROM Funcionarios
    WHERE nome LIKE '%a';

\! echo "8) Buscar o nome e a especialidade dos médicos cuja segunda e a última letra de seus nomes seja a letra 'o'";
SELECT nome, especialidade FROM Medicos
    WHERE nome LIKE '_o%o';

\! echo "9) Buscar os códigos e nomes dos pacientes com mais de 25 anos que estão com tendinite, fratura, gripe ou sarampo";
SELECT codp, nome FROM Pacientes
    WHERE
        idade > 25
        AND doenca in ('tendinite', 'fratura', 'gripe', 'sarampo');

\! echo "10) Buscar os CPFs, nomes e idades de todas as pessoas (médicos, pacientes ou funcionários) que residem em Florianópolis";
(SELECT cpf, nome, idade FROM Medicos WHERE cidade='Florianopolis')
    UNION (SELECT cpf, nome, idade FROM Pacientes WHERE cidade='Florianopolis')
    UNION (SELECT cpf, nome, idade FROM Funcionarios WHERE cidade='Florianopolis');

\! echo "Responda o que se pede utilizando junção (não natural):";
\! echo "1) Buscar o nome e CPF dos médicos que também são pacientes do hospital";
SELECT m.nome, m.cpf FROM Medicos m
    JOIN Pacientes p
        ON m.cpf = p.cpf;

\! echo "2) Buscar nomes de funcionários e de médicos (exibir pares de nomes) que residem na mesma cidade";
SELECT f.nome, m.nome FROM Funcionarios f, Medicos m;

\! echo "3) Buscar o nome e idade dos médicos que têm consulta marcada com a paciente cujo nome é Ana";
SELECT m.nome, m.idade FROM medicos m
    JOIN Consultas c
        JOIN Pacientes p
            ON c.codp = p.codp
                ON c.codm = m.codm
                    WHERE p.nome LIKE '%Ana%';

\! echo "4) Buscar o número dos ambulatórios que estão no mesmo andar do ambulatório 5";
SELECT a1.nroa FROM Ambulatorios a1
    JOIN Ambulatorios a2
        ON a1.andar = a2.andar
            WHERE a2.nroa = 5;

\! echo "Responda o que se pede utilizando junção natural:";
\! echo "5) Buscar o código e o nome dos pacientes com consulta marcada para horários após às 14 horas";
SELECT DISTINCT p.codp, p.nome FROM Pacientes p
    NATURAL JOIN Consultas c
        WHERE c.hora > '14:00';

\! echo "6) Buscar o número e o andar dos ambulatórios cujos médicos possuem consultas marcadas para o dia 12/10/2020";
SELECT a.nroa, a.andar FROM Ambulatorios a
    NATURAL JOIN Medicos m
        NATURAL JOIN Consultas c
            WHERE c.data='2020/10/12';

\! echo "Responda o que se pede utilizando junção externa (e também junção, se necessário):";
\! echo "7) Buscar os dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os códigos e nomes destes médicos";
SELECT * FROM Ambulatorios a
     NATURAL LEFT JOIN (SELECT codm, nome, nroa FROM Medicos) m;

\! echo "8) Buscar o CPF e o nome de todos os médicos e, para aqueles médicos que possuem consultas marcadas, exibir também o nome dos paciente e a data da consulta ";
SELECT m.cpf AS cpf_medico, m.nome AS nome_medico, p.nome AS nome_pacientes, c.data FROM Medicos m
    LEFT JOIN Consultas c
        JOIN Pacientes p
            ON c.codp = p.codp
                ON m.codm = c.codm;

\! echo "Resolva o que se pede utilizando subconsultas [NOT] IN:";
\! echo "1) nome dos pacientes com consultas marcadas após às 14 horas";
SELECT p.nome FROM Pacientes p
    WHERE p.codp IN (SELECT c.codp FROM Consultas c WHERE c.hora > '14:00');

\! echo "2) nome e idade dos médicos que possuem consulta com a paciente Ana";
SELECT m.nome, m.idade FROM Medicos m
    WHERE m.codm IN (
        SELECT c.codm FROM Consultas c
            WHERE c.codp IN (
                SELECT codp FROM Pacientes
                    WHERE nome LIKE '%Ana%'
            )
    );

\! echo "3) número e andar dos ambulatórios onde nenhum médico dá atendimento";
SELECT a.nroa, a.andar FROM Ambulatorios a
    WHERE a.nroa NOT IN (
        SELECT m.nroa FROM Medicos m
            WHERE m.nroa IS NOT NULL
    );


\! echo "Resolva o que se pede utilizando subconsultas SOME e/ou ALL:";
\! echo "4) CPF dos médicos que atendem em ambulatórios do primeiro andar";
SELECT m.cpf FROM Medicos m
    WHERE m.nroa = SOME (
        SELECT a.nroa FROM Ambulatorios a
            WHERE a.andar = 1
    );

\! echo "5) nome e CPF de todos os funcionários, exceto o de maior salário";
SELECT f.nome, f.cpf FROM Funcionarios f
    WHERE f.salario < SOME (
        SELECT salario FROM Funcionarios
    );

\! echo "6) nome dos pacientes com consultas marcadas para horários anteriores a todos os horários de consultas marcadas para o dia 14/10/2020";
SELECT P.nome FROM Pacientes p
    WHERE p.codp IN (
        SELECT c.codp FROM Consultas c
            WHERE c.hora < ALL (
                SELECT c2.hora FROM Consultas c2
                    WHERE c2.data='2020/10/14'
            )
    );

\! echo "7) número e andar dos ambulatórios com capacidade superior à capacidade de qualquer ambulatório que esteja no primeiro andar";
SELECT a.nroa, a.andar FROM Ambulatorios a
    WHERE a.capacidade > ALL (
        SELECT a2.capacidade FROM Ambulatorios a2
            WHERE a2.andar = 1
    );

\! echo "Responda utilizando subconsultas com EXISTS:";
\! echo "1) Buscar o nome e o CPF dos médicos que também são pacientes do hospital";
SELECT m.nome, m.cpf FROM Medicos m
    WHERE EXISTS (
        SELECT * FROM Pacientes p
            WHERE p.cpf = m.cpf
    );

\! echo "2) Buscar o nome e o CPF dos médicos ortopedistas, e a data das suas consultas, para os ortopedistas que têm consulta marcada com a paciente Ana";
SELECT m.nome, m.cpf, c.data FROM Medicos m
    JOIN (SELECT codm, codp, data FROM Consultas) c
        ON m.codm = c.codm
            WHERE
                m.especialidade = 'ortopedia'
                AND EXISTS (
                SELECT * FROM Pacientes p
                    WHERE
                        p.nome LIKE '%Ana%'
                        AND p.codp = c.codp
            );

\! echo "3) Buscar o nome e o CPF dos médicos que têm consultas marcadas com todos os pacientes";
SELECT m.nome, m.cpf FROM Medicos m
    WHERE NOT EXISTS (
        SELECT * FROM Pacientes p
            WHERE NOT EXISTS (
                SELECT * FROM Consultas c
                    WHERE
                        c.codm = m.codm
                        AND c.codp = p.codp
            )
    );

\! echo "4) Buscar o nome e o CPF dos médicos ortopedistas que têm consultas marcadas com todos os pacientes de Florianópolis";
SELECT m.nome, m.cpf FROM Medicos m
    WHERE
        m.especialidade = 'ortopedia'
        AND NOT EXISTS (
            SELECT * FROM Pacientes p
                WHERE
                    p.cidade = 'Florianopolis'
                    AND NOT EXISTS (
                        SELECT * FROM Consultas c
                            WHERE
                                c.codp = p.codp
                                AND c.codm = m.codm
                    )
        );

\! echo "Responda utilizando subconsultas na cláusula FROM:";
\! echo "1) Buscar a data e a hora das consultas marcadas para a médica Maria";
SELECT c.data, c.hora FROM (SELECT codm, data, hora FROM Consultas) c
    WHERE c.codm IN (
        SELECT codm FROM Medicos
            WHERE nome LIKE '%Maria%'
    );

\! echo "2) Buscar o nome e a cidade dos pacientes que têm consultas marcadas com ortopedistas";
SELECT p.nome, p.cidade FROM (SELECT nome, cidade, codp FROM Pacientes) p
    WHERE p.codp IN (
        SELECT c.codp FROM (SELECT codm, codp FROM Consultas) c
            WHERE c.codm IN (
                SELECT codm FROM Medicos
                    WHERE especialidade='ortopedia'
            )
    );

\! echo "3) Buscar o nome e o CPF dos médicos que atendem no mesmo ambulatório do médico Pedro";
SELECT m.nome, m.cpf FROM (SELECT nome, cpf, nroa FROM Medicos) m
    WHERE
        m.nome NOT LIKE '%Pedro%'
        AND m.nroa IN (
        SELECT nroa FROM Medicos
            WHERE nome LIKE '%Pedro%'
    );

\! echo "Buscar o que se pede utilizando ORDER BY ou GROUP BY";
\! echo "1) os dados de todos os funcionários ordenados pelo salário (decrescente) e pela idade (crescente). Buscar apenas os três primeiros funcionários nesta ordem";
SELECT f.salario, f.idade FROM Funcionarios f
    ORDER BY f.salario desc, f.idade
        LIMIT 3;

\! echo "2) o nome dos médicos e o número e andar do ambulatório onde eles atendem, ordenado pelo número do ambulatório";
SELECT m.nome, a.nroa, a.andar FROM (SELECT nome, nroa FROM Medicos) m
    JOIN (SELECT nroa, andar FROM Ambulatorios) a
        ON a.nroa = m.nroa
            ORDER BY a.nroa;

\! echo "3) andares dos ambulatórios e a capacidade total por andar";
SELECT a.andar, COUNT(*) FROM Ambulatorios a
    GROUP BY a.andar;

\! echo "4) andares dos ambulatórios cuja média de capacidade no andar seja >= 40";
SELECT a.andar, AVG(a.capacidade) FROM Ambulatorios a
    GROUP BY a.andar
        HAVING AVG(a.capacidade) >= 40;

\! echo "5) nome dos médicos que possuem mais de uma consulta marcada";
SELECT m.nome, COUNT(*) FROM (SELECT nome, codm FROM Medicos) m
    JOIN (SELECT codm FROM Consultas) c
        ON m.codm = c.codm
            GROUP BY m.nome
                HAVING COUNT(*) > 1;

\! echo "Realizar as seguintes atualizações:";
\! echo "6) excluir os ambulatórios que não possuem médicos atendendo neles";
DELETE FROM Ambulatorios a
    WHERE NOT EXISTS (
        SELECT m.nroa FROM Medicos m
            WHERE a.nroa = m.nroa
    );

\! echo "7) o médico Pedro passa a residir na mesma cidade do paciente Paulo e sua idade passa a ser o dobro da idade da paciente Ana. Realizar essa alteração.";
UPDATE Medicos 
    SET
        cidade = (SELECT cidade FROM Pacientes WHERE nome LIKE '%Paulo%'),
        idade = 2*(SELECT idade FROM Pacientes WHERE nome LIKE '%Ana%')
            WHERE nome LIKE '%Pedro%';
SELECT * FROM Medicos;


\! echo "8) o funcionário Caio (codf = 3) tornou-se médico. Sua especialidade é a mesma da médica Maria (codm = 2) e ele vai atender no mesmo ambulatório dela. Inserir Caio na tabela Médicos, aproveitando os dados em comum.";
INSERT INTO Medicos (codm, nome, idade, cidade, cpf, especialidade, nroa)
    VALUES (
        6,
        (SELECT nome FROM Funcionarios WHERE codf = 3),
        (SELECT idade FROM Funcionarios WHERE codf = 3),
        (SELECT cidade FROM Funcionarios WHERE codf = 3),
        (SELECT cpf FROM Funcionarios WHERE codf = 3),
        (SELECT especialidade FROM Medicos WHERE codm = 2),
        (SELECT nroa FROM Medicos WHERE codm = 2)
    );
