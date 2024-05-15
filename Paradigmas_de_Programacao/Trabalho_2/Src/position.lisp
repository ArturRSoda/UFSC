(defstruct Pos
    value
    upBorder
    downBorder
    region
)


(defun makePosition (i j v rm len)
    (let ((reg (nth j (nth i rm))))
        (make-Pos
            :value v
            :upBorder (if (= i 0) T (string/= reg (nth j (nth (- i 1) rm))))
            :downBorder (if (= i (- len 1)) T (string/= reg (nth j (nth (+ i 1) rm))))
            :region reg
        )
    )
)
