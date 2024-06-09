:- module(board, [print_matriz/3, get_regions/2, make_regionsHT/3]).

% Retorna lista de regioes
get_regions(RegionsMatriz, Regions) :- 
    flatten(RegionsMatriz, AllRegions),
    list_to_set(AllRegions, Regions).

% make_regionsHT(ValuesMatriz, RegionsMatriz), Hash-Table)
%   Monta hash-table das regioes, onde:
%       As chaves sao as regioes
%       Os valores sao listas dos valores da respectiva regiao
make_regionsHT([], [], _).
make_regionsHT([VRow|VT], [RRow|RT], HT) :-
    make_regionsHT_row(VRow, RRow, HT),
    make_regionsHT(VT, RT, HT).

% make_regionsHT_row(ValuesRow, RegionRow, Hash-Table)
%   Metodo auxiliar de make_regionsHT,
%       Insere valores na hash-table
make_regionsHT_row([], [], _).
make_regionsHT_row([V|VT], [R|RT], HT) :-
    ht_put(HT, R, [V|OldRegionList], [], OldRegionList),
    make_regionsHT_row(VT, RT, HT).


% print_matriz(ValuesMatriz, RegionsMatriz, Pretty)
%   Imprime tabuleiro
%       (Pretty == true -> Imprime colorido ; Imprime Sem cor).
print_matriz([], [], _).
print_matriz([V|VT], [R|RT], Pretty) :-
    (Pretty == true -> pretty_print_row(V, R) ; print_row(V)),
    print_matriz(VT, RT, Pretty).

% pretty_print_row(ValueRow, RegionRow)
%   Imprime linha da ValueMatriz Com Cor
pretty_print_row([], []) :- nl.
pretty_print_row([V|VT], [R|RT]) :-
    print_colored(V, R),
    pretty_print_row(VT, RT).

% print_row(ValueRow)
%   Imprime linha da ValueMatriz sem cor
print_row([]) :- nl.
print_row([V|VT]) :-
    (integer(V) -> write(V) ; write('.')), write(' '),
    print_row(VT).

% Metodo auxiliar de pretty_print_row
print_colored(V, R) :-
    List = [red, green, yellow, blue, magenta, cyan, white],
    atom_codes(R, NL),
    NL = [Num|_],
    IndexColor is mod(Num, 7),
    nth0(IndexColor, List, Color),
    (integer(V) -> V1 = V ; V1 = '.'),
    ansi_format([fg(black), bg8(Color)], ' ~w ', [V1]).

