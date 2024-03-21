areaTriangle :: Float -> Float -> Float
areaTriangle b h = (b*h)/2

main = do
    b <- getLine
    h <- getLine
    print(areaTriangle (read b :: Float) (read h :: Float))
