(defun getLen (arr)
    (if (null arr)
        0
        (+ 1 (getLen (cdr arr)))
    )
)

(defun notInArr (v arr)
    (cond
        ((null arr) T)
        (t
            (if (= v (car arr))
                nil
                (notInArr v (cdr arr))
            )
        )
    )
)
