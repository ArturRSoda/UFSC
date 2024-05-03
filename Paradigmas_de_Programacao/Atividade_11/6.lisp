(defun ehTriangulo (a b c)
    (and (and (> (+ a b) c) (> (+ b c) a)) (> (+ a c) b))
)

(defun main()
    (setq a (read))
    (setq b (read))
    (setq c (read))
    (write (ehTriangulo a b c))
)

(main)
