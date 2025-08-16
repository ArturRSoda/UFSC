filtrar :: (t -> Bool) -> [t] -> [t]
filtrar f l = [x | x <- l, f x]

main = do
    print (filtrar odd [1, 2, 3, 4, 5, 6])
