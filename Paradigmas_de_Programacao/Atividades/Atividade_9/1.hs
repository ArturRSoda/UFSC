xor :: Bool -> Bool -> Bool
xor a b = (\x y -> (x && (not y)) || ((not x) && y)) a b

main = do

    let a = True
    let b = True

    print (xor a b)
