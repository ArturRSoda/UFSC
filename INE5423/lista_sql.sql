-- 1)
SELECT codigo, titulo FROM Obras
    WHERE
        ano BETWEEN 1995 AND 2015
        AND salao = 36
            ORDER BY o.titulo;

-- 2)
SELECT nome, cpf FROM Funcionarios
    WHERE
        turno = 'N'
        AND cpf IN (
            SELECT cpf FROM Lotacoes
                WHERE numero = 25
        );

-- 3)
SELECT codigo, titulo FROM Obras
    WHERE
        autor IN (SELECT codigo FROM Autores WHERE nome = 'Pablo Picasso')
        AND salao IN (SELECT numero FROM Saloes WHERE andar = 3);

-- 4)
SELECT o.codigo, o.titulo FROM Obras
    JOIN (SELECT codigo FROM Pinturas WHERE estilo = 'impressionista') p
        JOIN (SELECT codigo FROM Esculturas WHERE material = 'argila') e
            ON o.codigo = p.codigo
                ON o.codigo = e.codigo;

-- 5)
(
    SELECT a.nome, a.nacionalidade FROM Autores a
        JOIN (
            SELECT codigo, autor FROM Obras
                WHERE
                    salao IS NOT NULL
                    AND o.codigo IN (SELECT codigo FROM Esculturas)
        ) o
            ON a.codigo = o.autor
)
INTERSECT
(
    SELECT a.nome, a.nacionalidade FROM Autores a
        JOIN (
            SELECT codigo, autor FROM Obras
                WHERE
                    salao IS NOT NULL
                    AND o.codigo IN (SELECT codigo FROM Pinturas)
        ) o
            ON a.codigo = o.autor
)

-- 6)
SELECT f1.nome AS nomeF1, f2.nome AS nomeF2 FROM
    (
        SELECT * FROM Funcionarios f
            JOIN Lotacoes l
                ON f.cpf = l.cpf
                    WHERE f.funcao = 'seguranca'
    ) f1
    JOIN
    (
        SELECT * FROM funcionarios f
            JOIN Lotacoes l
                ON f.cpf = l.cpf
                    WHERE f.funcao = 'seguranca'
    ) f2
    ON
        f1.numero = n2.numero AND
        f1.horaEntrada = f2.horaEntrada AND
        f1.horaSaida = f2.horaSaida AND
        f1.cpf != f2.cpf;


-- 7)
SELECT s.numero FROM Saloes s
    WHERE s.numero IN (
        SELECT o.salao FROM Obras o
            WHERE
                o.codigo IN (SELECT codigo FROM Esculturas)
                AND o.codigo NOT IN (SELECT codigo FROM Pinturas)
    );

-- 8)
SELECT f.nome, f.cpf FROM Funcionarios f
    WHERE
        f.funcao = 'faxineiro' AND
        NOT EXISTS (
            SELECT * FROM (SELECT cpf, numero FROM Lotacoes) l
                WHERE NOT EXISTS (
                    SELECT * FROM (SELECT numero FROM Saloes WHERE andar = 4) s
                        WHERE
                            f.cpf = l.cpf AND
                            l.numero = s.numero
                )
        );

-- 9)
SELECT s.numero FROM Salaoes s
    WHERE s.area = (SELECT MAX(area) FROM Saloes);


-- 10)
SELECT f.nome, f.cpf, count(l.numero) FROM (
    SELECT nome, cpf FROM Funcionarios
        WHERE
            turno IN ('M', 'T') AND
            funcao = 'Seguranca'
    ) f
    JOIN
    (
        SELECT cpf, numero FROM Lotacoes
    ) l
    ON l.cpf = f.cpf
        GROUP BY f.cpf
            HAVING COUNT(l.numero) > 1

-- 11)
SELECT o.codigo, o.titulo FROM Obras o
    WHERE o.ano < ALL (
        SELECT o2.ano FROM Obras o2
            JOIN (SELECT codigo FROM Autores WHERE nome = 'Claude Monet') a
                ON a.codigo = o2.autor
    )

-- 12)
UPDATE Funcionarios
    SET
        salario = 1.15*salario
    WHERE
        cpf IN (
            SELECT cpf FROM Lotacoes
                WHERE numero IN (
                    SELECT numero FROM Saloes
                        WHERE area > 500
                )
        )

-- 14)
DELETE FROM Autores
    WHERE codigo IN (
        SELECT autor, count(*) FROM Obras
            GROUP BY autor
                HAVING COUNT(*) > 1
    )

-- 14)
CREATE TABLE Lotacoes (
    CPF INT,
    numero INT,
    horaEntrada TIME,
    horaSaida TIME,
    PRIMARY KEY (cpf, numero)
    FOREIGN KEY (cpf) REFERENCES Funcionairos (cpf),
    FOREIGN KEY (numero) REFERENCES Saloes (numero)
)

--15)
INSERT INTO Lotacoes (cpf, numero, horaEntrada, horaSaida)
    VALUES (1000100000, 24, '2:00', '10:00');
