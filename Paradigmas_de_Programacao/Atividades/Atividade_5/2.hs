soma :: [Int] -> Int
soma [] = 0
soma [a, b] = a+b
soma (a:b) = a + soma b

comprimento :: [Int] -> Int
comprimento [] = 0
comprimento (_:b) = 1 + comprimento b

media :: [Int] -> Float
media [] = 0
media a = fromIntegral(soma a) / fromIntegral(comprimento a)


main = do
    print(comprimento [1, 2, 3])
    print(soma [1, 2, 3])
    print(media [1, 2, 3])

