maximo :: [Int] -> Int
maximo [a, b] = if a >= b then a else b
maximo [a, b, c] = if a >= maximo [b, c] then a else maximo [b, c]

main = do
    a <- readLn :: IO Int
    b <- readLn :: IO Int 
    c <- readLn :: IO Int

    print (maximo [a, b, c])
