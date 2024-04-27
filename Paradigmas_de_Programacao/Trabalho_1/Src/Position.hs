module Position (Position (Position), getValue, getUpBorderBlock, getDownBorderBlock, getLeftBorderBlock, getRightBorderBlock, getRegion, makePosition, changePositionValue) where 

data Position = Position {
    value :: Int,
    upBorderBlock :: Bool,
    downBorderBlock :: Bool,
    leftBorderBlock :: Bool,
    rightBorderBlock :: Bool,
    region :: Char
} deriving (Show, Eq)

makePosition :: Int -> Int -> Int -> [[Char]] -> Int -> Position
makePosition i j v rm l = let r = (rm!!i)!!j in
    Position {
        value = v,
        upBorderBlock = if (i == 0) then True else ((rm!!(i-1)!!j) /= r),
        downBorderBlock = if (i == (l-1)) then True else ((rm!!(i+1)!!j) /= r),
        leftBorderBlock = if (j == 0) then True else ((rm!!i)!!(j-1) /= r),
        rightBorderBlock = if (j == (l-1)) then True else ((rm!!i)!!(j+1) /= r),
        region = r
    }

changePositionValue :: Position -> Int -> Position
changePositionValue pos v =
    Position {
        value = v,
        upBorderBlock = getUpBorderBlock pos,
        downBorderBlock = getDownBorderBlock pos,
        leftBorderBlock = getLeftBorderBlock pos,
        rightBorderBlock = getRightBorderBlock pos,
        region = getRegion pos
    }

getValue :: Position -> Int
getValue (Position value _ _ _ _ _) = value

getUpBorderBlock :: Position -> Bool
getUpBorderBlock (Position _ upBorderBlock _ _ _ _) = upBorderBlock

getDownBorderBlock :: Position -> Bool
getDownBorderBlock (Position _ _ downBorderBlock _ _ _) = downBorderBlock

getLeftBorderBlock :: Position -> Bool
getLeftBorderBlock (Position _ _ _ leftBorderBlock _ _) = leftBorderBlock

getRightBorderBlock :: Position -> Bool
getRightBorderBlock (Position _ _ _ _ rightBorderBlock _) = rightBorderBlock

getRegion :: Position -> Char
getRegion (Position _ _ _ _ _ region) = region

