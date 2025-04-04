(defun dist3R (x1 y1 z1 x2 y2 z2)
  (sqrt (+ (expt (- z2 z1) 2) (+ (expt (- y2 y1) 2) (expt (- x2 x1) 2))))
)

(defun main()
    (setq x1 (read))
    (setq y1 (read))
    (setq z1 (read))
    (setq x2 (read))
    (setq y2 (read))
    (setq z2 (read))
    (write (dist3R x1 y1 z1 x2 y2 z2))
)

(main)
