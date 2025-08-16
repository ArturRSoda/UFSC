:- initialization(main).

primo(X) :- X =< 2, X > 1.
primo(X) :- X > 3, X mod 2 =\= 0, primo(X, 3).

primo(X, N) :- (N*N > X -> true
                            ;  X mod N =\= 0, M is N + 2, primo(X, M)).

main :- read(N),
        (primo(N) -> writeln("true") ; writeln("false")),
        halt.
