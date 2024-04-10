class (Integral x) => MeuInt x where
    bigger :: x -> x -> x
    smaller :: x -> x -> x
    par :: x -> Bool
    impar :: x -> Bool
    primo :: x -> x -> Bool


    bigger a b | (a > b) = a
               | otherwise = b

    smaller a b | (a > b) = b
                | otherwise = a

    par a | ((mod a 2) == 0) = True
          | otherwise = False

    impar a | ((mod a 2) /= 0) = True
          | otherwise = False

    primo a i | ((a == 0) || (a == 1)) = False
              | (a == i) = True
              | ((mod a i) == 0) = False
              | otherwise = primo a (i+1)

instance MeuInt Int

main = do
    print(bigger (2::Int) (1::Int))
    print(par (2::Int))
    print(par (1::Int))
    print(impar (2::Int))
    print(impar (1::Int))
    print(primo (17::Int) (2::Int))
    print(primo (20::Int) (2::Int))
