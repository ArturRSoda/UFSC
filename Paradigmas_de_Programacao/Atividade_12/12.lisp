(defun apagar (arr i)
    (cond
        ((null arr) nil)
        ((> i 0) (apagar (cdr arr) (- i 1)))
        (t (cons (car arr) (apagar (cdr arr) i)))
    )
)


(defun main()
    (print (apagar '(1 2 3 4 5 6) 2))
)

(main)

