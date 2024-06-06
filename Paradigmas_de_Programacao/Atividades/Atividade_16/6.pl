:- initialization(main).

menor([], 0).
menor([H], H).
menor([H|T], X) :- menor(T, X2), (H < X2 -> X is H ; X is X2).

main :- menor([5, 4, 3, 1, 7, 7, 7], R),
        writeln(R),
        halt.
