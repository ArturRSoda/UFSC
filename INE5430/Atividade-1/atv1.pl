%  ----- PREDICADOS -----

% Caracteristicas pessoas
% Personalidades 
personalidade(aventureiro). personalidade(romantico).
personalidade(intelectual). personalidade(descontraido).
personalidade(mistico).     personalidade(realista).

% Faixa Etaria
faixa_etaria(crianca). faixa_etaria(adolescente).
faixa_etaria(adulto).

% Disponibilidade de tempo
disponibilidade(limitado).
disponibilidade(padrao).
disponibilidade(ilimitado).

% Caracteristicas filmes
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

% Filmes (Nome, ClasseDuracao, ClassificaoEtaria, Generos)
filme("Toy Story"                       , curta  , crianca    , [animacao, comedia, aventura]).
filme("Harry Potter e a Pedra Filosoval", longa  , crianca    , [fantasia, aventura, competicao]).
filme("Interestelar"                    , longa  , adolescente, [fantasia, aventura, competicao]).
filme("O resgate do Soldado Ryan"       , longa  , adulto     , [ficcao_cientifica, drama, aventura]).
filme("Frozen"                          , padrao , crianca    , [animacao, musical, aventura]).
filme("Garota Exemplar"                 , longa  , adulto     , [suspense, crime, drama]).
filme("La La Land"                      , padrao , adolescente, [musical, romance, drama]).
filme("Invocacao do Mal"                , padrao , adulto     , [terror, suspense, sobrenatural]).
filme("Procurando Nemo"                 , padrao , crianca    , [animacao, educativo, aventura]).
filme("Clube da Luta"                   , longa  , adulto     , [suspense, drama, crime]).
filme("Casablanca"                      , padrao , idoso      , [classico, romance, drama]).
filme("O Jogo da Imitacao"              , padrao , adolescente, [biografia, guerra, drama]).
filme("Jogos Vorazes"                   , longa  , adolescente, [acao, competicao, ficcao_cientifica]).
filme("Coraline"                        , padrao , adolescente, [fantasia, terror, animacao]).
filme("My Octopus Teacher"              , curta  , adulto     , [documentario, educativo, drama]).
filme("O Grande Hotel Budapeste"        , padrao , adolescente, [comedia, aventura, crime]).
filme("Estrelas Alem do Tempo"          , longa  , adolescente, [biografia, drama, historico]).
filme("Os Infiltrados"                  , longa  , adulto     , [crime, suspense, acao]).


% ----- RECOMENDACOES -----

% Generos recomendados por personalidade
% Se <personalidade> Entao <Lista Generos Recomendados>
generos_personalidade(aventureiro , [acao, aventura, ficcao_cientifica]).
generos_personalidade(romantico   , [romance, drama, musical]).
generos_personalidade(intelectual , [ficcao_cientifica, historico, documentario]).
generos_personalidade(descontraido, [comedia, animacao, romance]).
generos_personalidade(mistico     , [fantasia, terror, aventura]).
generos_personalidade(realista    , [crime, guerra, biografia]).

% FaixaEtaria recomendada
% Se crianca     Entao crianca
% Se adolescente Entao crianca Ou adolescente
% Se adulto      Entao crianca Ou adolescente Ou adulto Ou idoso
faixa_etaria_recomendada(crianca    , [crianca]).
faixa_etaria_recomendada(adolescente, [crianca, adolescente]).
faixa_etaria_recomendada(adulto     , [crianca, adolescente, adulto]).

% Duracao recomendada
% Se limitado Entao curta
% Se padrao   Entao curta Ou padrao
% Se ilitado  Entao curta Ou padrao Ou Longa
duracao_recomendada(limitado,  [curta]).
duracao_recomendada(padrao,    [curta, padrao]).
duracao_recomendada(ilimitado, [curta, padrao, longa]).

% ----- UTEIS -----

% Verifica que pelo menos um item da lista1 pertence a lista 2
ao_menos_um_em_comum([X|_], List2) :- member(X, List2).
ao_menos_um_em_comum([_|Tail], List2) :- ao_menos_um_em_comum(Tail, List2).


% ----- REGRAS -----

% Regra 1
% SE aventureiro E limitado E crianca Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica
% E     Duracao = curta_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(aventureiro, limitado, crianca, NomeFilme) :-
    setof(Nome, 
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_ucomum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).


