%  ----- PREDICADOS -----

% Personalidades 
personalidade(aventureiro). personalidade(romantico).
personalidade(intelectual). personalidade(descontraido).
personalidade(mistico).     personalidade(realista).

% Companhia
companhia(familia).
companhia(amigos).
companhia(sozinho).

% Faixa Etaria
faixa_etaria(crianca). faixa_etaria(adolescente).
faixa_etaria(adulto).  faixa_etaria(idoso).

% Disponibilidade de tempo
disponibilidade(limitado).
disponibilidade(padrao).
disponibilidade(ilimitado).

% Duracao do filme
duracao(curta_metragem).
duracao(padrao).
duracao(longa_metragem).

% Generos
genero(acao).       genero(aventura).  genero(ficcao_cientifica).
genero(suspense).   genero(romance).   genero(drama).
genero(musical).    genero(comedia).   genero(animacao).
genero(fantasia).   genero(terror).    genero(crime).
genero(guerra).     genero(biografia). genero(sobrenatural).
genero(misterio).   genero(historico). genero(documentario).
genero(competicao). genero(educativo). genero(classico).

% Filmes (Abreviacao, Nome, Duracao(min), ClassificaoEtaria, CompanhiaRecomendada, Generos)
filme(ts , "Toy Story"                       , 81 , crianca    , [sozinho, familia, amigos], [animacao, comedia, aventura]).
filme(hp , "Harry Potter e a Pedra Filosoval", 152, crianca    , [sozinho, amigos]         , [fantasia, aventura, competicao]).
filme(its, "Interestelar"                    , 169, adolescente, [sozinho]                 , [fantasia, aventura, competicao]).
filme(rsr, "O resgate do Soldado Ryan"       , 169, adulto     , [sozinho]                 , [ficcao_cientifica, drama, aventura]).
filme(fz , "Frozen"                          , 102, crianca    , [familia, amigos]         , [animacao, musical, aventura]).
filme(ge , "Garota Exemplar"                 , 149, adulto     , [sozinho]                 , [suspense, crime, drama]).
filme(lll, "La La Land"                      , 128, adolescente, [sozinho, amigos]         , [musical, romance, drama]).
filme(im , "Invocacao do Mal"                , 112, adulto     , [sozinho, amigos]         , [terror, suspense, sobrenatural]).
filme(pn , "Procurando Nemo"                 , 100, crianca    , [familia]                 , [animacao, educativo, aventura]).
filme(cl , "Clube da Luta"                   , 139, adulto     , [sozinho, amigos]         , [suspense, drama, crime]).
filme(cb , "Casablanca"                      , 102, idoso      , [sozinho]                 , [classico, romance, drama]).
filme(ji , "O Jogo da Imitacao"              , 114, adolescente, [sozinho, amigos]         , [biografia, guerra, drama]).
filme(jv , "Jogos Vorazes"                   , 142, adolescente, [sozinho, amigos]         , [acao, competicao, ficcao_cientifica]).
filme(cln, "Coraline"                        , 100, adolescente, [sozinho, familia, amigos], [fantasia, terror, animacao]).
filme(mot, "My Octopus Teacher"              , 85 , adulto     , [sozinho]                 , [documentario, educativo, drama]).
filme(ghb, "O Grande Hotel Budapeste"        , 99 , adolescente, [sozinho, familia, amigos], [comedia, aventura, crime]).
filme(eat, "Estrelas Alem do Tempo"          , 127, adolescente, [sozinho, amigos, familia], [biografia, drama, historico]).
filme(if , "Os Infiltrados"                  , 151, adulto     , [sozinho, amigos]         , [crime, suspense, acao]).


% ----- REGRAS -----

% Generos recomendados por personalidade
% Se <personalidade> Entao <Lista Generos Recomendados>
generos_personalidade(aventureiro , [acao, aventura, ficcao_cientifica, suspense]).
generos_personalidade(romantico   , [romance, drama, musical]).
generos_personalidade(intelectual , [ficcao_cientifica, historico, suspense, documentario]).
generos_personalidade(descontraido, [comedia, animacao, romance, acao]).
generos_personalidade(mistico     , [fantasia, terror, aventura]).
generos_personalidade(realista    , [crime, guerra, biografia]).


% Duracao recomendado pelo disponibilidade
% Se limitado  Entao curta_metragem
% Se padrao    Entao curta_metragem e padrao
% Se ilimitado Entao curta_metragem, padrao e longa_metragem
duracao_recomendado(limitado, curta_metragem).
duracao_recomendado(padrao, curta_metragem).
duracao_recomendado(padrao, padrao).
duracao_recomendado(ilimitado, curta_metragem).
duracao_recomendado(ilimitado, padrao).
duracao_recomendado(ilimitado, longa_metragem).

