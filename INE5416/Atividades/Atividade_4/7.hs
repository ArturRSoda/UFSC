fibo :: Int -> Int
fibo x = if x <= 1 then x else fibo (x-1) + fibo (x-2)

main = do
    n <- getLine
    print (fibo (read n :: Int))
