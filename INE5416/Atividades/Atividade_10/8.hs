echo :: IO ()
echo =
    getChar >>=
        \x -> putStrLn [x]

echoDo :: IO ()
echoDo = do
    x <- getChar
    putStrLn [x]

main = do
    echo 
    echoDo
