(load "Src/board.lisp")
(load "Src/utils.lisp")

(defun solve (board)
    (let ((regionHT (defineRegion board)))
        (solveAux 0 0 1 board (getLen board) regionHT) 
    )
)

(defun solveAux (i j guess board len regionHT)
    (cond
        ((= i len) T)
        ((= j len) (solveAux (+ i 1) 0 guess board len regionHT))
        ((/= (Pos-value (getPosition i j board)) -1) (solveAux i (+ j 1) guess board len regionHT))
        (t
            (if (= guess 10) nil
                (let ((pos (getPosition i j board))
                      (regionList (gethash (Pos-region (getPosition i j board)) regionHT)))
                    (cond
                        ((not (validate i j guess regionList board)) (solveAux i j (+ guess 1) board len regionHT))
                        (t 
                            (setf (Pos-value pos) guess)
                            (setq regionList (cons guess regionList))
                            (setq regionList (remove -1 regionList :count 1))
                            (setf (gethash (Pos-region pos) regionHT) regionList) 

                            (cond
                                ((solve board) T)
                                (t
                                    (setf (Pos-value pos) -1)
                                    (setq regionList (remove guess regionList :count 1))
                                    (setq regionList (cons -1 regionList))
                                    (setf (gethash (Pos-region pos) regionHT) regionList)
                                    (solveAux i j (+ guess 1) board len regionHT)
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)
#|
(defun solveAux (i j guess board len regionHT)
    (cond
        ((= i len) T)
        ((= j len) (solveAux (+ i 1) 0 guess board len regionHT))
        ((/= (Pos-value (getPosition i j board)) -1) (solveAux i (+ j 1) guess board len regionHT))
        (t
            (if (= guess 10)
                nil
                (let ((pos (getPosition i j board))
                      (regionList (gethash (Pos-region (getPosition i j board)) regionHT)))
                    (cond
                        ((not (validate i j guess regionList board)) (solveAux i j (+ guess 1) board len regionHT))
                        (t 
                            (setf (Pos-value pos) guess)
                            (setq regionList (cons guess regionList))
                            (setq regionList (remove -1 regionList :count 1))
                            (setf (gethash (Pos-region pos) regionHT) regionList) 

                            (cond
                                ((solve board regionHT) T)
                                (t
                                    (setf (Pos-value pos) -1)
                                    (setq regionList (remove guess regionList :count 1))
                                    (setq regionList (cons -1 regionList))
                                    (setf (gethash (Pos-region pos) regionHT) regionList)
                                    (solveAux i j (+ guess 1) board len regionHT)
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)
|#

(defun validate (i j guess regionList board)
    (let ((pos (getPosition i j board))
          (len (getLen board))
          (regionLen (getlen regionList)))
        (and (notInArr guess regionList)
        (and (<= guess regionLen)
        (and (verifyAbovePosition i j guess pos board)
        (and (verifyBellowPosition i j guess pos board len) 
        (and (verifyLeftPosition i j guess board)
             (verifyRightPosition i j guess board len))))))
    )
)

(defun verifyAbovePosition (i j guess pos board)
    (if (= i 0)
        T
        (let ((abovePos (getPosition (- i 1) j board)))
            (and (/= guess (Pos-value abovePos))
                (if (Pos-upBorder pos)
                    T 
                    (> (Pos-value abovePos) guess)
                )
            )
        )
    )
)


(defun verifyBellowPosition (i j guess pos board len)
    (if (= i (- len 1))
        T
        (let ((bellowPos (getPosition (+ i 1) j board)))
            (and (/= guess (Pos-value bellowPos))
                (if (Pos-downBorder pos)
                    T
                    (< (Pos-value bellowPos) guess)
                )
            )
        )
    )
)


(defun verifyLeftPosition (i j guess board)
    (if (= j 0)
        T
        (let ((leftPos (getPosition i (- j 1) board)))
            (/= (Pos-value leftPos) guess)
        )
    )
)


(defun verifyRightPosition (i j guess board len)
    (if (= j (- len 1))
        T
        (let ((rightPos (getPosition i (+ j 1) board)))
            (/= (Pos-value rightPos) guess)
        )
    )
)