% Regra 2
% SE aventureiro E limitado E adolescente Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(aventureiro, limitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 3
% SE aventureiro E limitado E adulto Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(aventureiro, limitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 4
% SE aventureiro E padrao E crianca Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca
sugestao_filme(aventureiro, padrao, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 5
% SE aventureiro E padrao E adolescente Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem ou padrao
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(aventureiro, padrao, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 6
% SE aventureiro E padrao E adulto Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(aventureiro, padrao, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 7
% SE aventureiro E ilimitado E crianca Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(aventureiro, ilimitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 8
% SE aventureiro E ilimitado E adolescente Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(aventureiro, ilimitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 9
% SE aventureiro E ilimitado E adulto Entao
% ENTAO Genero = acao OU aventura OU ficcao_cientifica]
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(aventureiro, ilimitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [acao, aventura, ficcao_cientifica]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 10
% SE romantico E limitado E crianca Entao
% ENTAO Genero = romance OU drama OU musical
% E     Duracao = curta_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(romantico, limitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 11
% SE romantico E limitado E adolescente Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(romantico, limitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 12
% SE romantico E limitado E adulto Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(romantico, limitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 13
% SE romantico E padrao E crianca Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca
sugestao_filme(romantico, padrao, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 14
% SE romantico E padrao E adolescente Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem ou padrao
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(romantico, padrao, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 15
% SE romantico E padrao E adulto Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(romantico, padrao, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 16
% SE romantico E ilimitado E crianca Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(romantico, ilimitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 17
% SE romantico E ilimitado E adolescente Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(romantico, ilimitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 18
% SE romantico E ilimitado E adulto Entao
% ENTAO Genero = romance OU drama OU musical]
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(romantico, ilimitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [romance, drama, musical]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 19
% SE intelectual E limitado E crianca Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     Duracao = curta_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(intelectual, limitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 20
% SE intelectual E limitado E adolescente Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(intelectual, limitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 21
% SE intelectual E limitado E adulto Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(intelectual, limitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 22
% SE intelectual E padrao E crianca Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca
sugestao_filme(intelectual, padrao, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 23
% SE intelectual E padrao E adolescente Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem ou padrao
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(intelectual, padrao, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 24
% SE intelectual E padrao E adulto Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(intelectual, padrao, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 25
% SE intelectual E ilimitado E crianca Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(intelectual, ilimitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 26
% SE intelectual E ilimitado E adolescente Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(intelectual, ilimitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 27
% SE intelectual E ilimitado E adulto Entao
% ENTAO Genero = ficcao_cientifica OU historico OU documentario
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(intelectual, ilimitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [ficcao_cientifica, historico, documentario]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 28
% SE descontraido E limitado E crianca Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     Duracao = curta_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(descontraido, limitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 29
% SE descontraido E limitado E adolescente Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(descontraido, limitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 30
% SE descontraido E limitado E adulto Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(descontraido, limitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 31
% SE descontraido E padrao E crianca Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca
sugestao_filme(descontraido, padrao, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 32
% SE descontraido E padrao E adolescente Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem ou padrao
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(descontraido, padrao, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 33
% SE descontraido E padrao E adulto Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(descontraido, padrao, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 34
% SE descontraido E ilimitado E crianca Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(descontraido, ilimitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 35
% SE descontraido E ilimitado E adolescente Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(descontraido, ilimitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 36
% SE descontraido E ilimitado E adulto Entao
% ENTAO Genero = comedia OU animacao OU romance
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(descontraido, ilimitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [comedia, animacao, romance]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 37
% SE mistico E limitado E crianca Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     Duracao = curta_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(mistico, limitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 38
% SE mistico E limitado E adolescente Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(mistico, limitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 39
% SE mistico E limitado E adulto Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(mistico, limitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 40
% SE mistico E padrao E crianca Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca
sugestao_filme(mistico, padrao, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 41
% SE mistico E padrao E adolescente Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem ou padrao
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(mistico, padrao, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 42
% SE mistico E padrao E adulto Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(mistico, padrao, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 43
% SE mistico E ilimitado E crianca Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(mistico, ilimitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 44
% SE mistico E ilimitado E adolescente Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(mistico, ilimitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 45
% SE mistico E ilimitado E adulto Entao
% ENTAO Genero = fantasia OU terror OU aventura
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(mistico, ilimitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [fantasia, terror, aventura]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 46
% SE realista E limitado E crianca Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     Duracao = curta_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(realista, limitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 47
% SE realista E limitado E adolescente Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(realista, limitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 48
% SE realista E limitado E adulto Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(realista, limitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 49
% SE realista E padrao E crianca Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca
sugestao_filme(realista, padrao, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 50
% SE realista E padrao E adolescente Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem ou padrao
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(realista, padrao, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 51
% SE realista E padrao E adulto Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem OU padrao
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(realista, padrao, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta, padrao]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 52
% SE realista E ilimitado E crianca Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca
sugestao_filme(realista, ilimitado, crianca, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 53
% SE realista E ilimitado E adolescente Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente
sugestao_filme(realista, ilimitado, adolescente, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% Regra 54
% SE realista E ilimitado E adulto Entao
% ENTAO Genero = crime OU guerra OU biografia
% E     duracao = curta_metragem OU padrao OU longa_metragem
% E     Classificacao Etaria = crianca OU adolescente OU adulto
sugestao_filme(realista, ilimitado, adulto, NomeFilme) :-
    setof(Nome,
    (
        filme(Nome, DuracaoFilme, ClassEtariaFilme, GenerosFilme),
        ao_menos_um_em_comum(GenerosFilme, [crime, guerra, biografia]),
        member(DuracaoFilme, [curta, padrao, longa]),
        member(ClassEtariaFilme, [crianca, adolescente, adulto])
    ), ListaNomeFilme),
    member(NomeFilme, ListaNomeFilme).

% COMO PERDIR SUGESTAO DE FILMES
% Utilize o comando sugestao_filme(<Personalidade>, <Disponibilidade>, <FaixaEtaria>, Filme).
% Para receber mais de uma recomendação (se houver) aperte o botão ";" para que o programa continue sugerindo

% Personalidade pode ser:
% aventureiro, romantico, intelectual, descontraido, mistico ou realista

% FaixaEtaria pode ser:
% crianca, adolescente, adulto

% Disponibilidade pode ser:
% limitado, padrao ou ilimitado.

% Exemplo de execucao
%   sugestao_filme(descontraido, criaca, ilimitado, familia, F).
%   Output:
%       F = 'Toy Story' ;
%       F = 'Frozen' ;
%       F = 'Procurando Nemo' ;
%       false.

