% Personalidades 
personalidade(aventureiro). personalidade(romantico).
personalidade(intelectual). personalidade(descontraido).
personalidade(mistico).     personalidade(realista).

% Generos
genero(acao).     genero(aventura).  genero(ficcao_cientifica).
genero(suspense). genero(romance).   genero(drama).
genero(musical).  genero(comedia).   genero(animacao).
genero(fantasia). genero(terror).    genero(crime).
genero(guerra).   genero(biografia). genero(sobrenatural).
genero(misterio). genero(historico). genero(documentario).

% Filmes (Abreviacao, Nome, Generos)
filme(mm, 'Mad Max: Estrada da Furia', [ficcao_cientifica, aventura, acao]).
filme(ij, 'Indiana Jones', [aventura, acao]).
filme(mi, 'Missao Impossivel', [acao, aventura]).
filme(ce, 'A Culpa e das Estrelas', [romance, drama]).
filme(sa, 'Simplesmente Acontece', [romance, comedia]).
filme(ji, 'O jogo da Imitacao', [drama, biografia, guerra, historico]).
filme(it, 'Interestelar', [ficcao_cientifica, aventura, drama]).
filme(ab, 'As Branquelas', [comedia]).
filme(dp, 'Deadpool', [comedia, acao]).
filme(mp, 'Todo Mundo em Panico', [comedia, terror]).
filme(sda, 'O Senhor dos Aneis', [aventura, fantasia]).
filme(im, 'Invocacao do Mal', [terror, sobrenatural]).
filme(oi, 'Os Infiltrados', [suspense, crime]).
filme(mb, 'Uma mente Brilante', [biografia, drama, misterio, historico]).
filme(lll,'La La Land', [musical, drama, comedia, romance]).
filme(sn, 'Senna: O Brasileiro, O Heroi, O campeao', [biografia, historico, documentario]).
filme(cc, 'Charlie: A vida e a Arte de Charles Chaplin', [biografia, documentario]).
filme(avc, 'A viagem de Chihiro', [animacao, sobrenatural, aventura, fantasia]).
filme(sk, 'Sherek', [animacao, comedia, fantasia]).

% Generos recomendados por personalidade
generos_recomendados(aventureiro, [acao, aventura, ficcao_cientifica, suspense]).
generos_recomendados(romantico, [romance, drama, musical]).
generos_recomendados(intelectual, [ficcao_cientifica, historico, suspense, documentario]).
generos_recomendados(descontraido, [comedia, animacao, romance]).
generos_recomendados(mistico, [fantasia, terror, aventura]).
generos_recomendados(realista, [crime, guerra, biografia]).

% Funcoes

% Retorna nome do filme
nome_filme(Abrv, Nome) :- filme(Abrv, Nome, _).

% Retorna todos os generos de um filme
todos_os_generos(Abrv, Generos) :- filme(Abrv, _, Generos).

% Retorna verdadeiro se filme possui um genero especifico
possui_genero(Abrv, Genero) :- filme(Abrv, _, Generos), member(Genero, Generos).

% Retorna Sugestao de Filmes de acordo com os generos recomendados a Personalidade
sugestao_filme(Personalidade, Filme) :-
    generos_recomendados(Personalidade, GenerosRecomendados), % Retorna todos os generos recomentados a Personalidade
    findall(NomeFilme, (                                      % Acha todos os filmes que combinam com pelo menos um genero retornado
        nome_filme(Abrv, NomeFilme),
        possui_genero(Abrv, Genero),
        member(Genero, GenerosRecomendados)
    ), ListaFilmes),
    sort(ListaFilmes, ListaFilmesSemRepeticao),               % Remove filmes duplicados e organiza lista
    member(Filme, ListaFilmesSemRepeticao).


% COMO PERDIR SUGESTAO DE FILMES
% Utilize o comando sugestao(<Personalidade>, Filme).
% Para receber mais de uma recomendação (se houver) aperte o botão ";" para que o programa continue sugerindo

% Onde as personalidades podem ser:
% Aventureiro
% Romantico
% Intelectual
% Descontraido
% Mistico
% Realista

% Exemplo de execucao
%   sugestao_filme(aventureiro, F).
%   Output:
%       F = 'Indiana Jones' ;
%       F = 'Interestelar' ;
%       F = 'Mad Max: Estrada da Furia' ;
%       F = 'Missao Impossivel' ;
%       F = 'O Senhor dos Aneis' ;
%       F = 'Os Infiltrados'.

