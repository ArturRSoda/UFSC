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

(defun goldbachAux (i n arr)
    (cond
        ((>= i n) arr)
        ((and (and (primo i) (primo (- n i))) (<= i (- n i))) (goldbachAux (+ i 1) n (concatenate 'list arr (cons i (- n i)))))
        (t goldbachAux (+ i 1) n arr)
    )
)

(defun goldbach (n)
    (goldbachAux 2 n ())
)

(defun main()
  (write (goldbach (read)))
)

(main)
