:- initialization(main).

aprovado(A, B, C) :- 6 =< (A + B + C) / 3.

fib(N, K) :- (K =:= 1), ((N =:= 1) ; (N =:= 0)).

main :- read(N),
        read(K),
        writeln(N),
        writeln(K),
        divisivel(N, K),
        halt.


