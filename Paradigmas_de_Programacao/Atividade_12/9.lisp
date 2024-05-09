(defun inverte (arr)
    (cond
        ((null arr) nil)
        (t (concatenate 'list (inverte (cdr arr)) (cons (car arr) '())))
    )
)


(defun main()
    (print (inverte '(1 2 3 4 5 6)))
)

(main)

