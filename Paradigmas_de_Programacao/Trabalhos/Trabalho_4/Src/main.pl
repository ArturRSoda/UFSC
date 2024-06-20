% --------------------------------------------------- FATOS ---------------------------------------------------
calca(amarela). calca(azul). calca(branca). calca(verde). calca(vermelha).

nome(alice). nome(giovana). nome(isabela). nome(marta). nome(roberta).

posicao(arvore). posicao(corvo). posicao(lotus). posicao(ponte). posicao(triangulo).

matricula(2012). matricula(2013). matricula(2014). matricula(2015). matricula(2016). 

idade(24). idade(30). idade(36). idade(42). idade(48). 

profissao(arquiteta). profissao(comerciante). profissao(manicure). profissao(motorista). profissao(psicologa). 
% -------------------------------------------------------------------------------------------------------------


% ----------------------------- REGRAS -----------------------------
% X esta ao lado de Y
aoLado(X,Y,Lista) :-
    nextto(X,Y,Lista);
    nextto(Y,X,Lista).
                       
% X esta mais a esquerda da lista do que Y
aEsquerda(X,Y,Lista) :-
    nth0(IndexX,Lista,X), 
    nth0(IndexY,Lista,Y), 
    IndexX < IndexY.

% X esta exatamente a esquerda de Y
exatamenteAEsquerda(X, Y, Lista) :-
    aEsquerda(X, Y, Lista),
    aoLado(X, Y, Lista).
                        
% X esta mais a direita da lista do que Y
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

% Todos valores da lista sao diferentes
todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

% Y esta entre X e Z, nao necessariamente ao lado
entre(Y, X, Z, Lista) :-
    aDireita(Y, X, Lista),
    aEsquerda(Y, Z, Lista).
% ------------------------------------------------------------------

% ------------------------------------------------- SOLUCAO -------------------------------------------------
% Problema 23 - Aula de Yoga: https://rachacuca.com.br/logica/problemas/aula-de-yoga/

