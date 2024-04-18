fix :: (a -> a) -> a
fix f = let {x = f x} in x

fib :: Int -> Int
fib = fix (\f n -> if n < 2 then n else f (n-1) + f (n-2))

main = do
    n <- readLn :: IO Int
    print (fib n)
