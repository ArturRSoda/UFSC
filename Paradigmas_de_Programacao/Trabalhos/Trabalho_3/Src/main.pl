:- use_module(library(clpfd)).
:- use_module('Src/solve.pl', [solve_board/2]).

% Le arquivos e monta matrizes de valores e regioes
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

read_matriz(Stream, []) :-
    at_end_of_stream(Stream).
read_matriz(Stream, [H|T]) :-
    read(Stream, H),
    read_matriz(Stream, T).

main(Argv) :-
    Argv = [Path|_], string_upper(Path, PathUpper),       % Recebe Qual tabuleiro resolver como argumento
    build_matriz(PathUpper, ValuesMatriz, RegionsMatriz), % Monta matriz de valores e regioes
    solve_board(ValuesMatriz, RegionsMatriz),             % Resolve tabuleiro
    halt.

