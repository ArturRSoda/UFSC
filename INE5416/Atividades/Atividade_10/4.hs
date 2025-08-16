ehExistente :: (Int, Int) -> Bool
ehExistente (a,b) = ((a >= 0) && (a <= 7) && (b >= 0) && (b <= 7))

casasPossiveis :: (Int, Int) -> [(Int, Int)] -> Int -> [(Int, Int)]
casasPossiveis (a,b) arr i
    | (i > 7) = arr
    | otherwise = case i of
        0 -> if (ehExistente (a+2, b+1)) then (casasPossiveis (a,b) (arr++[(a+2, b+1)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        1 -> if (ehExistente (a+2, b-1)) then (casasPossiveis (a,b) (arr++[(a+2, b-1)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        2 -> if (ehExistente (a+1, b+2)) then (casasPossiveis (a,b) (arr++[(a+1, b+2)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        3 -> if (ehExistente (a-1, b+2)) then (casasPossiveis (a,b) (arr++[(a-1, b+2)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        4 -> if (ehExistente (a-2, b+1)) then (casasPossiveis (a,b) (arr++[(a-2, b+1)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        5 -> if (ehExistente (a-2, b-1)) then (casasPossiveis (a,b) (arr++[(a-2, b-1)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        6 -> if (ehExistente (a+1, b-2)) then (casasPossiveis (a,b) (arr++[(a+1, b-2)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))
        7 -> if (ehExistente (a-1, b-2)) then (casasPossiveis (a,b) (arr++[(a-1, b-2)]) (i+1)) else (casasPossiveis (a,b) (arr) (i+1))

pertence :: (Int, Int) -> [(Int, Int)] -> Bool
pertence pos [] = False
pertence pos (a:b)
    | (pos == a) = True
    | otherwise = pertence pos b

ehValido :: (Int, Int) -> (Int, Int) -> Bool
ehValido pos0 posf = pertence posf (casasPossiveis pos0 [] 0)

calcPosicaoFinal :: [(Int, Int)] -> Maybe (Int, Int)
calcPosicaoFinal [a] = Just a
calcPosicaoFinal (a:b)
    | (ehValido a (head b)) = calcPosicaoFinal b
    | otherwise = Nothing

main = do
    print (calcPosicaoFinal [(1,0), (2,2), (0,3), (2,4)])
    print (calcPosicaoFinal [(1,0), (3,2), (0,3), (2,4)])

    



