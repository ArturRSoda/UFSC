(defun bask (a b c)
    (cons (/ (- (* b -1) (sqrt (- (* b b) (* c (* 4 a))))) (* 2 a)) (/ (+ (* b -1) (sqrt (- (* b b) (* c (* 4 a))))) (* 2 a)))
)

(defun main()
    (setq a (read))
    (setq b (read))
    (setq c (read))

    (write (bask a b c))
)

(main)
