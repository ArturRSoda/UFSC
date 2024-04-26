module Solve (validate) where
import Board
import Position
import Utils

validate :: I -> J -> Int -> RegionList -> Board -> Maybe Bool
validate i j guess rl board = do
    let pos = getPosition i j board
    let n = getLen board
    let regionLen = getLen rl

    v0 <- inRow guess rl
    v1 <- operMaybe regionLen guess (>=)
    v2 <- verifyAbovePosition i j guess pos board
    v3 <- verifyBellowPosition i j guess pos board n
    v4 <- verifyLeftPosition i j guess board
    v5 <- verifyRightPosition i j guess board n

    Just True

inRow :: Eq a => a -> [a] -> Maybe Bool
inRow _ [] = Nothing
inRow v (a:b)
    | (v == a) = Just True
    |otherwise = inRow v b

verifyAbovePosition :: I -> J -> Int -> Position -> Board -> Maybe Bool
verifyAbovePosition i j guess pos board =
    if (i == 0) then (Just True) else
        let abovePos = getPosition (i-1) j board in
            (operMaybe (getValue abovePos) guess (/=)) >>=
                (\x -> case (getUpBorderBlock pos) of
                    True -> Just True
                    otherwise -> operMaybe (getValue abovePos) guess (>))
        
verifyBellowPosition :: I -> J -> Int -> Position -> Board -> Int -> Maybe Bool
verifyBellowPosition i j guess pos board n = 
    if (i == (n-1)) then (Just True) else
        let bellowPos = getPosition (i+1) j board in 
            (operMaybe (getValue bellowPos) guess (/=)) >>=
                (\x -> case (getDownBorderBlock pos) of
                    True -> Just True
                    otherwise -> operMaybe (getValue bellowPos) guess (<))


verifyLeftPosition :: I -> J -> Int -> Board -> Maybe Bool
verifyLeftPosition i j guess board =
    if (j == 0) then (Just True) else
        operMaybe (getValue leftPos) guess (/=) where leftPos = getPosition i (j-1) board

verifyRightPosition :: I -> J -> Int -> Board -> Int -> Maybe Bool
verifyRightPosition i j guess board n = 
    if (i == (n-1)) then (Just True) else
        operMaybe (getValue rightPos) guess (/=) where rightPos = getPosition i (j+1) board

