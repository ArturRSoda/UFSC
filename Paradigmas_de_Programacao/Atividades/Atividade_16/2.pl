:- initialization(main).

inserirElementoPosicao(X, 0, L1, [X|L1]).
inserirElementoPosicao(X, P, [H|T1], [H|T2]) :- P1 is P-1, inserirElementoPosicao(X, P1, T1, T2).

main :- inserirElementoPosicao(9, 5, [1, 2, 3, 4, 5], L2),
        writeln(L2),
        halt.
