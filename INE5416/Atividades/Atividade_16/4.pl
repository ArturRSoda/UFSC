:- initialization(main).

soma([], 0).
soma([H|T], X) :- soma(T, X2), X is H + X2.


main :- soma([1, 2, 3, 4], R),
        writeln(R),
        halt.
