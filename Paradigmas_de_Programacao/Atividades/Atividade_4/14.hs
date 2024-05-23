mdc :: [Int] -> Int
mdc [x, y] | (((max x y) `mod` (min x y)) == 0) = min x y
           | otherwise = mdc [(min x y), ((max x y) `mod` (min x y))]
mdc [x, y, z] = mdc [mdc [x, y], z]

coprimos :: Int -> Int -> Bool
coprimos x y = mdc [x, y] == 1

main = do
    x <- readLn :: IO Int
    y <- readLn :: IO Int

    print (coprimos x y)
