(in-package :myPack)

; Resolve tabuleiro
(defun solve (board)
    (let ((regionHT (defineRegion board)))
        (solveAux 0 0 1 board (getLen board) regionHT) 
    )
)


; Logica para resolucao do tabuleiro
(defun solveAux (i j guess board len regionHT)
    (cond
        ; Caso passe da ultima linha -> problema resolvido -> retorna verdadeiro
        ((= i len) T)
        ; Caso passe da ultima coluna -> passa para a proxima linha
        ((= j len) (solveAux (+ i 1) 0 guess board len regionHT))
        ; Caso posicao ja possui um valor -> passe para o proximo da coluna
        ((/= (Pos-value (getPosition i j board)) -1) (solveAux i (+ j 1) guess board len regionHT))
        ; Senao tenta atribuir um valor a posicao:
        (t
            ; Verifica chute
            ; Se chute chegar a 10, cancela e temos que voltar uma passo
            (if (= guess 10) nil
                ; Se ainda nao chegou ao ultimo chute
                (let ((pos (getPosition i j board))
                      (regionList (gethash (Pos-region (getPosition i j board)) regionHT)))
                    
                    ; Verifica se o chute eh valido nessa posicao
                    (cond
                        ; Se nao for valido passamos para o prossimo candidato
                        ((not (validate i j guess regionList board)) (solveAux i j (+ guess 1) board len regionHT))
                        (t 
                            ; Se for valido, atribuimos o candidato a posicao, e atulizamos o hash table das posicoes
                            (setf (Pos-value pos) guess)
                            (setq regionList (cons guess regionList))
                            (setq regionList (remove -1 regionList :count 1))
                            (setf (gethash (Pos-region pos) regionHT) regionList) 

                            ; Entao tentamos resolver a partir do novo tabuleiro
                            (cond
                                ; Se for resolvivel retornamos verdadeiro
                                ((solve board) T)
                                (t
                                    ; Se nao for, retiramos candidato atribuido, e tentamos atribuir proximo chute
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


; Verifica se chute eh valido para a posicao
(defun validate (i j guess regionList board)
    (let ((pos (getPosition i j board))
          (len (getLen board))
          (regionLen (getlen regionList)))
        ; Se valor ja esta na regiao
        (and (notInArr guess regionList)
        ; Se o valor eh maior do que a regiao permite
        (and (<= guess regionLen)
        ; Verifica se adequa a posicao de cima
        (and (verifyAbovePosition i j guess pos board)
        ; Verifica se adequa a posicao de baixo
        (and (verifyBellowPosition i j guess pos board len) 
        ; Verifica se adequa a posicao da esquerda
        (and (verifyLeftPosition i j guess board)
        ; Verifica se adequa a posicao da direita
             (verifyRightPosition i j guess board len))))))
    )
)


; Verifica se posicao atribuida se adequa a posicao de cima
(defun verifyAbovePosition (i j guess pos board)
    ; Caso ele esteja na primeira linha retorna verdadeiro
    (if (= i 0) T
        ; Se nao, caso valor de cima for difereente e
        ;         caso valor de cima estaja na mesma regiao se possui um valor maior
        (let ((abovePos (getPosition (- i 1) j board)))
            (and (/= guess (Pos-value abovePos))
                (if (Pos-upBorder pos) T 
                    (> (Pos-value abovePos) guess)
                )
            )
        )
    )
)


; Verifica se posicao atribuida se adequa a posicao de baixo
(defun verifyBellowPosition (i j guess pos board len)
    ; Caso ele esteja na ultima linha retorna verdadeiro
    (if (= i (- len 1)) T
        ; Se nao, caso valor de baixo for diferente, e
        ;         caso valor de baixo esteja na mesma regiao, se possui um valor menor
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


; Verifica se valor da esquerda eh diferente
(defun verifyLeftPosition (i j guess board)
    (if (= j 0)
        T
        (let ((leftPos (getPosition i (- j 1) board)))
            (/= (Pos-value leftPos) guess)
        )
    )
)


; Verifica se valor da direita eh diferente
(defun verifyRightPosition (i j guess board len)
    (if (= j (- len 1))
        T
        (let ((rightPos (getPosition i (+ j 1) board)))
            (/= (Pos-value rightPos) guess)
        )
    )
)
