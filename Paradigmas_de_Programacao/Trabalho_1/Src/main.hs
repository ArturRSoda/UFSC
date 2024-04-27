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
{-
    valuesContent <- readFile "Entradas/teste.txt"
    let boardContentWithoutSpace = Prelude.map (Prelude.filter isNotSpace) (lines valuesContent)
    let valueMatriz = Prelude.map (Prelude.map charToInt) boardContentWithoutSpace

    regionsContent <- readFile "Entradas/teste_regions.txt"
    let regionsMatriz = Prelude.map (Prelude.filter isNotSpace) (lines regionsContent)

    let board = makeBoard valueMatriz regionsMatriz 0
    let regionsDict = defineRegions board

    printBoard board
    print ("---------")
    let result = solve board regionsDict
    print (getFirtsTuple result)
    printBoard (getSecondTuple result)
    print ("---------")
-}

    let b = [[-1, 2], [2, 1]]
    let r = ["aa", "bb"]

    let bd = makeBoard b r 0
    let rd = defineRegions bd
    printBoard bd
    print rd

    let pos = getPosition 0 0 bd
    let regPos = getRegion pos
    let regList = findWithDefault [] regPos rd

    print (validate 0 0 3 [-1, 2] bd)





