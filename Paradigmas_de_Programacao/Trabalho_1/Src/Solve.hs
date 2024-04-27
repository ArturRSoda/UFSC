module Solve (validate) where
import Data.Map
import Board
import Position
import Utils

validate :: I -> J -> Int -> RegionList -> Board -> Bool
validate i j guess rl board =
    notInRow guess rl &&
    (guess <= regionLen) &&
    verifyAbovePosition i j guess pos board &&
    verifyBellowPosition i j guess pos board n &&
    verifyLeftPosition i j guess board &&
    verifyRightPosition i j guess board n where 
          pos = getPosition i j board
          n = getLen board
          regionLen = getLen rl

notInRow :: Eq a => a -> [a] -> Bool
notInRow _ [] = True
notInRow v (a:b)
    | (v == a) = False
    |otherwise = notInRow v b

verifyAbovePosition :: I -> J -> Int -> Position -> Board -> Bool
verifyAbovePosition i j guess pos board
    | (i == 0) = True
    | otherwise = 
        let abovePos = getPosition (i-1) j board in
            (getValue abovePos /= guess) &&
            (case (getUpBorderBlock pos) of
                True -> True
                False -> (getValue abovePos > guess))
        
verifyBellowPosition :: I -> J -> Int -> Position -> Board -> Int -> Bool
verifyBellowPosition i j guess pos board n
    | (i == (n-1)) = True
    | otherwise =
        let bellowPos = getPosition (i+1) j board in 
            (getValue bellowPos /= guess) &&
            (case (getDownBorderBlock pos) of
                True -> True
                False -> (getValue bellowPos < guess))


verifyLeftPosition :: I -> J -> Int -> Board -> Bool
verifyLeftPosition i j guess board
    | (j == 0) = True
    | otherwise = 
        let leftPos = getPosition i (j-1) board in 
            (getValue leftPos /= guess)

verifyRightPosition :: I -> J -> Int -> Board -> Int -> Bool
verifyRightPosition i j guess board n
    | (i == (n-1)) = True
    | otherwise = 
        let rightPos = getPosition i (j+1) board in
            (getValue rightPos /= guess)

