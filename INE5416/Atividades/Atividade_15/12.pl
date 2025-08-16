:- initialization(main).

distancia3D(ponto(X1, Y1, Z1), ponto(X2, Y2, Z2), Dist) :- Dist is sqrt((X1-X2)^2 + (Y1-Y2)^2 + (Z1-Z2)^2).

main :- read(X1),
        read(Y1),
        read(Z1),
        read(X2),
        read(Y2),
        read(Z2),
        distancia3D(ponto(X1, Y1, Z1), ponto(X2, Y2, Z2), Dist),
        writeln(Dist),
        halt.
