(defun ocorrencia (arr x)
    (cond
        ((null arr) 0)
        ((= x (car arr)) (+ 1 (ocorrencia (cdr arr) x)))
        (t (ocorrencia (cdr arr) x))
    )
)


(defun main()
    (print (ocorrencia '(1 1 1 2 3 1) 1))
)

(main)


