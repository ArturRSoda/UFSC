:- initialization(main).

mdc(X, X, X).
mdc(X, Y, Resultado) :- X > Y, A is X-Y, mdc(A, Y, Resultado).
mdc(X, Y, Resultado) :- Y > X, B is Y-X, mdc(X, B, Resultado).

main :- read(X),
        read(Y),
        mdc(X, Y, Resultado),
        writeln(Resultado),
        halt.
