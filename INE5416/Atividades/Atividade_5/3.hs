menor :: [Int] -> Int
menor [] = -1
menor [a] = a
menor [a, b] = if (a < b) then a else b
menor (a:b) = if (a < menor b) then a else menor b

main = do
    print(menor [4, 2, 1, 4, 234])




