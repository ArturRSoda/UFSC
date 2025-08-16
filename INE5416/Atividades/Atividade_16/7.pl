:- initialization(main).

reverteAux([], R, R).
reverteAux([X|T1], T2, R) :- reverteAux(T1, [X|T2], R).

reverte(L, R) :- reverteAux(L, [], R).

palindromeAux([], []) :- !.
palindromeAux([H1|_], [H2|_]) :- H1 \== H2, false.
palindromeAux([H|T1], [H|T2]) :- palindromeAux(T1, T2).

palindrome(L) :- reverte(L, R), palindromeAux(L, R).

main :- (palindrome([1, 2, 3, 2, 1]) -> writeln("true") ; writeln("false")),
        (palindrome([1, 2]) -> writeln("true") ; writeln("false")),
        halt.
