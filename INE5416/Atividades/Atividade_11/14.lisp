(defun myMDC (a b)
    (if (= (mod (max a b) (min a b)) 0)
        (min a b)
    (myMDC (min a b) (mod (max a b) (min a b)))
    )
)

(defun coprimos (a b)
    (= (myMDC a b) 1)
)

(defun main()
    (write (coprimos (read) (read)))
)

(main)
