import System.Environment (getArgs)
import Data.Char (digitToInt)
import Data.Map
import Utils
import Position
import Board
import Solve

readBoard :: String -> IO ([[Int]], [[Char]])
readBoard path = do
    valuesContent <- readFile ("Entradas/" ++ path ++ "/numbers.txt")
    let vContWithoutSpace = Prelude.map (Prelude.filter isNotSpace) (lines valuesContent)
    let valuesMatriz = Prelude.map (Prelude.map charToInt) vContWithoutSpace

    regionsContent <- readFile ("Entradas/" ++ path ++ "/regions.txt")
    let regionsMatriz = Prelude.map (Prelude.filter isNotSpace) (lines regionsContent)

    return (valuesMatriz, regionsMatriz)

isNotSpace :: Char -> Bool
isNotSpace a = a /= ' '

charToInt :: Char -> Int
charToInt a | a == '*' = -1
            | otherwise = digitToInt a

main = do
    args <- getArgs
    let path = head args

    (valueMatriz, regionsMatriz) <- readBoard path

    let board = makeBoard valueMatriz regionsMatriz 0
    let regionsDict = defineRegions board

    printBoard board
    print ("---------")
    let result = solve board 
    case (result) of
        Nothing -> putStrLn "merda"
        Just board -> do
            printBoard board
            print ("---------")
            prettyPrint board









