(defun soma (arr)
    (if (null arr)
        0
    (+ (car arr) (soma (cdr arr)))
    )
)
(defun main()
    (write (soma '(1 2 3)))
)

(main)
