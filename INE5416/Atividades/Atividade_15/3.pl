:- initialization(main).

divisivel(N, K) :- (0 =:= mod(N, K) -> writeln('true') ; writeln('false')).

main :- read(N),
        read(K),
        divisivel(N, K),
        halt.
