; Sistema Especialista - Recomendacao de filmes

; Templates
(deftemplate Pessoa
    (slot personalidade)
    (slot faixa_etaria)
    (slot disponibilidade))

(deftemplate FilmeRecomendado
    (slot nome)
    (slot duracao)
    (slot generos))

(deftemplate DetalhesFilme
    (slot nome)
    (slot classificacao)
    (slot duracao)
    (multislot generos)
    (slot sinopse))

; Detalhes filmes
(deffacts filmes
    (DetalhesFilme (nome "Toy Story")
        (classificacao crianca) (duracao curta) (generos animacao comedia aventura)
        (sinopse "Brinquedos ganham vida quando humanos não estão olhando"))

    (DetalhesFilme (nome "Harry Potter e a Pedra Filosofal")
        (classificacao crianca) (duracao longa) (generos fantasia aventura competicao)
        (sinopse "Um menino descobre que é um bruxo e entra numa escola de magia"))

    (DetalhesFilme (nome "Interestelar")
        (classificacao adolescente) (duracao longa) (generos ficcao_cientifica drama aventura)
        (sinopse "Astronautas viajam através de um buraco de minhoca para salvar a humanidade"))

    (DetalhesFilme (nome "O resgate do Soldado Ryan")
        (classificacao adulto) (duracao longa) (generos guerra drama)
        (sinopse "Esquadrão militar arrisca tudo para resgatar um soldado durante a 2a Guerra"))

    (DetalhesFilme (nome "Frozen")
        (classificacao crianca) (duracao padrao) (generos animacao musical aventura)
        (sinopse "Princesa com poderes de gelo acidentalmente congela o reino"))

    (DetalhesFilme (nome "Garota Exemplar")
        (classificacao adulto) (duracao longa) (generos suspense crime drama)
        (sinopse "Jornalista investiga o desaparecimento misterioso de sua esposa"))

    (DetalhesFilme (nome "La La Land")
        (classificacao adolescente) (duracao padrao) (generos musical romance drama)
        (sinopse "Artistas lutam por seus sonhos enquanto navegam um romance em Los Angeles"))

    (DetalhesFilme (nome "Invocacao do Mal")
        (classificacao adulto) (duracao padrao) (generos terror suspense sobrenatural)
        (sinopse "Casais assombrados buscam ajuda de investigadores paranormais"))

    (DetalhesFilme (nome "Procurando Nemo")
        (classificacao crianca) (duracao padrao) (generos animacao educativo aventura)
        (sinopse "Peixe-palhaco parte numa jornada oceânica para resgatar seu filho"))

    (DetalhesFilme (nome "Clube da Luta")
        (classificacao adulto) (duracao longa) (generos suspense drama crime)
        (sinopse "Homem desiludido forma um clube secreto de combate que sai do controle"))

    (DetalhesFilme (nome "Casablanca")
        (classificacao adulto) (duracao padrao) (generos classico romance drama)
        (sinopse "Dono de bar em Casablanca ajuda seu antigo amor a fugir dos nazistas"))

    (DetalhesFilme (nome "O Jogo da Imitacao")
        (classificacao adolescente) (duracao padrao) (generos biografia guerra drama)
        (sinopse "Gênio matemático tenta decifrar códigos nazistas durante a 2a Guerra"))

    (DetalhesFilme (nome "Jogos Vorazes")
        (classificacao adolescente) (duracao longa) (generos acao competicao ficcao_cientifica)
        (sinopse "Adolescente é forçada a participar de jogos mortais num futuro distópico"))

    (DetalhesFilme (nome "Coraline")
        (classificacao adolescente) (duracao padrao) (generos fantasia terror animacao)
        (sinopse "Garota descobre uma porta secreta para uma versão alternativa de sua vida"))

    (DetalhesFilme (nome "My Octopus Teacher")
        (classificacao adulto) (duracao curta) (generos documentario educativo drama)
        (sinopse "Cineasta forma um vínculo incomum com um polvo na África do Sul"))

    (DetalhesFilme (nome "O Grande Hotel Budapeste")
        (classificacao adolescente) (duracao padrao) (generos comedia aventura crime)
        (sinopse "Concierge de hotel se envolve num roubo de pintura valiosa nos anos 1930"))

    (DetalhesFilme (nome "Estrelas Alem do Tempo")
        (classificacao adolescente) (duracao longa) (generos biografia drama historico)
        (sinopse "Matemáticas afro-americanas cruciais para o programa espacial dos EUA"))

    (DetalhesFilme (nome "Os Infiltrados")
        (classificacao adulto) (duracao longa) (generos crime suspense acao)
        (sinopse "Policial se infiltra na máfia enquanto mafioso se infiltra na polícia"))
)

