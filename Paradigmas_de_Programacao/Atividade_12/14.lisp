(defun soma (arr)
    (if (null arr)
        0
    (+ (car arr) (soma (cdr arr)))
    )
)

(defun len (arr)
    (if (null arr)
        0
    (+ 1 (len (cdr arr)))
    )
)

(defun media (arr)
    (if (null arr)
        0
    (/ (soma arr) (len arr))
    )
)

(defun alunos()
    '((1 "Bob" (5.6 8 9.3))
      (2 "Ana" (8.2 9 7 6.5))
      (3 "Tom" (3.2 7 5.7 8.3))
      (4 "Bin" (7.5 5.3 8.5 6.2 3.1))
      (5 "Bia" (6.7 4.1 5.5)))
)

(defun getNome (aluno)
    (car (cdr aluno))
)

(defun getNotas (aluno)
    (car (cdr (cdr aluno)))
)

(defun getNomes (lista)
    (if (null lista)
        ()
        (cons (getNome (car lista)) (getNomes (cdr lista)))
    )
)

(defun medias (alunosArr)
    (cond
        ((null alunosArr) nil)
        (t (cons (cons (getNome (car alunosArr)) (media (getNotas (car alunosArr)))) (medias (cdr alunosArr))))
    )
)

(defun mediasSemNome (alunosArr)
    (cond
        ((null alunosArr) nil)
        (t (cons (media (getNotas (car alunosArr))) (mediasSemNome (cdr alunosArr))))
    )
)

(defun mediaTurma (alunosArr)
    (media (mediasSemNome alunosArr))
)

(defun acimaMedia (alunosArr mt)
    (cond
        ((null alunosArr) nil)
        (t
            (let ((nome (getNome (car alunosArr))) (ma (media (getNotas (car AlunosArr)))))
                (if (> ma mt)
                    (cons (cons nome ma) (acimaMedia (cdr alunosArr) mt))
                    (acimaMedia (cdr alunosArr) mt)
                )

            )
        )
    )
)

(defun aprovados (alunosArr)
    (cond
        ((null alunosArr) nil)
        (t
            (let ((nome (getNome (car alunosArr))) (ma (media (getNotas (car AlunosArr)))))
                (if (>= ma 6)
                    (cons (cons nome ma) (aprovados (cdr alunosArr)))
                    (aprovados (cdr alunosArr))
                )

            )
        )
    )
)

(defun fazDuplas (nome alunosNomes)
    (cond 
        ((null alunosNomes) nil)
        (t
            (if (string/= nome (car alunosNomes))
                (cons (cons nome (car alunosNomes)) (fazDuplas nome (cdr alunosNomes)))
                (fazDuplas nome (cdr alunosNomes))
            )
        )
    )
)

(defun duplas (alunosArr)
    (cond
        ((null alunosArr) nil)
        (t
            (let ((nomes (getNomes alunosArr)))
                (cons (fazDuplas (car nomes) (cdr nomes)) (duplas (cdr alunosArr)))
            )
        )
    )
    
)

(defun ordenarAlunos (alunosArr)
    (cond
        ((null alunosArr) nil)
        (t
            (let ((nome (getNome (car alunosArr))) (ma (media (getNotas (car alunosArr)))))
                (add (cons nome ma) (ordenarAlunos (cdr alunosArr)))
            )
        )
    )
)

(defun add (aluno arr)
    (cond
        ((null arr) (cons aluno ()))
        (t
            (let ((ma (car (cdr aluno))) (mp (car (cdr (car arr)))))
                (if (<= ma mp)
                    (cons aluno arr)
                    (cons (car arr) (add aluno (cdr arr)))
                )
            )
        )
    )
)


(defun main ()
    (write-line (write-to-string (getNomes (alunos))))
    (print (medias (alunos)))
    (print (mediaTurma (alunos)))
    (print (acimaMedia (alunos) (mediaTurma (alunos))))
    (print (aprovados (alunos)))
    (print (duplas (alunos)))
    (print (ordenarAlunos (alunos)))
)

(main)

