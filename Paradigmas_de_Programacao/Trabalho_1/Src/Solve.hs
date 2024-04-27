module Solve (validate, solve) where
import Data.Map
import Board
import Position
import Utils

{-
solveAux :: I -> J -> Board -> Int -> Map Char [Int] -> Maybe Board
solveAux i j board n regionDict
    | (i == n) = Just board
    | (j == n) = solveAux (i+1) 0 board n regionDict
    | (getValue (getPosition i j board) /= (-1)) = solveAux i (j+1) board n regionDict
    | otherwise = do
        let pos = getPosition i j board
        let regPos = getRegion pos
        let regionList = findWithDefault [] regPos regionDict

        let possibleValues = getPossibleValues [1..9] i j regionList board
        let possibleBoards = getPossibleBoards possibleValues i j board
        let validBoard = Prelude.map solve possibleBoards
        case Prelude.filter (/= Nothing) validBoard of
            [] -> Nothing
            (a:b) -> a

getPossibleBoards :: [Int] -> I -> J -> Board -> [Board]
getPossibleBoards [] _ _ _ = []
getPossibleBoards (a:b) i j board = [changeValueBoard board i j a] ++ getPossibleBoards b i j board

getPossibleValues :: [Int] -> I -> J -> RegionList -> Board -> [Int]
getPossibleValues [] _ _ _ _ = []
getPossibleValues (a:b) i j rl board = 
    case (validate i j a rl board) of
        True -> [a] ++ getPossibleValues b i j rl board
        False -> getPossibleValues b i j rl board
-}

solveAux :: I -> J -> Int -> Board -> Int -> Map Char [Int] -> Maybe Board
solveAux i j guess board n regionDict
    | (i == n) = Just board
    | (j == n) = solveAux (i+1) 0 guess board n regionDict
    | (getValue (getPosition i j board) /= (-1)) = solveAux i (j+1) guess board n regionDict
    | otherwise = do
        case guess of
            10 -> Nothing
            otherwise -> do
                let pos = getPosition i j board
                let regPos = getRegion pos
                let regionList = findWithDefault [] regPos regionDict

                let newBoard = changeValueBoard board i j guess
                case (validate i j guess regionList newBoard) of
                    False -> solveAux i j (guess+1) board n regionDict
                    True ->
                        case (solve newBoard) of
                            Nothing -> solveAux i j (guess+1) board n regionDict
                            Just bd -> Just bd

solve :: Board -> Maybe Board
solve board = do
    let regionDict = defineRegions board
    solveAux 0 0 1 board (getLen board) regionDict


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
    | (j == (n-1)) = True
    | otherwise = 
        let rightPos = getPosition i (j+1) board in
            (getValue rightPos /= guess)

