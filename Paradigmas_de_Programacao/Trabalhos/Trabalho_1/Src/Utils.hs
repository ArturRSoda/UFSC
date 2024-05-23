module Utils (notInArr, getLen, getSubList, replaceValueList) where

-- Retorna tamanho de um vetor
getLen :: [a] -> Int
getLen [] = 0
getLen (a:b) = 1 + (getLen b)

-- Retar um subvetor de um vetor principal
getSubList :: [a] -> Int -> Int -> [a]
getSubList arr i j = getSubListAux arr i j 0

-- Metodo auxiliar de getSubList
getSubListAux :: [a] -> Int -> Int -> Int -> [a]
getSubListAux [] _ _ _ = []
getSubListAux (a:b) i j x
    | (x >= j) = []
    | (x < i) = getSubListAux b i j (x+1)
    | otherwise = [a] ++ getSubListAux b i j (x+1)

-- Troca um valor especifico de um vetor
replaceValueList :: [a] -> Int -> a -> [a]
replaceValueList arr i v = (getSubList arr 0 i) ++ [v] ++ (getSubList arr (i+1) (getLen arr))

-- Verifica se valor existe no vetor
notInArr :: Eq a => a -> [a] -> Bool
notInArr _ [] = True
notInArr v (a:b)
    | (v == a) = False
    |otherwise = notInArr v b
