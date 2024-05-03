(defun myMDC (a b)
    (if (= (mod (max a b) (min a b)) 0)
        (min a b)
    (myMDC (min a b) (mod (max a b) (min a b)))
    )
)

(defun my3MDC (a b c)
    (myMDC (myMDC a b) c)
)

(defun main()
    (setq a (read))
    (setq b (read))
    (setq c (read))
    (write (my3MDC a b c))
)

(main)
