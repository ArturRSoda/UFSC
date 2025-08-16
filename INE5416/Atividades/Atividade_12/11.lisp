(defun primeiros (arr i)
    (cond
        ((or (<= i 0) (null arr)) nil)
        (t (cons (car arr) (primeiros (cdr arr) (- i 1))))
    )
)


(defun main()
    (print (primeiros '(1 2 3 4 5 6) 5))
)

(main)