% FaixaEtaria recomendada
% Se crianca     Entao crianca
% Se adolescente Entao crianca e adolescente
% Se adulto      Entao crianca, adolescente, adulto e idoso
% Se idoso       Entao crianca, adolescente, adulto e idoso
faixa_etaria_recomendada(crianca    , crianca).
faixa_etaria_recomendada(adolescente, crianca).
faixa_etaria_recomendada(adolescente, adolescente).
faixa_etaria_recomendada(adulto     , crianca).
faixa_etaria_recomendada(adulto     , adolescente).
faixa_etaria_recomendada(adulto     , adulto).
faixa_etaria_recomendada(adulto     , idoso).
faixa_etaria_recomendada(idoso      , crianca).
faixa_etaria_recomendada(idoso      , adolescente).
faixa_etaria_recomendada(idoso      , adulto).
faixa_etaria_recomendada(idoso      , idoso).

% Duracao

% ----- FUNCOES UTEIS -----

% Associa abreviatura e nome do filme
nome_filme(Abrv, Nome) :- filme(Abrv, Nome, _, _, _, _).

% Associal abreviatura e todos os generos de um filme
todos_os_generos(Abrv, Generos) :- filme(Abrv, _, _, _, _, Generos).

% Verdadeiro se filme possui um genero especifico
possui_genero(Abrv, Genero) :- filme(Abrv, _, _, _, _, Generos), member(Genero, Generos).

% Retorna classificacao do filme por duracao
duracao_filme(Abrv, curta_metragem) :- filme(Abrv, _, Minutos, _, _, _), Minutos < 90.
duracao_filme(Abrv, padrao)         :- filme(Abrv, _, Minutos, _, _, _), Minutos >= 90, Minutos =< 120.
duracao_filme(Abrv, longa_metragem) :- filme(Abrv, _, Minutos, _, _, _), Minutos > 120.

% Associal abreviatura e classificacao etaria do filme
classificacao_etaria(Abrv, ClassificacaoEtaria) :- filme(Abrv, _, _, ClassificacaoEtaria, _, _).

% Verdadeiro se companhia eh recomendada
companhia_recomendada(Abrv, Companhia) :- filme(Abrv, _, _, _, CompanhiaRecomendada, _), member(Companhia, CompanhiaRecomendada).

% Associa abreviatura e faixa etaria do filme
faixa_etaria_filme(Abrv, FaixaEtaria) :- filme(Abrv, _, _, FaixaEtaria, _, _).

% Verdadeiro se faixa etaria da pessoa eh recomendada
member_faixa_etaria_recomendada(Abrv, FaixaEtaria) :-
    faixa_etaria_filme(Abrv, FaixaEtariaFilme),
    faixa_etaria_recomendada(FaixaEtaria, FaixaEtariaFilme).

% ----- FUNCAO DE RECOMENDACAO -----

% Retorna Sugestao de Filmes
sugestao_filme(Personalidade, FaixaEtaria, Disponibilidade, Companhia, Filme) :-
    generos_personalidade(Personalidade, GenerosRecomendados),
    duracao_recomendado(Disponibilidade, ClasseDuracao),


    findall(NomeFilme, (
        nome_filme(Abrv, NomeFilme),

        possui_genero(Abrv, Genero),
        member(Genero, GenerosRecomendados),

        duracao_filme(Abrv, ClasseDuracao),

        companhia_recomendada(Abrv, Companhia),

        member_faixa_etaria_recomendada(Abrv, FaixaEtaria)

    ), ListaFilmes),
    sort(ListaFilmes, ListaFilmesSemRepeticao),
    member(Filme, ListaFilmesSemRepeticao).


% COMO PERDIR SUGESTAO DE FILMES
% Utilize o comando sugestao(<Personalidade>, <FaixaEtaria>, <Disponibilidade>, <Companhia>, Filme).
% Para receber mais de uma recomendação (se houver) aperte o botão ";" para que o programa continue sugerindo

% Personalidade pode ser:
% aventureiro, romantico, intelectual, descontraido, mistico ou realista

% FaixaEtaria pode ser:
% crianca, adolescente, adulto ou idoso

% Disponibilidade pode ser:
% limitado, padrao ou ilimitado.

% Companhia pode ser:
% familia, amigos ou sozinho

% Exemplo de execucao
%   sugestao_filme(descontraido, criaca, ilimitado, familia, F).
%   Output:
%       F = 'Toy Story' ;
%       F = 'Frozen' ;
%       F = 'Procurando Nemo' ;
%       false.