main :-
    Solucao = [
        aluna(C1, N1, Pos1, Mat1, Id1, Prof1),
        aluna(C2, N2, Pos2, Mat2, Id2, Prof2),
        aluna(C3, N3, Pos3, Mat3, Id3, Prof3),
        aluna(C4, N4, Pos4, Mat4, Id4, Prof4),
        aluna(C5, N5, Pos5, Mat5, Id5, Prof5)
    ],

    % A aluna de calça Branca está em algum lugar à esquerda da aluna que se matriculou em 2014.
    aEsquerda(aluna(branca, _, _, _, _, _), aluna(_, _, _, 2014, _, _), Solucao),

    % Isabela está no segundo lugar.
    N2 = isabela,

    % Marta é Motorista.
    member(aluna(_, marta, _, _, _, motorista), Solucao),

    % A aluna de calça Verde está em algum lugar entre a Arquiteta e a mulher de 36 anos, nessa ordem.
    entre(aluna(verde, _, _, _, _, _), aluna(_, _, _, _, _, arquiteta), aluna(_, _, _, _, 36, _), Solucao),

    % No quarto lugar está a mulher de 30 anos.
    Id4 = 30,

    % A Manicure está exatamente à esquerda da aluna que gosta de fazer a Ponte.
    exatamenteAEsquerda(aluna(_, _, _, _, _, manicure), aluna(_, _, ponte, _, _, _), Solucao),

    % A aluna de calça Azul está ao lado da aluna de 48 anos.
    aoLado(aluna(azul, _, _, _, _, _), aluna(_, _, _, _, 48, _), Solucao),

    % A Psicóloga está em algum lugar entre a aluna matriculada a mais tempo e a Comerciante, nessa ordem.
    entre(aluna(_, _, _, _, _, psicologa), aluna(_, _, _, 2012, _, _), aluna(_, _, _, _, _, comerciante), Solucao),

    % A Motorista está em algum lugar à direita da aluna de calça Branca.
    aDireita(aluna(_, _, _, _, _, motorista), aluna(branca, _, _, _, _, _), Solucao),

    % A aluna que gosta da posição Lótus está exatamente à esquerda da aluna que gosta da posição Triângulo.
    exatamenteAEsquerda(aluna(_, _, lotus, _, _, _), aluna(_, _, triangulo, _, _, _), Solucao),

    % A mulher que se matriculou em 2013 está no quarto lugar.
    Mat4 = 2013,

    % A aluna de calça Amarela está em algum lugar entre a aluna matriculada mais recentemente e a aluna de calça Branca, nessa ordem.
    entre(aluna(amarela, _, _, _, _, _), aluna(_, _, _, 2016, _, _), aluna(branca, _, _, _, _, _), Solucao),

    % A mulher de 42 anos gosta da posição Lótus.
    member(aluna(_, _, lotus, _, 42, _), Solucao),

    % Alice está em algum lugar à direita da aluna de calça Verde.
    aDireita(aluna(_, alice, _, _, _, _), aluna(verde, _, _, _, _, _), Solucao),

    % A aluna que gosta da posição Corvo está no primeiro lugar.
    Pos1 = corvo,

    % As mulheres de 42 e 48 anos estão lado a lado.
    aoLado(aluna(_, _, _, _, 42, _), aluna(_, _, _, _, 48, _), Solucao),

    % Quem se matriculou em 2016 está em algum lugar entre quem se matriculou em 2012 e quem se matriculou em 2015, nessa ordem.
    entre(aluna(_, _, _, 2016, _, _), aluna(_, _, _, 2012, _, _), aluna(_, _, _, 2015, _, _), Solucao),

    % A aluna que gosta da posição Árvore está em algum lugar à esquerda da aluna de calça Branca.
    aEsquerda(aluna(_, _, arvore, _, _, _), aluna(branca, _, _, _, _, _), Solucao),

    % Giovana está ao lado da Comerciante.
    aoLado(aluna(_, giovana, _, _, _, _), aluna(_, _, _, _, _, comerciante), Solucao),

    % Definindo valores
    calca(C1), calca(C2), calca(C3), calca(C4), calca(C5), 
    todosDiferentes([C1, C2, C3, C4, C5]),

    nome(N1), nome(N2), nome(N3), nome(N4), nome(N5),
    todosDiferentes([N1, N2, N3, N4, N5]),

    posicao(Pos1), posicao(Pos2), posicao(Pos3), posicao(Pos4), posicao(Pos5),
    todosDiferentes([Pos1, Pos2, Pos3, Pos4, Pos5]),

    matricula(Mat1), matricula(Mat2), matricula(Mat3), matricula(Mat4), matricula(Mat5),
    todosDiferentes([Mat1, Mat2, Mat3, Mat4, Mat5]),

    idade(Id1), idade(Id2), idade(Id3), idade(Id4), idade(Id5), 
    todosDiferentes([Id1, Id2, Id3, Id4, Id5]),

    profissao(Prof1), profissao(Prof2), profissao(Prof3), profissao(Prof4), profissao(Prof5), 
    todosDiferentes([Prof1, Prof2, Prof3, Prof4, Prof5]),

    % Imprime a solucao
    imprimeSolucao(Solucao).
% -----------------------------------------------------------------------------------------------------------

    
% Imprime solucao
imprimeSolucao(Solucao) :-
    writef('%8L  %10L %9L %11L %10L %7L %10L', [' ', 'Calca', 'Nome', 'Posicao', 'Matricula', 'Idade', 'Proficao']), nl,
    imprimeSolucaoAux(1, Solucao).

imprimeSolucaoAux(_, []).
imprimeSolucaoAux(I, [aluna(C, N, Pos, Mat, Id, Prof)|T]) :-
    writef('Aluna#%2L  %10L %9L %11L %10L %7L %10L', [I, C, N, Pos, Mat, Id, Prof]), nl,
    Im is I+1,
    imprimeSolucaoAux(Im, T).
