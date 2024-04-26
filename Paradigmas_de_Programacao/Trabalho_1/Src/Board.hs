module Board (I, J, Board, RegionList, getLen, makeRow, makeBoard, printBoard, getRegionBoard, defineRegions, getPosition, changeValueBoard) where

import Data.Char (digitToInt)
import Prelude hiding (lookup)
import Data.Map
import Position
import Utils

type I = Int
type J = Int
type Len = Int

type Row = [Position]
type Board = [Row]
type RegionBoard = [[Char]]
type RegionList = [Int]

makeRow :: [Int] -> RegionBoard -> I -> J -> Len -> Row
makeRow [] _ _ _ _ = []
makeRow (a:b) rm i j len = [makePosition i j a rm len] ++ makeRow b rm i (j+1) len

printRow :: Row -> IO ()
printRow [] = putStrLn ""
printRow (a:b) = putStr (show (getValue a) ++ " ") >>= (\x -> printRow b)

makeBoard :: [[Int]] -> RegionBoard -> I -> Board
makeBoard [] _ _ = []
makeBoard (a:b) rm i = [makeRow a rm i 0 (getLen a)] ++ makeBoard b rm (i+1)

changeValueBoard :: Board -> I -> J -> Int -> Board
changeValueBoard board i j v = do
    let pos = getPosition i j board
    let newPos = changePositionValue pos v
    let newRow = replaceValueList (board!!i) j newPos
    replaceValueList board i newRow

getRegionBoard :: I -> J -> Board -> Char
getRegionBoard i j b = getRegion ((b!!i)!!j)

getPosition :: I -> J -> Board -> Position
getPosition i j b = (b!!i)!!j

printBoard :: Board -> IO ()
printBoard [] = putStr ""
printBoard (a:b) = printRow a >>= (\x -> printBoard b)

defineRegionsAux :: I -> J -> Int -> Board -> Map Char [Int] -> Map Char [Int]
defineRegionsAux i j n board dict
    | (i == n) = dict
    | (j == n) = defineRegionsAux (i+1) 0 n board dict
    | otherwise = let pos = getPosition i j board in 
            defineRegionsAux i (j+1) n board (insertWith (++) (getRegion pos) [(getValue pos)] dict)
        
defineRegions :: Board -> Map Char [Int]
defineRegions board = defineRegionsAux 0 0 (getLen board) board empty





