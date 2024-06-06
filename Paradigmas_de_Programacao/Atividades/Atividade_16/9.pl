:- initialization(main).

ocorrencias([], _, 0).
ocorrencias([H1|T], H2, N) :- H1 \== H2, ocorrencias(T, H2, N).
ocorrencias([H|T], H, N) :- ocorrencias(T, H, N2), N is 1 + N2.

main :- ocorrencias([1, 2, 2, 2, 2, 1, 1], 1, N),
        writeln(N),
        halt.
