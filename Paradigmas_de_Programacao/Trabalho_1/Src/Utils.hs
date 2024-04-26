module Utils (justToList, getLen, operMaybe, getSubList, replaceValueList) where

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
