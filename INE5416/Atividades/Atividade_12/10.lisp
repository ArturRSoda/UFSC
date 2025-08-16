(defun mapear (func arr)
    (cond
        ((null arr) nil)
        (t (cons (funcall func (car arr)) (mapear func (cdr arr))))
    )
)


(defun main()
    (print (mapear (function (lambda (x) (+ x 1))) '(1 2 3 4 5 6)))
)

(main)


