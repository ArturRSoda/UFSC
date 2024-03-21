mdc :: Int -> Int -> Int
mdc x y | (((max x y) `mod` (min x y)) == 0) = min x y
        | otherwise = mdc (min x y) ((max x y) `mod` (min x y))

main = do
    x <- readLn :: IO Int
    y <- readLn :: IO Int

    print (mdc x y)

