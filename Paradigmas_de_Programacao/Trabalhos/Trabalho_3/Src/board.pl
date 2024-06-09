:- module(board, [print_matriz/3, get_regions/2, make_regionsHT/3]).

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

print_colored(V, R) :-
    List = [red, green, yellow, blue, magenta, cyan, white],
    atom_codes(R, NL),
    NL = [Num|_],
    IndexColor is mod(Num, 7),
    nth0(IndexColor, List, Color),
    (integer(V) -> V1 = V ; V1 = '.'),
    ansi_format([fg(black), bg8(Color)], ' ~w ', [V1]).

pretty_print_row([], []) :- nl.
pretty_print_row([V|VT], [R|RT]) :-
    print_colored(V, R),
    pretty_print_row(VT, RT).

print_row([]) :- nl.
print_row([V|VT]) :-
    (integer(V) -> write(V) ; write('.')), write(' '),
    print_row(VT).

print_matriz([], [], _).
print_matriz([V|VT], [R|RT], Pretty) :-
    (Pretty == true -> pretty_print_row(V, R) ; print_row(V)),
    print_matriz(VT, RT, Pretty).

