apagar :: Int -> [t] -> [t]
apagar 0 l = l
apagar n [] = []
apagar n (a:b) = apagar (n-1) b

main = do
    print(apagar 3 [1, 2, 3, 4, 5])
