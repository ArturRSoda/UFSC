(in-package :myPack)

; Le arquivos e retona matrizes de valores e regioes
(defun readBoard (path)
    (setq contentFile (open (concatenate 'string (concatenate 'string "Entradas/" path) "/numbers.txt")))
    (setq regionsFile (open (concatenate 'string (concatenate 'string "Entradas/" path) "/regions.txt")))

    (setq valuesMatriz (map 'list (lambda (arr) (map 'list #'symbolToInt arr)) (read contentFile)))
    (setq regionsMatriz (read regionsFile))

    (list valuesMatriz regionsMatriz)
)


; Transforma '*' em -1
(defun symbolToInt (a)
    (if (typep a 'symbol) -1 a)
)

(defun main()
    ; Le do usuario qual tabuleiro resolver
    (setq path (string (read)))

    ; Monta matrizes de valores e regioes
    (setq matrizes (readBoard path))
    (setq valuesMatriz (nth 0 matrizes))
    (setq regionsMatriz (nth 1 matrizes))

    ; Monta Tabuleiro de posicoes
    (setq board (makeBoard valuesMatriz regionsMatriz 0)) 

    (write-line "")

    ; Imprime tabuleiro antes de ser resolvido
    (printBoard board)

    (write-line "")

    ; Caso for possivel resolver o tabuleiro, ele eh imprimido
    ; Caso contrario informa que tabuleiro nao possui solucao
    (cond
        ((not (solve board)) (write-line "Tabuleiro nao possui solucao"))
        (t 
            (printBoard board)
            (write-line "")
            (prettyPrint board)
        )
    )
)