; Inputs para setar caracteristicas usuario
(defrule titulo
    (declare (salience 10))
    =>
    (printout t crlf crlf)
    (printout t "Sistema Especialista - Recomendacao de Filmes" crlf)
    (printout t crlf crlf)
    (assert (Pessoa)))

(defrule GetPersonalidade
    (declare (salience 9))
    ?p <- (Pessoa)
    (not (personalidade-coletada))
    =>
    (printout t "Qual sua personalidade?" crlf)
    (printout t "Opcoes: aventureiro, romantico, intelectual, descontraido, mistico, realista" crlf)
    (bind ?resposta (read))
    (printout t crlf)
    (modify ?p (personalidade ?resposta))
    (assert (personalidade-coletada)))

(defrule GetFaixaEtaria
    (declare (salience 8))
    ?p <- (Pessoa)
    (personalidade-coletada)
    (not (faixa-etaria-coletada))
    =>
    (printout t "Qual sua faixa etaria?" crlf)
    (printout t "Opcoes: crianca, adolescente, adulto" crlf)
    (bind ?resposta (read))
    (printout t crlf)
    (modify ?p (faixa_etaria ?resposta))
    (assert (faixa-etaria-coletada)))

(defrule GetDisponibilidade
    (declare (salience 7))
    ?p <- (Pessoa)
    (faixa-etaria-coletada)
    (not (disponibilidade-coletada))
    =>
    (printout t "Qual sua disponibilidade de tempo?" crlf)
    (printout t "Opcoes: limitado, padrao, ilimitado" crlf)
    (bind ?resposta (read))
    (printout t crlf)
    (modify ?p (disponibilidade ?resposta))
    (assert (disponibilidade-coletada)))


; Funcao para printar detalhes dos filmes
(deffunction print-detalhes-filme (?nome ?class ?duracao ?generos ?sinopse)
  (printout t "Recomendacao: " ?nome crlf)
  (printout t "    - Classificacao: " ?class crlf)
  (printout t "    - Duracao: " ?duracao crlf)
  (printout t "    - Generos: " (implode$ ?generos) crlf)
  (printout t "    - Sinopse: " ?sinopse crlf crlf))

; Regras de Recomendacao


(defrule Aventureiro-Crianca-Limitado
    (Pessoa (personalidade aventureiro) (faixa_etaria crianca) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Crianca-Padrao
    (Pessoa (personalidade aventureiro) (faixa_etaria crianca) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Crianca-Ilimitado
    (Pessoa (personalidade aventureiro) (faixa_etaria crianca) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Adolescente-Limitado
    (Pessoa (personalidade aventureiro) (faixa_etaria adolescente) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Adolescente-Padrao
    (Pessoa (personalidade aventureiro) (faixa_etaria adolescente) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Adolescente-Ilimitado
    (Pessoa (personalidade aventureiro) (faixa_etaria adolescente) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Adulto-Limitado
    (Pessoa (personalidade aventureiro) (faixa_etaria adulto) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Adulto-Padrao
    (Pessoa (personalidade aventureiro) (faixa_etaria adulto) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

(defrule Aventureiro-Adulto-Ilimitado
    (Pessoa (personalidade aventureiro) (faixa_etaria adulto) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ acao ?generos) (member$ aventura ?generos) (member$ ficcao_cientifica ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra para mostrar que a recomendação foi concluída
(defrule fim-recomendacao
    (declare (salience -10))
    (disponibilidade-coletada)
    =>
    (printout t crlf)
    (printout t "Fim das recomendacoes." crlf))
