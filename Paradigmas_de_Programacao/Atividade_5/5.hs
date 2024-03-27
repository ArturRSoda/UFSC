busca :: [Int] -> Int -> Bool
busca [] x = False
busca (a:b) x = (x == a) ||  busca b x

main = do
    print(busca [1, 2, 3, 4, 5, 6] 9)
