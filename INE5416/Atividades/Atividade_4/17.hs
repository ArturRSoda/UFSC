primoAux :: Int -> Int -> Bool
primoAux i n | (n <= 3) = not (n < 2)
             | (i < n) = if (mod n i == 0) then False else primoAux (i+1) n 
             | otherwise = True

primo :: Int -> Bool
primo n = primoAux 2 n

main = do
    n <- readLn :: IO Int
    print (primo n)

