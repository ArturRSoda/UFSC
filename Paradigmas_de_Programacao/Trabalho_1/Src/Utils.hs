module Utils (justToList, getLen, operMaybe, getSubList, replaceValueList, pushBack, remove, getSecondTuple, getFirtsTuple) where

justToList :: Maybe [a] -> [a]
justToList (Just [a]) = [a]
justToList Nothing = []

getLen :: [a] -> Int
getLen [] = 0
getLen (a:b) = 1 + (getLen b)

operMaybe :: Eq a => a -> a -> (a -> a -> Bool) -> Maybe Bool
operMaybe a b f
    | (f a b) = Just True
    | otherwise = Nothing

getSubList :: [a] -> Int -> Int -> [a]
getSubList arr i j = getSubListAux arr i j 0

getSubListAux :: [a] -> Int -> Int -> Int -> [a]
getSubListAux [] _ _ _ = []
getSubListAux (a:b) i j x
    | (x >= j) = []
    | (x < i) = getSubListAux b i j (x+1)
    | otherwise = [a] ++ getSubListAux b i j (x+1)

replaceValueList :: [a] -> Int -> a -> [a]
replaceValueList arr i v = (getSubList arr 0 i) ++ [v] ++ (getSubList arr (i+1) (getLen arr))

pushBack :: [a] -> a -> [a]
pushBack arr v = arr ++ [v]

removeAux :: Eq a => a -> [a] -> Int -> Int -> [a]
removeAux v arr n i
    | (i == n) = arr
    | ((arr!!i) == v) = (getSubList arr 0 i) ++ (getSubList arr (i+1) (getLen arr))
    | otherwise = removeAux v arr n (i+1)

remove :: Eq a => [a] -> a -> [a]
remove arr v = removeAux v arr (getLen arr) 0

getSecondTuple :: (a,b) -> b
getSecondTuple (a,b) = b

getFirtsTuple :: (a, b) -> a
getFirtsTuple (a, b) = a
