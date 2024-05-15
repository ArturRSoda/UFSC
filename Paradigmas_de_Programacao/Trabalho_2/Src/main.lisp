(load "Src/utils.lisp")
(load "Src/position.lisp")
(load "Src/board.lisp")
(load "Src/solve.lisp")

(defun readBoard (path)
    (setq contentFile (open (concatenate 'string (concatenate 'string "Entradas/" path) "/numbers.txt")))
    (setq regionsFile (open (concatenate 'string (concatenate 'string "Entradas/" path) "/regions.txt")))

    (setq valuesMatriz (map 'list (lambda (arr) (map 'list #'symbolToInt arr)) (read contentFile)))
    (setq regionsMatriz (read regionsFile))

    (list valuesMatriz regionsMatriz)
)

(defun symbolToInt (a)
    (if (typep a 'symbol) -1 a)
)

(defun main()
    (setq argv ext:*args*)
    (setq path (nth 0 argv))

    (setq matrizes (readBoard path))
    (setq valuesMatriz (nth 0 matrizes))
    (setq regionsMatriz (nth 1 matrizes))

    (setq board (makeBoard valuesMatriz regionsMatriz 0)) 
    (setq regionHT (defineRegion board))

    (write-line "")

    (printBoard board)

    (write-line "")

    (if (solve board)
        (printBoard board)
        (write-line "Tabuleiro nao possui solucao")
    )
)

(main)
