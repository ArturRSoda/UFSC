(defun apagarEnquanto (func arr)
    (cond
        ((null arr) nil)
        (t
          (if (funcall func (car arr))
            (apagarEnquanto func (cdr arr))
            arr
          )
        )
    )
)


(defun main()
    (print (apagarEnquanto (function (lambda (x) (= 0 (mod x 2)))) '(2 2 3 4 5 6)))
)

(main)


