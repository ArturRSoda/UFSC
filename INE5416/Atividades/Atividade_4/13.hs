mdc :: [Int] -> Int
mdc [x, y] | (((max x y) `mod` (min x y)) == 0) = min x y
           | otherwise = mdc [(min x y), ((max x y) `mod` (min x y))]
mdc [x, y, z] = mdc [mdc [x, y], z]

mmc :: Int -> Int -> Int
mmc x y = x * (div y (mdc [x, y]))

main = do
    x <- readLn :: IO Int
    y <- readLn :: IO Int
    print (mmc x y)

