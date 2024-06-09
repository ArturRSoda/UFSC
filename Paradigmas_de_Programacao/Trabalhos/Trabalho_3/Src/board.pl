:- module(board, [print_row/1, print_matriz/1, get_regions/2, make_regionsHT/3]).

get_regions(RegionsMatriz, Regions) :- 
    flatten(RegionsMatriz, AllRegions),
    list_to_set(AllRegions, Regions).

make_regionsHT_row([], [], _).
make_regionsHT_row([V|VT], [R|RT], HT) :-
    ht_put(HT, R, [V|OldRegionList], [], OldRegionList),
    make_regionsHT_row(VT, RT, HT).

make_regionsHT([], [], _).
make_regionsHT([VRow|VT], [RRow|RT], HT) :-
    make_regionsHT_row(VRow, RRow, HT),
    make_regionsHT(VT, RT, HT).
    
    
print_row([]) :-
    nl.
print_row([V|T]) :-
    (integer(V) -> write(V) ; write(".")), write(" "),
    print_row(T).

print_matriz([]).
print_matriz([H|T]) :-
    print_row(H),
    print_matriz(T).
