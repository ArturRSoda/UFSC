:- initialization(main).

absoluto(N, X) :- X is abs(N).

main :- read(N),
        absoluto(N, X),
        writeln(X),
        halt.
