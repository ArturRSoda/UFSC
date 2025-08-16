(defun myMDC (a b)
    (if (= (mod (max a b) (min a b)) 0)
        (min a b)
    (myMDC (min a b) (mod (max a b) (min a b)))
    )
)

(defun coprimos (a b)
    (= (myMDC a b) 1)
)

(defun totienteEulerAux (x n acc)
    (if (>= x n)
        acc
    (totienteEulerAux (+ x 1) n (if (coprimos x n) (+ acc 1) acc))
    )
)

(defun totienteEuler (n)
    (totienteEulerAux 1 n 0)
)

(defun main()
    (write (totienteEuler (read)))
)

(main)
