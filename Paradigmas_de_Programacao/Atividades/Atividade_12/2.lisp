(defun soma (arr)
    (if (null arr)
        0
    (+ (car arr) (soma (cdr arr)))
    )
)

(defun len (arr)
    (if (null arr)
        0
    (+ 1 (len (cdr arr)))
    )
)

(defun media (arr)
    (if (null arr)
        0
    (/ (soma arr) (len arr))
    )
)

(defun main()
    (setq arr '(1 2 3))
    (print (soma arr))
    (print (len arr))
    (print (media arr))
)

(main)

