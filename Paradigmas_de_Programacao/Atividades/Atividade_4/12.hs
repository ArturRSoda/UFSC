mdc :: [Int] -> Int
mdc [x, y] | (((max x y) `mod` (min x y)) == 0) = min x y
           | otherwise = mdc [(min x y), ((max x y) `mod` (min x y))]
mdc [x, y, z] = mdc [mdc [x, y], z]

main = do
    x <- readLn :: IO Int
    y <- readLn :: IO Int
    z <- readLn :: IO Int
    print (mdc [x, y, z])




