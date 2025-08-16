maior :: Int -> Int -> Int -> Int
maior = (\a b c -> if a > b then (if a > c then a else c) else (if b > c then b else c))

main = do
    a <- readLn :: IO Int
    b <- readLn :: IO Int
    c <- readLn :: IO Int
    print (maior a b c)
