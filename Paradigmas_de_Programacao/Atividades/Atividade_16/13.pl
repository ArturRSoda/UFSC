:- initialization(main).

len([], 0).
len([_|T], X) :- len(T, X2), X is 1 + X2.


dividir([], [], []).
dividir([H], [H|T], L3) :- len([H|T], R2), len(L3, R3), R2 =:= R3+1.
dividir([H11, H12|T1], [H11|Lr2], [H12|Lr3]) :- dividir(T1, Lr2, Lr3).

main :- dividir([1, 2, 3, 4, 5], L1, L2),
        writeln(L1),
        writeln(L2),
        dividir([1, 2, 3, 4], L11, L22),
        writeln(L11),
        writeln(L22),
        halt.
