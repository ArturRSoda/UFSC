(defun len (arr)
    (if (null arr)
        0
    (+ 1 (len (cdr arr)))
    )
)

(defun maior (arr)
    (cond
        ((null arr) 0)
        ((= (len arr) 1) (car arr))
        (t 
            (if (null arr)
                0
            (let ((a (car arr)) (b (cdr arr)))
                (if (> a (maior b))
                    a
                (maior b)
                )
            )
        ))
    )
)

(defun menor (arr)
    (cond
        ((null arr) 0)
        ((= (len arr) 1) (car arr))
        (t 
            (if (null arr)
                0
            (let ((a (car arr)) (b (cdr arr)))
                (if (< a (menor b))
                    a
                (menor b)
                )
            )
        ))
    )
)

(defun diferencaMaiorMenor (arr)
    (- (maior arr) (menor arr))
)

(defun main()
    (setq arr '(1 23234 3))
    (print (diferencaMaiorMenor arr))
)

(main)

