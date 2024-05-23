module Matriz (Row, Matriz, Length, sumElementMatriz, sumTwoMatriz, verifyNumbers, sumMainDiagonal, sumSecundaryDiagonal, isMagicSquare, isPermutationMatriz, replaceRowValue, replaceMatrizRow, replaceMatrizValue, solveD) where
import Data.Bits (Bits(xor))

type Row = [Int]
type Matriz = [Row]
type Length = Int

------------------------------------------------------------------------
-- A

sumRow :: Row -> Int
sumRow [] = 0
sumRow (a:b) = a + sumRow b

sumElementMatriz :: Matriz -> Int
sumElementMatriz [] = 0
sumElementMatriz (a:b) = (sumRow a) + (sumElementMatriz b)

------------------------------------------------------------------------
-- B

sumTwoMatriz :: Matriz -> Matriz -> Matriz
sumTwoMatriz a b = zipWith (zipWith (+)) a b

------------------------------------------------------------------------
-- C

isMagicSquare :: Matriz -> Bool
isMagicSquare m = (((sumElementMatriz m) + (sumMainDiagonal m) + (sumSecundaryDiagonal m)) == (((lenRow (head m)) + 2)*(sumRow (head m)))) && (verifyNumbers m)

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

sumMainDiagonal :: Matriz -> Int
sumMainDiagonal m = sumMainDiagonalAux m (lenRow (head m)) 0

sumMainDiagonalAux :: Matriz -> Length -> Int -> Int
sumMainDiagonalAux m l x
    | ((x >= 0) && (x < l)) = (m!!x)!!x + sumMainDiagonalAux m l (x+1)
    | otherwise = 0

sumSecundaryDiagonal :: Matriz -> Int
sumSecundaryDiagonal m = sumSecundaryDiagonalAux m (lenRow (head m)) 0

sumSecundaryDiagonalAux :: Matriz -> Length -> Int -> Int
sumSecundaryDiagonalAux m l x
    | ((x >= 0) && (x < l)) = (m!!(l-1-x))!!x + sumSecundaryDiagonalAux m l (x+1)
    | otherwise = 0

------------------------------------------------------------------------
-- C

isPermutationMatriz :: Matriz -> Bool
isPermutationMatriz m = (verifyPermutationAllRow m) && (verifyPermutationAllColumn m)

verifyPermutationAllRow :: Matriz -> Bool
verifyPermutationAllRow m = verifyPermutationAllRowAux m 0

verifyPermutationAllRowAux :: Matriz -> Int -> Bool
verifyPermutationAllRowAux m i
    | (i == (lenRow (head m))) = True
    | otherwise = if (verifyPermutationRow m i) then (verifyPermutationAllRowAux m (i+1)) else False

verifyPermutationRow :: Matriz -> Int -> Bool
verifyPermutationRow m i
    | (((countValueRow m i 0) == (lenRow (head m))-1) && ((countValueRow m i 1) == 1)) = True
    | otherwise = False

verifyPermutationAllColumn :: Matriz -> Bool
verifyPermutationAllColumn m = verifyPermutationAllColumnAux m 0

verifyPermutationAllColumnAux :: Matriz -> Int -> Bool
verifyPermutationAllColumnAux m j
    | (j == (lenRow (head m))) = True
    | otherwise = if (verifyPermutationColumn m j) then (verifyPermutationAllColumnAux m (j+1)) else False

verifyPermutationColumn :: Matriz -> Int -> Bool
verifyPermutationColumn m j
    | (((countValueColumn m j 0) == (lenRow (head m))-1) && ((countValueColumn m j 1) == 1)) = True
    | otherwise = False

countValueRow :: Matriz -> Int -> Int -> Int
countValueRow m i x = countValueRowAux (m!!i) x

countValueRowAux :: Row -> Int -> Int
countValueRowAux [] x = 0
countValueRowAux (a:b) x
    | (a == x) = 1 + countValueRowAux b x
    | otherwise = countValueRowAux b x

