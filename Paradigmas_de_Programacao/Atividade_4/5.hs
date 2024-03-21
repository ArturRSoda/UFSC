checkGrade :: Float -> Float -> Float -> String
checkGrade a b c = if (a+b+c)/3 >= 6 then "APROVADO" else "REPROVADO"

main = do
    a <- getLine
    b <- getLine
    c <- getLine
    putStrLn (checkGrade (read a :: Float) (read b :: Float) (read c :: Float))
