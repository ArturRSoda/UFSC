:- initialization(main).

posicao(X, [X|_], 0).
posicao(X, [S|T], P) :- X \== S, posicao(X, T, P2), P is P2+1.

main :- posicao(3, [1, 2, 3], P),
        writeln(P),
        posicao(1, [1, 2, 3], P2),
        writeln(P2),
        halt.
