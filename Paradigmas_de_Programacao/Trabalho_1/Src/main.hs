import System.Environment (getArgs)
import Data.Char (digitToInt)
import Data.Map
import Utils
import Position
import Board
import Solve

-- Le matrizes e retorna tabuleiro com valores e tabuleiro de regioes
readBoard :: String -> IO ([[Int]], [[Char]])
readBoard path = do
    valuesContent <- readFile ("Entradas/" ++ path ++ "/numbers.txt")
    let vContWithoutSpace = Prelude.map (Prelude.filter isNotSpace) (lines valuesContent)
    let valuesMatriz = Prelude.map (Prelude.map charToInt) vContWithoutSpace

    regionsContent <- readFile ("Entradas/" ++ path ++ "/regions.txt")
    let regionsMatriz = Prelude.map (Prelude.filter isNotSpace) (lines regionsContent)

    return (valuesMatriz, regionsMatriz)

-- Indica se caracter nao eh espaco
isNotSpace :: Char -> Bool
isNotSpace a = a /= ' '

-- Transforma caracter em inteiro
charToInt :: Char -> Int
charToInt a | a == '*' = -1
            | otherwise = digitToInt a

main = do
    -- Define matrizes por argumento
    args <- getArgs
    let path = head args
    (valueMatriz, regionsMatriz) <- readBoard path

    -- Monta tabuleiro e dicionario das regioes
    let board = makeBoard valueMatriz regionsMatriz 0
    let regionsDict = defineRegions board

    printBoard board
    putStrLn ""

    let result = solve board 
    case (result) of
        Nothing -> putStrLn "Tabuleiro nao tem solucao"
        Just board -> do
            printBoard board
            putStrLn ""
            prettyPrint board









