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

; Regra 1
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

; Regra 2
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

; Regra 3
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

; Regra 4
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

; Regra 5
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

; Regra 6
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

; Regra 7
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

; Regra 8
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

; Regra 9
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

; Regra 10
(defrule Romantico-Crianca-Limitado
    (Pessoa (personalidade romantico) (faixa_etaria crianca) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 11
(defrule Romantico-Crianca-Padrao
    (Pessoa (personalidade romantico) (faixa_etaria crianca) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 12
(defrule Romantico-Crianca-Ilimitado
    (Pessoa (personalidade romantico) (faixa_etaria crianca) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 13
(defrule Romantico-Adolescente-Limitado
    (Pessoa (personalidade romantico) (faixa_etaria adolescente) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 14
(defrule Romantico-Adolescente-Padrao
    (Pessoa (personalidade romantico) (faixa_etaria adolescente) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 15
(defrule Romantico-Adolescente-Ilimitado
    (Pessoa (personalidade romantico) (faixa_etaria adolescente) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 16
(defrule Romantico-Adulto-Limitado
    (Pessoa (personalidade romantico) (faixa_etaria adulto) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 17
(defrule Romantico-Adulto-Padrao
    (Pessoa (personalidade romantico) (faixa_etaria adulto) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 18
(defrule Romantico-Adulto-Ilimitado
    (Pessoa (personalidade romantico) (faixa_etaria adulto) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ romance ?generos) (member$ drama ?generos) (member$ musical ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 19
(defrule Intelectual-Crianca-Limitado
    (Pessoa (personalidade intelectual) (faixa_etaria crianca) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 20
(defrule Intelectual-Crianca-Padrao
    (Pessoa (personalidade intelectual) (faixa_etaria crianca) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 21
(defrule Intelectual-Crianca-Ilimitado
    (Pessoa (personalidade intelectual) (faixa_etaria crianca) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 22
(defrule Intelectual-Adolescente-Limitado
    (Pessoa (personalidade intelectual) (faixa_etaria adolescente) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 23
(defrule Intelectual-Adolescente-Padrao
    (Pessoa (personalidade intelectual) (faixa_etaria adolescente) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 24
(defrule Intelectual-Adolescente-Ilimitado
    (Pessoa (personalidade intelectual) (faixa_etaria adolescente) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 25
(defrule Intelectual-Adulto-Limitado
    (Pessoa (personalidade intelectual) (faixa_etaria adulto) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 26
(defrule Intelectual-Adulto-Padrao
    (Pessoa (personalidade intelectual) (faixa_etaria adulto) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 27
(defrule Intelectual-Adulto-Ilimitado
    (Pessoa (personalidade intelectual) (faixa_etaria adulto) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ ficcao_cientifica ?generos) (member$ historico ?generos) (member$ documentario ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 28
(defrule Descontraido-Crianca-Limitado
    (Pessoa (personalidade descontraido) (faixa_etaria crianca) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 29
(defrule Descontraido-Crianca-Padrao
    (Pessoa (personalidade descontraido) (faixa_etaria crianca) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 30
(defrule Descontraido-Crianca-Ilimitado
    (Pessoa (personalidade descontraido) (faixa_etaria crianca) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 31
(defrule Descontraido-Adolescente-Limitado
    (Pessoa (personalidade descontraido) (faixa_etaria adolescente) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 32
(defrule Descontraido-Adolescente-Padrao
    (Pessoa (personalidade descontraido) (faixa_etaria adolescente) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 33
(defrule Descontraido-Adolescente-Ilimitado
    (Pessoa (personalidade descontraido) (faixa_etaria adolescente) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 34
(defrule Descontraido-Adulto-Limitado
    (Pessoa (personalidade descontraido) (faixa_etaria adulto) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 35
(defrule Descontraido-Adulto-Padrao
    (Pessoa (personalidade descontraido) (faixa_etaria adulto) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 36
(defrule Descontraido-Adulto-Ilimitado
    (Pessoa (personalidade descontraido) (faixa_etaria adulto) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ comedia ?generos) (member$ animacao ?generos) (member$ romance ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 37
(defrule Mistico-Crianca-Limitado
    (Pessoa (personalidade mistico) (faixa_etaria crianca) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 38
(defrule Mistico-Crianca-Padrao
    (Pessoa (personalidade mistico) (faixa_etaria crianca) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 39
(defrule Mistico-Crianca-Ilimitado
    (Pessoa (personalidade mistico) (faixa_etaria crianca) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 40
(defrule Mistico-Adolescente-Limitado
    (Pessoa (personalidade mistico) (faixa_etaria adolescente) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 41
(defrule Mistico-Adolescente-Padrao
    (Pessoa (personalidade mistico) (faixa_etaria adolescente) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 42
(defrule Mistico-Adolescente-Ilimitado
    (Pessoa (personalidade mistico) (faixa_etaria adolescente) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 43
(defrule Mistico-Adulto-Limitado
    (Pessoa (personalidade mistico) (faixa_etaria adulto) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 44
(defrule Mistico-Adulto-Padrao
    (Pessoa (personalidade mistico) (faixa_etaria adulto) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 45
(defrule Mistico-Adulto-Ilimitado
    (Pessoa (personalidade mistico) (faixa_etaria adulto) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ fantasia ?generos) (member$ terror ?generos) (member$ aventura ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 46
(defrule Realista-Crianca-Limitado
    (Pessoa (personalidade realista) (faixa_etaria crianca) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 47
(defrule Realista-Crianca-Padrao
    (Pessoa (personalidade realista) (faixa_etaria crianca) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 48
(defrule Realista-Crianca-Ilimitado
    (Pessoa (personalidade realista) (faixa_etaria crianca) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 49
(defrule Realista-Adolescente-Limitado
    (Pessoa (personalidade realista) (faixa_etaria adolescente) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 50
(defrule Realista-Adolescente-Padrao
    (Pessoa (personalidade realista) (faixa_etaria adolescente) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 51
(defrule Realista-Adolescente-Ilimitado
    (Pessoa (personalidade realista) (faixa_etaria adolescente) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 52
(defrule Realista-Adulto-Limitado
    (Pessoa (personalidade realista) (faixa_etaria adulto) (disponibilidade limitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 53
(defrule Realista-Adulto-Padrao
    (Pessoa (personalidade realista) (faixa_etaria adulto) (disponibilidade padrao))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra 54
(defrule Realista-Adulto-Ilimitado
    (Pessoa (personalidade realista) (faixa_etaria adulto) (disponibilidade ilimitado))
    ?filme <- (DetalhesFilme
                (nome ?nome)
                (duracao ?dur&curta|padrao|ilimitado)
                (classificacao ?class&crianca|adolescente|adulto)
                (generos $?generos)
                (sinopse ?sinopse))
    (test (or (member$ crime ?generos) (member$ guerra ?generos) (member$ biografia ?generos)))
    =>
    (print-detalhes-filme ?nome ?class ?dur ?generos ?sinopse))

; Regra para mostrar que a recomendação foi concluída
(defrule fim-recomendacao
    (declare (salience -10))
    (disponibilidade-coletada)
    =>
    (printout t crlf)
    (printout t "Fim das recomendacoes." crlf))