countValueColumn :: Matriz -> Int -> Int -> Int
countValueColumn m j x = countValueColumnAux m (lenRow (head m)) x 0 j

countValueColumnAux :: Matriz -> Length -> Int -> Int -> Int -> Int
countValueColumnAux m l x i j
    | ((i >= 0) && (i < l)) = if ((m!!i)!!j == x) then (1+countValueColumnAux m l x (i+1) j) else (countValueColumnAux m l x (i+1) j)
    | otherwise = 0

------------------------------------------------------------------------
-- D

zeroMatriz :: Int -> Int -> Matriz
zeroMatriz l x
    | (x == l) = []
    | otherwise = [zeroRow l 0] ++ zeroMatriz l (x+1)

zeroRow :: Int -> Int -> Row
zeroRow l x
    | (x == l) = []
    | otherwise = [0] ++ zeroRow l (x+1)

teste :: Matriz
teste = [[6, 6, 6], [6, 6, 6], [6, 6, 6]]

solveD :: Matriz -> Matriz
--solveD m = let (a,b) = (solveDAux m 0 0 (lenRow (head m)) 1) in (if b then a else (zeroMatriz (lenRow (head m)) 0))
solveD m = let (a,b) = (solveDAux m 0 0 (lenRow (head m)) 1) in (if b then a else (zeroMatriz (lenRow (head m)) 0))

solveDAux :: Matriz -> Int -> Int -> Int -> Int -> (Matriz, Bool)
solveDAux m i j l x
    | (i == l) = (m, True)
    | (j == l) = solveDAux m (i+1) 0 l x
    | ((m!!i)!!j /= 0) = solveDAux m i (j+1) l x
    | (x > 1000) = (m, False)
    | otherwise = 
    let mat = (replaceMatrizValue m i j x) in 
        if (isMagicSquareV2 mat) then 
            let (a, b) = (mat , True) in
                if b then
                    (a,b)
                else 
                    (solveDAux m i j l (x+1))
        else
            (solveDAux m i j l (x+1))


isMagicSquareV2 :: Matriz -> Bool
isMagicSquareV2 m = ((sumElementMatriz m) + (sumMainDiagonal m) + (sumSecundaryDiagonal m)) == (((lenRow (head m)) + 2)*(sumRow (head m)))

replaceMatrizValue :: Matriz -> Int -> Int -> Int -> Matriz
replaceMatrizValue m i j v = (replaceMatrizRow m i (replaceRowValue (m!!i) j v))

replaceRowValue :: Row -> Int -> Int -> Row
replaceRowValue r j v = (getSubRow r 0 j) ++ [v] ++ (getSubRow r (j+1) (lenRow r))

getSubRow :: Row -> Int -> Int -> Row
getSubRow r i j = getSubRowAux r i j 0

getSubRowAux :: Row -> Int -> Int -> Int -> Row
getSubRowAux [] i j x = []
getSubRowAux (a:b) i j x
    | (x >= j) = []
    | (x < i) = getSubRowAux b i j (x+1)
    | otherwise = [a] ++ getSubRowAux b i j (x+1)

replaceMatrizRow :: Matriz -> Int -> Row -> Matriz
replaceMatrizRow m i r = (getSubMatriz m 0 i) ++ [r] ++ (getSubMatriz m (i+1) (lenRow (head m)))

getSubMatriz :: Matriz -> Int -> Int -> Matriz
getSubMatriz m i j = getSubMatrizAux m i j 0

getSubMatrizAux :: Matriz -> Int -> Int -> Int -> Matriz
getSubMatrizAux [] i j x = []
getSubMatrizAux (a:b) i j x
    | (x >= j) = []
    | (x < i) = getSubMatrizAux b i j (x+1)
    | otherwise = [a] ++ getSubMatrizAux b i j (x+1)
     

