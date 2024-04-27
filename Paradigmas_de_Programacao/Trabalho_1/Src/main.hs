import Data.Char (digitToInt)
import Data.Map
import Utils
import Position
import Board
import Solve

isNotSpace :: Char -> Bool
isNotSpace a = a /= ' '

charToInt :: Char -> Int
charToInt a | a == '*' = -1
            | otherwise = digitToInt a

main = do
    valuesContent <- readFile "Entradas/teste.txt"
    let boardContentWithoutSpace = Prelude.map (Prelude.filter isNotSpace) (lines valuesContent)
    let valueMatriz = Prelude.map (Prelude.map charToInt) boardContentWithoutSpace

    regionsContent <- readFile "Entradas/teste_regions.txt"
    let regionsMatriz = Prelude.map (Prelude.filter isNotSpace) (lines regionsContent)

    let board = makeBoard valueMatriz regionsMatriz 0
    let regionsDict = defineRegions board

    printBoard board
    print ("---------")
    let result = solve board 
    case (result) of
        Just board -> printBoard board
        Nothing -> putStrLn "merda"





