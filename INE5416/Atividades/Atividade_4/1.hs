pow :: Int -> Int -> Int
pow x y = x^y

main = do
    x <- getLine
    y <- getLine
    print(pow (read x :: Int) (read y :: Int))
