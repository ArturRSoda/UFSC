maior :: [Int] -> Int
maior [] = -1
maior [a] = a
maior [a, b] = if (a > b) then a else b
maior (a:b) = if (a > maior b) then a else maior b

menor :: [Int] -> Int
menor [] = -1
menor [a] = a
menor [a, b] = if (a < b) then a else b
menor (a:b) = if (a < menor b) then a else menor b

diferencaMaiorMenor :: [Int] -> Int
diferencaMaiorMenor [] = 0
diferencaMaiorMenor [a] = a
diferencaMaiorMenor l = maior l - menor l

main = do
    print(diferencaMaiorMenor [9, 8, 7, 1, 1, 5, 10, 4, 3, 2])


