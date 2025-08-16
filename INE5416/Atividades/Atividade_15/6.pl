:- initialization(main).

potencia(X, Y, Resultado) :- Resultado is X^Y.

main :- read(A),
        read(B),
        potencia(A, B, Resultado),
        writeln(Resultado),
        halt.

