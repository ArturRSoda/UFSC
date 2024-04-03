type Nome = String
type Disciplina = String
type Nota = Float
type Aluno = (Nome, Disciplina, (Nota, Nota, Nota))

qtdAlunos :: Int 
qtdAlunos = 3

aluno :: Int -> Aluno
aluno 1 = ("Artur", "Paradigmas", (7, 8, 9))
aluno 2 = ("Enzo", "Calculo", (6, 6, 6))
aluno 3 = ("Davi", "Calculo Numerico", (1, 2, 3))

getNome :: Aluno -> Nome
getNome (nome, _, _) = nome

getMedia :: (Float, Float, Float) -> Float
getMedia (a, b, c) = (a + b + c) / 3

getNotas :: Aluno -> (Float, Float, Float)
getNotas (_, _, n) = n

mediaAlunoI :: Int -> Float
mediaAlunoI i = getMedia (getNotas (aluno i))

getMediaClasse :: Int -> Float
getMediaClasse i | (i <= 0) = 0
                 | (i < qtdAlunos) = getMediaClasse (i-1) + mediaAlunoI i
                 | otherwise = (getMediaClasse (i-1) + mediaAlunoI i) / fromIntegral qtdAlunos

imprimeInfoAlunos :: Int -> IO()
imprimeInfoAlunos i | ((i > qtdAlunos) || (i <= 0)) = putStr ""
                    | otherwise = do
    print(aluno i)
    print(getNome (aluno i))
    print(mediaAlunoI i)
    putStrLn ""
    imprimeInfoAlunos (i+1)
                     
main = do
    imprimeInfoAlunos 1
    putStr "Media classe = "
    print(getMediaClasse qtdAlunos)
