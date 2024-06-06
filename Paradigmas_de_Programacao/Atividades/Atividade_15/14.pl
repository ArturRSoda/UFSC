:- initialization(main).

operacao('+', X, Y, Resultado) :- Resultado is X + Y.
operacao('-', X, Y, Resultado) :- Resultado is X - Y.
operacao('*', X, Y, Resultado) :- Resultado is X * Y.
operacao('/', X, Y, Resultado) :- Resultado is X / Y.

main :- read(Op),
        read(X),
        read(Y),
        operacao(Op, X, Y, Resultado),
        writeln(Resultado),
        halt.
