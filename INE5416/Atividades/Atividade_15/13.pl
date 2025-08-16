:- initialization(main).

maior(A, B, C, X) :- (A > B -> (A > C -> X is A ; X is C) ; (B > C -> X is B ; X is C)).

main :- read(A),
        read(B),
        read(C),
        maior(A, B, C, X),
        writeln(X),
        halt.
