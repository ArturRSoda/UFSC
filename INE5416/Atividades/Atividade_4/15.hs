mdc :: [Int] -> Int
mdc [x, y] | (((max x y) `mod` (min x y)) == 0) = min x y
           | otherwise = mdc [(min x y), ((max x y) `mod` (min x y))]
mdc [x, y, z] = mdc [mdc [x, y], z]

coprimos :: Int -> Int -> Bool
coprimos x y = mdc [x, y] == 1

totienteEulerAux :: Int -> Int -> Int -> Int
totienteEulerAux x n count | (x >= n) = count
                           | otherwise = (totienteEulerAux (x+1) n b) where b = if (coprimos x n) then (count+1) else count

totienteEuler :: Int -> Int
totienteEuler n = totienteEulerAux 1 n count where count = 0

main = do
    n <- readLn :: IO Int
    print (totienteEuler n)





