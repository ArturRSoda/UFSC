(load "Src/position.lisp")
(load "Src/utils.lisp")

(defun makeRow (arr rm i j len)
    (if (null arr)
        nil
        (cons (makePosition i j (car arr) rm len) (makeRow (cdr arr) rm i (+ j 1) len))
    )
)

(defun printRow (row)
    (if (null row)
        (write-line "")
        (let ((val (Pos-value (car row))))
            (if (= val -1)
                (write-string ". ")
                (write-string (concatenate 'string (write-to-string val) " "))
            )
            (printRow (cdr row))
        )
    )

)

(defun makeBoard (matriz rm i)
    (if (null matriz)
        nil
        (cons (makeRow (car matriz) rm i 0 (getLen (car matriz))) (makeBoard (cdr matriz) rm (+ i 1)))
    )
)

(defun getPosition (i j board)
    (nth j (nth i board))
)


(defun defineRegion (board)
    (defparameter ht (make-hash-table))
    (defineRegionsAux 0 0 (getLen board) board ht)
)

(defun defineRegionsAux (i j len board hashTable)
    (cond 
        ((= i len) hashTable)
        ((= j len) (defineRegionsAux (+ i 1) 0 len board hashTable))
        (t
            (let ((pos (getPosition i j board)))
                (setq val (Pos-value pos))
                (setq reg (Pos-region pos))

                (setq regionList (gethash reg hashTable))
                (setf (gethash reg hashTable) (cons val regionList))

                (defineRegionsAux i (+ j 1) len board hashTable)
            )
        )
    )
)

(defun printBoard (board)
    (cond 
        ((null board) (write-string ""))
        (t 
            (printRow (car board))
            (printBoard (cdr board))
        )
        
    )
)
