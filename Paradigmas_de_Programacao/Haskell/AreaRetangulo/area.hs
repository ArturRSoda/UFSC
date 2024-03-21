areaRetangulo :: Float -> Float -> Float
areaRetangulo h b = h * b

main = do
    alturaString <- getLine
    baseString <- getLine
    putStr "Area = "
    print (areaRetangulo (read alturaString :: Float) (read baseString :: Float))
