(defun myMDC (a b)
    (if (= (mod (max a b) (min a b)) 0)
        (min a b)
    (myMDC (min a b) (mod (max a b) (min a b)))
    )
)

(defun main()
    (setq a (read))
    (setq b (read))
    (write (myMDC a b))
)

(main)
