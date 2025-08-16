existenceTriangle :: Float -> Float -> Float -> Bool
existenceTriangle x y z = (x < y+z) && (y < x+z) && (z < x+y)

main = do
    x <- getLine
    y <- getLine
    z <- getLine
    print (existenceTriangle (read x :: Float) (read y :: Float) (read z :: Float))
