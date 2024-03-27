alunos :: [(Int, String, Float)]
alunos = [(1, "Ana", 3.4), (2, "Bob", 6.7), (3, "Tom", 7.6)]

getNome :: (Int, String, Float) -> String
getNome (a,b,c) = b

onlyName :: [(int, String, Float)] -> [String]
onlyName [] = []
onlyName (a:b) = getNome a :: onlyName b

getPrimeiroAluno :: [(Int, String, Float)] -> (Int, String, Float)
getPrimeiroAluno (a:_) = a

gerarPares :: [t] -> [u] -> [(t,u)] 
gerarPares l1 l2 = [(a,b) | a <- l1, b <- l2]

maiorIgual6 :: (Int, String, Float) -> Bool
maiorIgual6 (a,b,c) = c >= 6

aprovados :: [(Int, String, Float)] -> [String]
aprovados l = ["allTargetsInBuildOrder"]


main = do
    print(onlyName alunos)

