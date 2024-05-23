alunos :: [(Int, String, Float)]
alunos = [(1, "Ana", 3.4), (2, "Bob", 6.7), (3, "Tom", 7.6)]

getNome :: (Int, String, Float) -> String
getNome (a,b,c) = b

getNota :: (Int, String, Float) -> Float
getNota (a,b,c) = c

onlyName :: [(Int, String, Float)] -> [String]
onlyName = map getNome 

maiorIgual6 :: (Int, String, Float) -> Bool
maiorIgual6 (a,b,c) = c >= 6

aprovados :: [(Int, String, Float)] -> [String]
aprovados l = onlyName (filter maiorIgual6 l)

aprovados2 :: [(Int, String, Float)] -> [String]
aprovados2 l = [getNome x | x <- l, getNota x >= 6]

gerarPares :: [String] -> [String] -> [(String,String)] 
gerarPares l1 l2 = [(a,b) | a <- l1, b <- l2, a /= b, a < b]

main = do
    print(aprovados alunos)
    print(aprovados2 alunos)
    print(gerarPares (onlyName alunos) (onlyName alunos))

