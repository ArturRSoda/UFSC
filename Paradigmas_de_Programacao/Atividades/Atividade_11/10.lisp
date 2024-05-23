(defun myMax (a b c)
    (cond
        ((and (> a c) (> a b)) a)
        ((and (> b c) (> b a)) b)
        (t c)
    )
)

(defun main()
    (setq a (read))
    (setq b (read))
    (setq c (read))
    (write (myMax a b c))
)

(main)
