:- initialization(main).

eqSegundoGrau(A, B, C, ValorX) :- ValorX is (-B + sqrt(B*B - 4*A*C)) / 2*A; (-B - sqrt(B*B - 4*A*C)) / 2*A.

main :- read(A),
        read(B),
        read(C),
        eqSegundoGrau(A, B, C, ValorX),
        writeln(ValorX),
        halt.
