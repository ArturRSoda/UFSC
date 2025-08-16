:- initialization(main).

primeiros(_, [], []).
primeiros(0, _, []).
primeiros(1, [H|_], [H]).
primeiros(N, [H|T1], [H|T2]) :- N1 is N-1, primeiros(N1, T1, T2).

main :- primeiros(3, [1, 2, 3, 4, 5], R),
        writeln(R),
        halt.
