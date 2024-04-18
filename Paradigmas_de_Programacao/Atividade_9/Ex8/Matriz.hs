module Matriz (Row, Matriz, Length, sumElementMatriz, sumTwoMatriz, verifyNumbers) where

type Row = [Int]
type Matriz = [Row]
type Length = Int

sumRow :: Row -> Int
sumRow [] = 0
sumRow (a:b) = a + sumRow b

sumElementMatriz :: Matriz -> Int
sumElementMatriz [] = 0
sumElementMatriz (a:b) = (sumRow a) + (sumElementMatriz b)

sumTwoMatriz :: Matriz -> Matriz -> Matriz
sumTwoMatriz a b = zipWith (zipWith (+)) a b

verifyNumbers :: Matriz -> Bool
verifyNumbers m = verifyNumbersAux (flatten m) (lenRow (head m)) 1

verifyNumbersAux :: Row -> Length -> Int -> Bool
verifyNumbersAux m l x
    | (x > l*l) = True
    | ((x <= l*l) && (hasNumber x m)) = verifyNumbersAux m l (x+1)
    | otherwise = False


lenRow :: Row -> Int
lenRow [] = 0
lenRow (a:b) = 1 + lenRow b

hasNumber :: Int -> Row -> Bool
hasNumber x [] = False
hasNumber x (a:b) 
    | (x == a) = True
    | otherwise = hasNumber x b

flatten :: Matriz -> Row
flatten a = (\z n -> foldr (\x y -> foldr z y x) n a) (:) []
