fatorial :: Int -> Int
fatoria 0 = 1
fatorial n = n * fatorial (n-1)

main = do
    nString <- getLine
    print(fatorial (read nString :: Int))

