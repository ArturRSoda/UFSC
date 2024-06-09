:- module(solve, [solve_board/2]).
:- use_module('Src/board.pl', [make_regionsHT/3, get_regions/2, print_matriz/3]).

% Resolve e imprime tabuleiro
solve_board(ValuesMatriz, RegionsMatriz) :-

    print_matriz(ValuesMatriz, RegionsMatriz, false), nl,  % Imprime Matriz antes de resolver

    ht_new(RegionHT), get_regions(RegionsMatriz, Regions), % Cria novo hash-table e pega lista de regioes
    make_regionsHT(ValuesMatriz, RegionsMatriz, RegionHT), % Monta hash-table das regioes | Keys   -> Regioes

    % Valida:
    %   - Regioes
    validate_regions(Regions, RegionHT),
    %   - Linhas
    validate_rows(ValuesMatriz),        
    %   - Colunas
    transpose(ValuesMatriz, TrVM),  transpose(RegionsMatriz, TrRM), 
    validate_columns(TrVM, TrRM),       

    % Atribui valores a matriz
    maplist(label, ValuesMatriz),

    % Imprime resultado sem cor
    print_matriz(ValuesMatriz, RegionsMatriz, false), nl,

    % Imprime resultado com cor
    print_matriz(ValuesMatriz, RegionsMatriz, true).     

% validate_regions(RegionList, RegionHT)
%   Valida valores da regiao
validate_regions([], _) :- !.
validate_regions([R|T], RegionHT) :-
    ht_get(RegionHT, R, RegionList),
    length(RegionList, RegionLen),
                                 % Valores da regiao:
    RegionList ins 1..RegionLen, %     - Vao de 1 ateh Tamanha da regiao
    all_different(RegionList),   %     - Todos sao diverentes

    validate_regions(T, RegionHT).

% validate_columns(ValuesColumns, RegioesColumn)
%   Valida Colunas 
validate_columns([], []).
validate_columns([VColumn|VT], [RColumn|RT]) :-
    validate_single_column(VColumn, RColumn),
    validate_columns(VT, RT).

% validate_single_column(Column, Region)
%   Metodo auxiliar de validate_columns (logica)
validate_single_column([], []).                      % Se as regioes do valor atual (C1), e seu vizinho (C2) de baixo forem iguais:
validate_single_column([_], [_]).                    %     C1 deve ser maior que C2
validate_single_column([C1, C2|CT], [R1, R2|RT]) :-  % Else
    (R1 == R2 -> C1 #> C2 ; C1 #\= C2),              %     C1 apenas eh diverente de C2
    validate_single_column([C2|CT], [R2|RT]).

% validate_rows(ValuesMatriz)
%   Valida linhas
validate_rows([]).
validate_rows([Row|T]) :-
    validate_single_row(Row),
    validate_rows(T).

% validate_single_row(ValueRow)
%   Metodo auxilidar de validate_rows
%   Valores vizinhos devem ser diferentes
validate_single_row([]).
validate_single_row([_]).
validate_single_row([V1, V2|T]) :-
    V1 #\= V2,            
    validate_single_row([V2|T]).

