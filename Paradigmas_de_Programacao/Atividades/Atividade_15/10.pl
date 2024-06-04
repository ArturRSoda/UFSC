:- initialization(main).

aprovado(A, B, C) :- 6 =< (A + B + C) / 3.

main :- read(A),
        read(B),
        read(C),
        (aprovado(A, B, C) -> writeln('true') ; writeln('false')),
        halt.
