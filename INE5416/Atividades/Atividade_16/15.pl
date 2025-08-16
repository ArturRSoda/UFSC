:- initialization(main).

membro(X,[X|_]).
membro(X,[_|T]) :- membro(X,T).

diferenca([], _, []).
diferenca([H1|T1], L2, S3) :- not(membro(H1, L2)), diferenca(T1, L2, R), S3 is [H1|R].
diferenca([H1|T1], L2, S3) :- membro(H1, L2), diferenca(T1, L2, S3).


main :- diferenca([1, 2, 3, 4], [1, 2], S3),
        writeln(S3),
        halt.
