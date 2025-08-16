opera :: String -> Int -> Int -> Int
opera "+" x y = x+y
opera "-" x y = x-y
opera "*" x y = x*y
opera "/" x y = div x y

main = do
    op <- getLine
    x <- readLn :: IO Int
    y <- readLn :: IO Int

    print (opera op x y)


