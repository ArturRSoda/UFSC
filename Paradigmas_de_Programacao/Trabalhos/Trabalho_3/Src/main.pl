:- use_module(library(clpfd)).
:- use_module('Src/solve.pl', [solve_board/2]).

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

main(Argv) :-
    Argv = [Path|_],
    string_upper(Path, PathUpper),
    build_matriz(PathUpper, ValuesMatriz, RegionsMatriz),
    solve_board(ValuesMatriz, RegionsMatriz),
    halt.

