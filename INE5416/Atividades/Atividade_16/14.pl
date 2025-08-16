:- initialization(main).

membro(X,[X|_]).
membro(X,[_|T]) :- membro(X,T).

listaParaConjunto([],[]).
listaParaConjunto([H|T],[H|L]):- not(membro(H,T)), listaParaConjunto(T,L).
listaParaConjunto([H|T],L):- membro(H,T), listaParaConjunto(T,L).

concatena([],L,L).
concatena([H|T],L2,[H|LContatenada]) :- concatena(T,L2,LContatenada).

uniao(S1, S2, S3) :- concatena(S1, S2, R), listaParaConjunto(R, S3).

main :- uniao([1, 2, 3, 4], [1, 2, 5, 6], S3),
        writeln(S3),
        halt.
