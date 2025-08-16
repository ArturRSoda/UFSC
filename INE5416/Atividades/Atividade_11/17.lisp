(defun primoAux (i n)
    (cond
        ((<= n 3) (not (< n 2)))
        ((< i n) (if (= (mod n i) 0) nil (primoAux (+ i 1) n)))
        (t t)
    )
)

(defun primo (a)
    (primoAux 2 a)
)

(defun main()
    (write (primo (read)))
)

(main)

