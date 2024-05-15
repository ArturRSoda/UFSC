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
    (defineRegionsAux 0 0 (getLen board) board (make-hash-table))
)

(defun defineRegionsAux (i j len board hashTable)
    (cond 
        ((= i len) hashTable)
        ((= j len) (defineRegionsAux (+ i 1) 0 len board hashTable))
        (t
            (let ((pos (getPosition i j board))
                  (val (Pos-value (getPosition i j board)))
                  (reg (Pos-region (getPosition i j board)))
                  (regionList (gethash (Pos-region (getPosition i j board)) hashTable)))

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

(defun prettyPrint (board)
    (prettyPrintCabecario 0 (getLen board))
    (prettyPrintAux 0 0 board (getLen board) "|" "|")
)


(defun prettyPrintAux (i j board len l1 l2)
    (cond
        ((= i len) (write-string ""))
        ((= j len) (write-line l1) (write-line l2) (prettyPrintAux (+ i 1) 0 board len "|" "|"))
        (t
            (setq pos (getPosition i j board))

            (setq l11 (concatenate 'string l1 (write-to-string (Pos-value pos))))
            (setq l111 (concatenate 'string l11 (if (Pos-rightBorder pos) "|" " ")))

            (setq l22 (concatenate 'string l2 (if (Pos-downBorder pos) "-" " ")))
            (setq l222 (concatenate 'string l22 (if (or (= j (- len 1)) (or (not (Pos-downBorder pos)) (not (Pos-downBorder (getPosition i (+ j 1) board))))) "|" "-")))
            (prettyPrintAux i (+ j 1) board len l111 l222)
        )
    )
)

(defun prettyPrintCabecario (j len)
    (cond 
        ((= j (* len 2)) (write-line "|"))
        ((= j 0) (write-string "|") (prettyPrintCabecario (+ j 1) len))
        (t (write-string "-") (prettyPrintCabecario (+ j 1) len))
    )
)
