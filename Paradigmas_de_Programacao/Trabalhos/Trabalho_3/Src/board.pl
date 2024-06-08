:- module(board, [make_row/3, make_board/3, print_row/1, print_board/1, get_regions/2, make_regionsDict/3]).


make_row([], [], []).
make_row(ValuesRow, RegionsRow, BoardRow) :-
    ValuesRow = [V|VT],
    RegionsRow = [R|RT],
    make_row(VT, RT, BT),
    BoardRow = [position(V, R)|BT].

make_board([], [], []).
make_board(ValuesMatriz, RegionsMatriz, Board) :-
    ValuesMatriz = [VH|VT],
    RegionsMatriz = [RH|RT],
    make_row(VH, RH, BH),
    make_board(VT, RT, BT),
    Board = [BH|BT].

get_regions(RegionsMatriz, Regions) :- 
    flatten(RegionsMatriz, AllRegions),
    list_to_set(AllRegions, Regions).

make_regionsDict_row([], InDict, InDict).
make_regionsDict_row([position(V, R)|T], InDict, OutDict) :-
    OldRegionList = InDict.get(R, []),
    NewRegionList = [V|OldRegionList],

    TempDict = InDict.put(R, NewRegionList),

    make_regionsDict_row(T, TempDict, OutDict).


make_regionsDict([], InDict, InDict).
make_regionsDict([R|T], InDict, OutDict) :-
    make_regionsDict_row(R, InDict, TempDict),
    make_regionsDict(T, TempDict, OutDict).
    
    
print_row([]) :-
    nl.
print_row([position(V, _)|T]) :-
    write(V), write(" "),
    print_row(T).

print_board([]).
print_board([H|T]) :-
    print_row(H),
    print_board(T).
