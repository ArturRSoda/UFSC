:- module(solve, [solve_board/2]).
:- use_module('Src/board.pl', [make_regionsHT/3, get_regions/2]).


solve_board(ValuesMatriz, RegionsMatriz) :-
    ht_new(RegionHT),
    make_regionsHT(ValuesMatriz, RegionsMatriz, RegionHT),
    get_regions(RegionsMatriz, Regions),
    validate_regions(Regions, RegionHT),

    validate_rows(ValuesMatriz),

    transpose(ValuesMatriz, TranspValueMatriz),
    transpose(RegionsMatriz, TranspRegionsMatriz),
    validate_columns(TranspValueMatriz, TranspRegionsMatriz).

validate_regions([], _) :- !.
validate_regions([R|T], RegionHT) :-
    ht_get(RegionHT, R, RegionList),
    length(RegionList, RegionLen),

    RegionList ins 1..RegionLen,
    all_different(RegionList),

    validate_regions(T, RegionHT).

validate_columns([], []).
validate_columns([VColumn|VT], [RColumn|RT]) :-
    validate_single_column(VColumn, RColumn),
    validate_columns(VT, RT).

validate_single_column([], []).
validate_single_column([_], [_]).
validate_single_column([C1, C2|CT], [R1, R2|RT]) :-
    (R1 == R2 -> C1 #> C2 ; C1 #\= C2),
    validate_single_column([C2|CT], [R2|RT]).

validate_rows([]).
validate_rows([Row|T]) :-
    validate_single_row(Row),
    validate_rows(T).

validate_single_row([]).
validate_single_row([_]).
validate_single_row([V1, V2|T]) :-
    V1 #\= V2,
    validate_single_row([V2|T]).

