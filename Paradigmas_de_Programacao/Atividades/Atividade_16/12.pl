:- initialization(main).

apagar(_, [], []).
apagar(0, L, L).
apagar(N, [_|T1], R) :- N1 is N-1, apagar(N1, T1, R).

main :- apagar(3, [1, 2, 3, 4, 5], R),
        writeln(R),
        halt.
