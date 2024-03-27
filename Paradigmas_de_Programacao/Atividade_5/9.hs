mapear :: (t -> y) -> [t] -> [y]
mapear f l = [f x | x <- l]

main = do
    print (mapear abs [1, -2, 3, -4, -5])
