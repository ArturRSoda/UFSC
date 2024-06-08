:- module(solve, [solve_board/3]).
:- use_module('Src/board.pl').


solve_board(ValuesMatriz, RegionsMatriz, Len) :-
    maplist(same_length(ValuesMatriz), ValuesMatriz),
    append(ValuesMatriz, Vs), Vs ins 1..Len,

    maplist(validate_row, ValuesMatriz).

    make_board(ValuesMatriz, RegionsMatriz, TempBoard),
    %transpose(TempBoard, TransposedBoard),
    
    %maplist(validate_column, TransposedBoard),

    %make_regionsDict(TempBoard, _{}, RegionsDict),
    %get_regions(RegionsMatriz, Regions),

    %validate_regions(Regions, RegionsDict).





validate_regions([], _) :- !.
validate_regions([R|T], RegionsDict) :-
    RegionList = RegionsDict.get(R),
    length(RegionList, RegionLen),
    max_member(HigherValue, RegionList),

    HigherValue =< RegionLen,
    all_different(RegionList),
    %maplist(>(RegionLen), RegionList),

    validate_regions(T, RegionsDict).



validate_column([]) :- !.
validate_column([_]) :- !.
validate_column([position(V1, R1), position(V2, R2)|T]) :-
    (R1 == R2 -> V1 #> V2 ; V1 \== V2),
    validate_column(T).
    

validate_row([]) :- !.
validate_row([_]) :- !.
validate_row([V1, V2|T]) :-
    V1 \== V2,
    validate_row(T).

