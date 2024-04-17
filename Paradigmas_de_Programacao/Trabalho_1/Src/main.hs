import Data.Char (digitToInt)
import Control.Arrow (ArrowChoice(left))
type Value = Char
type Row a = [a]            -- [Char]
type Matrix a = [Row a]     -- [[Char]]
type Region = Matrix Value

data Position = Position {
    value :: Int,
    constant :: Bool,
    upBorderBlock :: Bool,
    downBorderBlock :: Bool,
    leftBorderBlock :: Bool,
    rightBorderBlock :: Bool,
    region :: Int
} deriving Show

getValue :: Position -> Int
getValue (Position value _ _ _ _ _ _) = value
    
getConstant :: Position -> Bool
getConstant (Position _ constant _ _ _ _ _) = constant

getUpBorderBlock :: Position -> Bool
getUpBorderBlock (Position _ _ upBorderBlock _ _ _ _) = upBorderBlock

getDownBorderBlock :: Position -> Bool
getDownBorderBlock (Position _ _ _ downBorderBlock _ _ _) = downBorderBlock

getLeftBorderBlock :: Position -> Bool
getLeftBorderBlock (Position _ _ _ _ leftBorderBlock _ _) = leftBorderBlock

getRightBorderBlock :: Position -> Bool
getRightBorderBlock (Position _ _ _ _ _ rightBorderBlock _) = rightBorderBlock

getRegion :: Position -> Int
getRegion (Position _ _ _ _ _ _ region) = region

isNotSpace :: Char -> Bool
isNotSpace a = a /= ' '

charToInt :: Char -> Int
charToInt a | a == '*' = -1
            | otherwise = digitToInt a


main = do
    contents <- readFile "Entradas/teste.txt"
    let x = map (filter isNotSpace) (lines contents)
    let y = map (map charToInt) x
    let z = Position 1 True True True True True 2
    print z
    print (getValue z)
    print (getConstant z)
    print (getUpBorderBlock z)
    print (getDownBorderBlock z)
    print (getLeftBorderBlock z)
    print (getRightBorderBlock z)
    print (getRegion z)

