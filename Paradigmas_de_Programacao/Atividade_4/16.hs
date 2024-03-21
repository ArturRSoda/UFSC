divisivel :: Int -> Int -> Bool
divisivel x y = mod x y == 0

main = do
    x <- readLn :: IO Int
    y <- readLn :: IO Int

    print (divisivel x y)

