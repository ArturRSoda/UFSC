:- module(solve, [solve_board/3]).
:- use_module('Src/board.pl').


solve_board(ValuesMatriz, RegionsMatriz, Len) :-
    maplist(same_length(ValuesMatriz), ValuesMatriz),
    append(ValuesMatriz, Vs), Vs ins 1..Len,

    validate_rows(ValuesMatriz, Len).

    %make_board(ValuesMatriz, RegionsMatriz, TempBoard),
    %transpose(TempBoard, TransposedBoard),
    
    %maplist(validate_column, TransposedBoard),

    %make_regionsDict(TempBoard, _{}, RegionsDict),
    %get_regions(RegionsMatriz, Regions),

    %validate_regions(Regions, RegionsDict).

validate_rows([], _).
validate_rows([Row|T], Len) :-
    (0 =:= mod(Len, 2) ->
        validate_even_row(Row) ;
        validate_odd_row(Row)),
    validate_rows(T, Len).

validate_even_row([]).
validate_even_row([V1, V2|T]) :-
    V1 \== V2,
    validate_even_row(T).

validate_odd_row([]).
validate_odd_row([V1, V2, V3|T]) :-
    V1 \== V2,
    V2 \== V3,
    validate_even_row(T).


validate_regions([], _) :- !.
validate_regions([R|T], RegionsDict) :-
    RegionList = RegionsDict.get(R),
    length(RegionList, RegionLen),
    max_member(HigherValue, RegionList),

    HigherValue =< RegionLen,
    all_different(RegionList),
    %maplist(>(RegionLen), RegionList),

    validate_regions(T, RegionsDict).


is_even_arr([]) :- !.
is_even_arr([_|T]) :- is_odd_arr(T).

is_odd_arr([_]) :- !.
is_odd_arr([_|T]) :- is_even_arr(T).
