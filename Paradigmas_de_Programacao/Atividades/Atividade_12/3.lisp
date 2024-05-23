(defun len (arr)
    (if (null arr)
        0
    (+ 1 (len (cdr arr)))
    )
)

(defun menor (arr)
    (cond
        ((null arr) 0)
        ((= (len arr) 1) (car arr))
        (t 
            (if (null arr)
                0
            (let ((a (car arr)) (b (cdr arr)))
                (if (< a (menor b))
                    a
                (menor b)
                )
            )
        ))
    )
    
  )
(defun main()
    (print (menor '(1 2 3)))
)

(main)

