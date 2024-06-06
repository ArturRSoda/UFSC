:- initialization(main).

soma([], 0).
soma([H|T], X) :- soma(T, X2), X is H + X2.

len([], 0).
len([_|T], X) :- len(T, X2), X is 1 + X2.

media([], 0).
media(L, X) :- soma(L, S), len(L, N), X is S / N.

main :- media([1, 2, 3, 4, 5], M),
        writeln(M),
        halt.

