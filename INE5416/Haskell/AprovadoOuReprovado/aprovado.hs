avaliacao :: Float -> String
avaliacao x =
    if x < 6.0 then
        "Reprovado"
    else
        "Aprovado"

main = do
    putStrLn "Informe sua nota: "
    notaString <- getLine
    let nota = (read notaString :: Float)
    let resultado = avaliacao nota
    putStrLn ("Com " ++ notaString ++ " voce esta " ++ resultado)


