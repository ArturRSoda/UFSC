(defun enesimo (arr i)
    (cond
        ((or (< i 0) (null arr)) nil)
        ((= i 0) (car arr))
        (t (enesimo (cdr arr) (- i 1)))
    )
)


(defun main()
    (print (enesimo '(1 2 3) 2))
)

(main)

