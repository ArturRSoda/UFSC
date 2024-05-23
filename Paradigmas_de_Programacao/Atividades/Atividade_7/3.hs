class (Integral x) => MeuInt x where
    bigger :: x -> x -> x
    smaller :: x -> x -> x
    par :: x -> Bool
    impar :: x -> Bool
    primo :: x -> x -> Bool
    mdc :: x -> x -> x
    isNegative :: x -> Bool
    (===) :: x -> x -> Bool
    (==/) :: x -> x -> Bool


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

    mdc a b | ((mod (max a b) (min a b)) == 0) = min a b
            | otherwise = mdc (min a b) (mod (max a b) (min a b))

    a === b | (abs(a - b) <= 1) = True
            | otherwise = False

-- Retorna se um numero eh negativo
    isNegative a = (a < 0)

-- Operacao que verifica se a eh multiplo de b
    a ==/ b = ((mod a b) == 0)

instance MeuInt Int

main = do
    print(bigger (2::Int) (1::Int))
    print(par (2::Int))
    print(par (1::Int))
    print(impar (2::Int))
    print(impar (1::Int))
    print(primo (17::Int) (2::Int))
    print(primo (20::Int) (2::Int))
    print(mdc (20:: Int) (16::Int))
    print((2::Int) === (1::Int))
    print((2::Int) === (10::Int))
    print(isNegative (-1::Int))
    print((20::Int) ==/ (5::Int))

