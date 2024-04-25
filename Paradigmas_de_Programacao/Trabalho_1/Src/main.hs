import Data.Char (digitToInt)
import Data.Map
import Position
import Matriz

isNotSpace :: Char -> Bool
isNotSpace a = a /= ' '

charToInt :: Char -> Int
charToInt a | a == '*' = -1
            | otherwise = digitToInt a

main = do
    contents <- readFile "Entradas/teste.txt"
    let x = Prelude.map (Prelude.filter isNotSpace) (lines contents)
    let matriz = Prelude.map (Prelude.map charToInt) x
    contents2 <- readFile "Entradas/teste_regions.txt"
    let y = Prelude.map (Prelude.filter isNotSpace) (lines contents2)
    let rm = ["aaa", "abb", "ccc"]
    let b = makeBoard [[1, 2, 3], [4, 1, 2], [1, 2, 3]] rm 0

    let dict = (fromList [('a', [1, 2, 3, 4, (-1)]), ('b', [(-1), 1, 2]), ('c', [1, 2, 3])])
    case (validate 1 0 (-1) dict b) of
        Nothing -> print "falho"
        Just False -> print "falho falso"
        Just True -> printBoard b

