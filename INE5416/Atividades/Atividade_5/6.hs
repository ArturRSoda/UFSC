busca :: [Int] -> Int -> Bool
busca [] x = False
busca (a:b) x = x == a ||  busca b x

ocorrencias :: [Int] -> Int -> Int
ocorrencias l x | not (busca l x) = 0
ocorrencias (a:b) x | x == a = 1 + ocorrencias b x
                    | x /= a = ocorrencias b x


main = do
    print(ocorrencias [1, 2, 3, 4, 1, 1, 1, 5] 1)
