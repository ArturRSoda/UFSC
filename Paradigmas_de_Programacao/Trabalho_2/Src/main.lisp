;; -*- lexical-binding: t; byte-compile-warnings: nil  -*-
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
    (setq path (string (read)))

    (setq matrizes (readBoard path))
    (setq valuesMatriz (nth 0 matrizes))
    (setq regionsMatriz (nth 1 matrizes))

    (setq board (makeBoard valuesMatriz regionsMatriz 0)) 

    (write-line "")

    (printBoard board)

    (write-line "")

    (cond
        
        ((not (solve board)) (write-line "Tabuleiro nao possui solucao"))
        (t 
            (printBoard board)
            (write-line "")
            (prettyPrint board)
        )
    )
)

