:- initialization(main).

inverteAux([], R, R).
inverteAux([X|T1], T2, R) :- inverteAux(T1, [X|T2], R).

inverte(L, R) :- inverteAux(L, [], R).

main :- inverte([1, 2, 3, 4], R),
        writeln(R),
        halt.
