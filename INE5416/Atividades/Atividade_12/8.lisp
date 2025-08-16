(defun fatia (arr n m)
    (cond
        ((or (= m 0) (null arr)) nil)
        ((> n 0) (fatia (cdr arr) (- n 1) (- m 1)))
        ((and (= n 0) (> m 0)) (cons (car arr) (fatia (cdr arr) n (- m 1))))
    )
)


(defun main()
    (print (fatia '(1 2 3 4 5 6) 2 5))
)

(main)

