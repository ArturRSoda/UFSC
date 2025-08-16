:- initialization(main).

mdc(X, X, X).
mdc(X, Y, Resultado) :- X > Y, A is X-Y, mdc(A, Y, Resultado).
mdc(X, Y, Resultado) :- Y > X, B is Y-X, mdc(X, B, Resultado).
mdc(X, Y, Z, Resultado) :- mdc(X, Y, R1), mdc(R1, Z, Resultado).

mmc(X, Y, Resultado) :- mdc(X, Y, R1), Resultado is X*(Y/R1).

coprimos(X, Y) :- mdc(X, Y, R), R =:= 1.

totienteEulerAux(N, X, Count, K) :- (X >= N -> K is Count
                                             ; (coprimos(X, N) -> Count2 is Count+1 ; Count2 is Count),
                                               totienteEulerAux(N, X+1, Count2, K)).

totienteEuler(N, K) :- totienteEulerAux(N, 1, 0, K).

main :- read(N),
        totienteEuler(N, K),
        writeln(K),
        halt.
