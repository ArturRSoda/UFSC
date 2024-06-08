:- use_module(library(clpfd)).
:- use_module('Src/solve.pl').

read_matriz(Stream, []) :-
    at_end_of_stream(Stream).
read_matriz(Stream, [H|T]) :-
    read(Stream, H),
    read_matriz(Stream, T).

build_matriz(Path, ValuesMatriz, RegionsMatriz) :-
    atom_concat('Entradas/', Path, P1),
    atom_concat(P1, '/numbers.txt', ValuesPath),
    atom_concat(P1, '/regions.txt', RegionsPath),

    open(ValuesPath, read, ValuesStr),
    open(RegionsPath, read, RegionsStr),

    read_matriz(ValuesStr, ValuesFile),
    read_matriz(RegionsStr, RegionsFile),

    close(ValuesStr),
    close(RegionsStr),

    ValuesFile = [ValuesMatriz|_],
    RegionsFile = [RegionsMatriz|_].

problem(1, [[2, _, _, _, 1, _],
           [_, _, _, 3, _, _],
           [_, 3, _, _, 5, 3],
           [_, _, _, _, _, _],
           [_, _, 3, _, 4, 2],
           [_, _, _, _, _, _]],

           [[a, a, b, b, b, c],
            [d, d, d, d, d, c],
            [e, f, f, f, d, g],
            [e, e, e, f, g, g],
            [h, h, i, j, j, j],
            [k, k, i, i, j, j]]).

main(Argv) :-
    %Argv = [Path|_],
    %string_upper(Path, PathUpper),
    %build_matriz(PathUpper, ValuesMatriz, RegionsMatriz),

    length(ValuesMatriz, Len),
    solve_board(ValuesMatriz, RegionsMatriz, Len),

    maplist(portray_clause, ValuesMatriz),


    halt.

