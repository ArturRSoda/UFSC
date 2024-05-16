; Retorna tamanho do vertor
(defun getLen (arr)
    (if (null arr)
        0
        (+ 1 (getLen (cdr arr)))
    )
)

; Indica que valor nao pertence ao vetor
(defun notInArr (v arr)
    (cond
        ((null arr) T)
        (t
            (if (= v (car arr))
                nil
                (notInArr v (cdr arr))
            )
        )
    )
)
