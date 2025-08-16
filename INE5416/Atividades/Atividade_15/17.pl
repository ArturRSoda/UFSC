:- initialization(main).

mdc(X, X, X).
mdc(X, Y, Resultado) :- X > Y, A is X-Y, mdc(A, Y, Resultado).
mdc(X, Y, Resultado) :- Y > X, B is Y-X, mdc(X, B, Resultado).
mdc(X, Y, Z, Resultado) :- mdc(X, Y, R1), mdc(R1, Z, Resultado).

mmc(X, Y, Resultado) :- mdc(X, Y, R1), Resultado is X*(Y/R1).

main :- read(X),
        read(Y),
        mmc(X, Y, Resultado),
        writeln(Resultado),
        halt.
