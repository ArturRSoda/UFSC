; Estrutura de posicoes do tabuleiro
(defstruct Pos
    value
    upBorder
    downBorder
    leftBorder
    rightBorder
    region
)


; Instancia posicoes, definindo seu valor, bloqueios e regiao
(defun makePosition (i j v rm len)
    (let ((reg (nth j (nth i rm))))
        (make-Pos
            :value v
            :upBorder (if (= i 0) T (string/= reg (nth j (nth (- i 1) rm))))
            :downBorder (if (= i (- len 1)) T (string/= reg (nth j (nth (+ i 1) rm))))
            :leftBorder (if (= j 0) T (string/= reg (nth (- j 1) (nth i rm))))
            :rightBorder (if (= j (- len 1)) T (string/= reg (nth (+ j 1) (nth i rm))))
            :region reg
        )
    )
)


