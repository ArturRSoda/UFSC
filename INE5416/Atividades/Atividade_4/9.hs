dist :: [Float] -> [Float] -> Float
dist [x1, y1, z1] [x2, y2, z2] = ((x1 - x2)**2 + (y1 - y2)**2 + (z1 - z2)**2)**(1/2)

main = do
    x1 <- readLn :: IO Float
    y1 <- readLn :: IO Float 
    z1 <- readLn :: IO Float 
    x2 <- readLn :: IO Float 
    y2 <- readLn :: IO Float 
    z2 <- readLn :: IO Float 

    print (dist [x1, y1, z1] [x2, y2, z2])


