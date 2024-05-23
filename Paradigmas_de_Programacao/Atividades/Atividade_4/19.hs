primoAux :: Int -> Int -> Bool
primoAux i n | (n <= 3) = not (n < 2)
             | (i < n) = if (mod n i == 0) then False else primoAux (i+1) n 
             | otherwise = True

primo :: Int -> Bool
primo n = primoAux 2 n

goldbachAux :: Int -> Int -> [(Int, Int)] -> [(Int, Int)]
goldbachAux i n arr | (i >= n) = arr
                    | ((primo i) && (primo (n-i)) && (i <= (n-i))) = goldbachAux (i+1) n (arr ++ [(i, (n-i))])
                    | otherwise = goldbachAux (i+1) n arr

goldbach :: Int -> [(Int, Int)]
goldbach n = goldbachAux 2 n []

main = do
    n <- readLn :: IO Int
    print (goldbach n)


