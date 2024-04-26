escreva :: String -> Int -> IO ()
escreva s 0 = putStrLn ""
escreva (a:b) i =
    putStr [a] >>=
        (\x -> escreva b (i-1))

escrevaDo :: String -> Int -> IO ()
escrevaDo s 0 = putStrLn ""
escrevaDo (a:b) i = do
    putStr [a]
    escrevaDo b (i-1)

main = do
    escreva "ICE ICE BABY!" 3
    escrevaDo "ICE ICE BABY!" 7
