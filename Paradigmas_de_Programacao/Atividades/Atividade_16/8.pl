:- initialization(main).

menor([], 0).
menor([H], H).
menor([H|T], X) :- menor(T, X2), (H < X2 -> X is H ; X is X2).

maior([], 0).
maior([H], H).
maior([H|T], X) :- maior(T, X2), (H > X2 -> X is H ; X is X2).

diferencaMaiorMenor([], 0).
diferencaMaiorMenor(L, R) :- maior(L, Maior), menor(L, Menor), R is Maior - Menor.

main :- diferencaMaiorMenor([2, 2, 2, 1, 3, 3, 9, 3], R),
        writeln(R),
        halt.
