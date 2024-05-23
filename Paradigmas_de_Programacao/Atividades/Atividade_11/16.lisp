(defun ehDivisivel (a b)
    (= (mod a b) 0) 
)

(defun main()
    (write (ehDivisivel (read) (read)))
)

(main)
