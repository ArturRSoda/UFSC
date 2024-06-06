:- initialization(main).

numerosParaPalavras([], []).
numerosParaPalavras([0|T1], ['zero'|T2])   :- numerosParaPalavras(T1, T2).   
numerosParaPalavras([1|T1], ['um'|T2])     :- numerosParaPalavras(T1, T2).
numerosParaPalavras([2|T1], ['dois'|T2])   :- numerosParaPalavras(T1, T2).
numerosParaPalavras([3|T1], ['tres'|T2])   :- numerosParaPalavras(T1, T2).
numerosParaPalavras([4|T1], ['quatro'|T2]) :- numerosParaPalavras(T1, T2).
numerosParaPalavras([5|T1], ['cinco'|T2])  :- numerosParaPalavras(T1, T2).
numerosParaPalavras([6|T1], ['seis'|T2])   :- numerosParaPalavras(T1, T2).
numerosParaPalavras([7|T1], ['sete'|T2])   :- numerosParaPalavras(T1, T2).
numerosParaPalavras([8|T1], ['oito'|T2])   :- numerosParaPalavras(T1, T2).
numerosParaPalavras([9|T1], ['nove'|T2])   :- numerosParaPalavras(T1, T2).

main :- numerosParaPalavras([1, 2, 3, 4, 5], L2),
        writeln(L2),
        halt.
