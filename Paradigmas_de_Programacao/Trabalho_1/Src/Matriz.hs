module Matriz (getLen, makeRow, makeBoard, printBoard, validate, getRegionBoard) where
import Data.Char (digitToInt)
import Prelude hiding (lookup)
import Data.Map
import Position

type Dict k v = Map k v

type I = Int
type J = Int
type Len = Int

type Row = [Position]
type Board = [Row]
type RegionMatriz = [[Char]]
type RegionsMap = Map Char [Int]

justToList :: Maybe [a] -> [a]
justToList (Just [a]) = [a]
justToList Nothing = []

getLen :: [a] -> Int
getLen [] = 0
getLen (a:b) = 1 + (getLen b)

makeRow :: [Int] -> RegionMatriz -> I -> J -> Len -> Row
makeRow [] _ _ _ _ = []
makeRow (a:b) rm i j len = [makePosition i j a rm len] ++ makeRow b rm i (j+1) len

printRow :: Row -> IO ()
printRow [] = putStrLn ""
printRow (a:b) = putStr (show (getValue a) ++ " ") >>= (\x -> printRow b)

makeBoard :: [[Int]] -> RegionMatriz -> I -> Board
makeBoard [] _ _ = []
makeBoard (a:b) rm i = [makeRow a rm i 0 (getLen a)] ++ makeBoard b rm (i+1)

getRegionBoard :: I -> J -> Board -> Char
getRegionBoard i j b = getRegion ((b!!i)!!j)

getPosition :: I -> J -> Board -> Position
getPosition i j b = (b!!i)!!j

printBoard :: Board -> IO ()
printBoard [] = putStr ""
printBoard (a:b) = printRow a >>= (\x -> printBoard b)

validate :: I -> J -> Int -> RegionsMap -> Board -> Maybe Bool
validate i j guess dict board = let regionList = findWithDefault [] (getRegionBoard i j board) dict; pos = getPosition i j board in do
    a0 <- inRow guess regionList
    a1 <- if (guess > (getLen regionList)) then Nothing else (Just True)

    a2 <- if (i == 0) then (Just True) else
        if (getValue (getPosition (i-1) j board)) == guess then Nothing else
            if (getUpBorderBlock pos) then (Just True) else 
                if ((getValue (getPosition (i-1) j board)) <= guess) then (Just True) else Nothing

    Just True

inRow :: Eq a => a -> [a] -> Maybe Bool
inRow _ [] = Nothing
inRow v (a:b)
    | (v == a) = Just True
    |otherwise = inRow v b


