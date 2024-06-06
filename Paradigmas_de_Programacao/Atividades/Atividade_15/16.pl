:- initialization(main).

mdc(X, X, X).
mdc(X, Y, Resultado) :- X > Y, A is X-Y, mdc(A, Y, Resultado).
mdc(X, Y, Resultado) :- Y > X, B is Y-X, mdc(X, B, Resultado).
mdc(X, Y, Z, Resultado) :- mdc(X, Y, R1), mdc(R1, Z, Resultado).

main :- read(X),
        read(Y),
        read(Z),
        mdc(X, Y, Z, Resultado),
        writeln(Resultado),
        halt.
