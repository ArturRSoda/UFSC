; Importe dos codigos fontes
(load "Src/package.lisp")
(load "Src/utils.lisp")
(load "Src/position.lisp")
(load "Src/board.lisp")
(load "Src/solve.lisp")
(load "Src/main.lisp")

(sb-ext:save-lisp-and-die "result" ; Nome do executavel
    :toplevel #'myPack::main       ; Funcao que deve ser chamada, ao rodar executavel
    :executable t                  ; Criacao de executavel
    :compression 9)                ; Diminui tamanho do executavel
