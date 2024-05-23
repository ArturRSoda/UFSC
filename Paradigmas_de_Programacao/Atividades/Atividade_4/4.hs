xor :: Bool -> Bool -> Bool
xor x y = (x && not y) || (not x && y)

main = do
    x <- getLine
    y <- getLine
    print (xor (read x :: Bool) (read y :: Bool))
