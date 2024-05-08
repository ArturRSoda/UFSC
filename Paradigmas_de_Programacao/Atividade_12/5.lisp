(defun busca (arr x)
    (cond
        ((null arr) nil)
        ((= x (car arr) x))
        (t (busca (cdr arr) x))
    )
)


(defun main()
    (print (busca '(1 2 3) 4))
)

(main)

