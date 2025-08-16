(defun oper (op a b)
    (cond
        ((string= op "+") (+ a b))
        ((string= op "-") (- a b))
        ((string= op "*") (* a b))
        ((string= op "/") (/ a b))
    )
)

(defun main()
    (write (oper (write-to-string (read)) (read) (read)))
)

(main)
