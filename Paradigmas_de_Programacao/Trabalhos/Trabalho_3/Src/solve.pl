:- module(solve, [solve_board/2]).
:- use_module('Src/board.pl', [make_regionsHT/3, get_regions/2, print_matriz/3]).

% Resolve e imprime tabuleiro
solve_board(ValuesMatriz, RegionsMatriz) :-

    print_matriz(ValuesMatriz, RegionsMatriz, false), nl,  % Imprime Matriz antes de resolver

    ht_new(RegionHT), get_regions(RegionsMatriz, Regions), % Cria novo hash-table e pega lista de regioes
    make_regionsHT(ValuesMatriz, RegionsMatriz, RegionHT), % Monta hash-table das regioes | Keys   -> Regioes

    % Restricoes das:
    %   - Regioes
    regions_constraint(Regions, RegionHT),
    %   - Linhas
    rows_constraint(ValuesMatriz),        
    %   - Colunas
    transpose(ValuesMatriz, TrVM),  transpose(RegionsMatriz, TrRM), 
    columns_constraint(TrVM, TrRM),       

    % Atribui valores a matriz
    maplist(label, ValuesMatriz),

    % Imprime resultado sem cor
    print_matriz(ValuesMatriz, RegionsMatriz, false), nl,

    % Imprime resultado com cor
    print_matriz(ValuesMatriz, RegionsMatriz, true).     

% regions_constraint(RegionList, RegionHT)
%   Restricoes dos valores da regiao
regions_constraint([], _) :- !.
regions_constraint([R|T], RegionHT) :-
    ht_get(RegionHT, R, RegionList),
    length(RegionList, RegionLen),
                                 % Valores da regiao:
    RegionList ins 1..RegionLen, %     - Vao de 1 ateh Tamanha da regiao
    all_different(RegionList),   %     - Todos sao diverentes

    regions_constraint(T, RegionHT).

% columns_constraint(ValuesColumns, RegioesColumn)
%   Restricoes das colunas
columns_constraint([], []).
columns_constraint([VColumn|VT], [RColumn|RT]) :-
    single_columns_constraint(VColumn, RColumn),
    columns_constraint(VT, RT).

% single_columns_constraint(Column, Region)
%   Metodo auxiliar de columns_constraint (logica)
single_columns_constraint([], []).                      % Se as regioes do valor atual (C1), e seu vizinho (C2) de baixo forem iguais:
single_columns_constraint([_], [_]).                    %     C1 deve ser maior que C2
single_columns_constraint([C1, C2|CT], [R1, R2|RT]) :-  % Else
    (R1 == R2 -> C1 #> C2 ; C1 #\= C2),                 %     C1 apenas eh diverente de C2
    single_columns_constraint([C2|CT], [R2|RT]).

% rows_constraint(ValuesMatriz)
%   Valida linhas
rows_constraint([]).
rows_constraint([Row|T]) :-
    single_row_constraint(Row),
    rows_constraint(T).

% single_row_constraint(ValueRow)
%   Metodo auxilidar de rows_constraint
%   Valores vizinhos devem ser diferentes
single_row_constraint([]).
single_row_constraint([_]).
single_row_constraint([V1, V2|T]) :-
    V1 #\= V2,            
    single_row_constraint([V2|T]).

