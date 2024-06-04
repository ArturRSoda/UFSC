:- initialization(main).

triangulo(X, Y, Z) :- (Z < X + Y, Y < X + Z, X < Y + Z -> writeln('true') ; writeln('false')).

main :- read(X),
        read(Y),
        read(Z),
        triangulo(X, Y, Z),
        halt.
