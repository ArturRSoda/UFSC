materia(ine5412).
materia(ine5413).
materia(ine5415).
materia(ine5416).
materia(ine5417).

professor(geovani, ine5412).
professor(rafael, ine5413).
professor(jerusa, ine5415).
professor(maicon, ine5416).
professor(ricador, ine5417).

aluno(artur, ine5412).
aluno(artur, ine5413).
aluno(artur, ine5415).
aluno(artur, ine5416).
aluno(artur, ine5417).

aluno(davi, ine5412).
aluno(felipe, ine5413).
aluno(enzo, ine5415).
aluno(antonio, ine5416).
aluno(breno, ine5417).

ensina(X, Y) :- professor(X, M), aluno(Y, M).

colegas(X, Y) :- aluno(X, M), aluno(Y, M), X \== Y.

