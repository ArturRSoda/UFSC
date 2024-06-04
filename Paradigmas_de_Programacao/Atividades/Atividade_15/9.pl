:- initialization(main).

xor(X, Y) :- true, ((X , not(Y)) ; (not(X) , Y)).

main :- read(X),
        read(Y),
        (xor(X, Y) -> writeln('true') ; writeln('false')),
        halt.
