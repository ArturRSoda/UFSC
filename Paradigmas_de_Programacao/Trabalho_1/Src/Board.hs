module Board (I, J, Board, RegionList, makeBoard, printBoard, getRegionBoard, defineRegions, getPosition, changeValueBoard, prettyPrint) where

------------ Imports ----------
import Data.Char (intToDigit)
import Prelude hiding (lookup)
import Data.Map
import Position
import Utils
-------------------------------

----------- Tipos -------------
type I = Int
type J = Int
type Len = Int

type Row = [Position]
type Board = [Row]
type RegionBoard = [[Char]]
type RegionList = [Int]
-------------------------------

----------------------------------- Metodos de Linha ---------------------------------
-- Monta linha de posicoes
-- Instanciando as posicoes
makeRow :: [Int] -> RegionBoard -> I -> J -> Len -> Row
makeRow [] _ _ _ _ = []
makeRow (a:b) rm i j len = [makePosition i j a rm len] ++ makeRow b rm i (j+1) len

-- impreme linha (Simples)
printRow :: Row -> IO ()
printRow [] = putStrLn ""
printRow (a:b) 
    | (getValue a == (-1)) = putStr ". " >>= (\x -> printRow b)
    | otherwise = putStr (show (getValue a) ++ " ") >>= (\x -> printRow b)
--------------------------------------------------------------------------------------

-------------------------------- Metodos do tabuleiro ------------------------------

-- Monta tabuleiro (matriz de posicoes)
makeBoard :: [[Int]] -> RegionBoard -> I -> Board
makeBoard [] _ _ = []
makeBoard (a:b) rm i = [makeRow a rm i 0 (getLen a)] ++ makeBoard b rm (i+1)

-- Muda o valor de uma posicao especifica do tabuleiro
changeValueBoard :: Board -> I -> J -> Int -> Board
changeValueBoard board i j v = do
    let pos = getPosition i j board
    let newPos = changePositionValue pos v
    let newRow = replaceValueList (board!!i) j newPos
    replaceValueList board i newRow

-- Retorna a regiao de uma posicao especifica do tabuleiro
getRegionBoard :: I -> J -> Board -> Char
getRegionBoard i j b = getRegion ((b!!i)!!j)

-- Retorna uma posicao especifica do tabuleiro
getPosition :: I -> J -> Board -> Position
getPosition i j b = (b!!i)!!j
        
-- Le tabuleiro, entao retorna um dicionario
-- Onde as chaves sao as regioes (Char) e os valores sao os valores das posicoes correspondentes [Int]
defineRegions :: Board -> Map Char [Int]
defineRegions board = defineRegionsAux 0 0 (getLen board) board empty

-- Metodo auxiliar de defineRegions
defineRegionsAux :: I -> J -> Int -> Board -> Map Char [Int] -> Map Char [Int]
defineRegionsAux i j n board dict
    | (i == n) = dict
    | (j == n) = defineRegionsAux (i+1) 0 n board dict
    | otherwise = let pos = getPosition i j board in 
            defineRegionsAux i (j+1) n board (insertWith (++) (getRegion pos) [(getValue pos)] dict)

-- Imprime tabuleiro (Simples)
printBoard :: Board -> IO ()
printBoard [] = putStr ""
printBoard (a:b) = printRow a >>= (\x -> printBoard b)

-- Imprime tabuleiro com regioes definidas
prettyPrint :: Board -> IO()
prettyPrint board = prettyPrintCabecario 0 len >>=
                    (\x ->prettyPrintAux 0 0 board len ("|", "|"))
                    where len = getLen board

-- Metodo auxiliar de prettyPrint
prettyPrintAux :: I -> J -> Board -> Int -> (String, String) -> IO ()
prettyPrintAux i j board len (l1, l2)
    | (i == len) = putStr ""
    | (j == len) = putStrLn l1 >>= (\x -> putStrLn l2 >>= (\y -> prettyPrintAux (i+1) 0 board len ("|", "|")))
    | otherwise = do
        let pos = getPosition i j board
        let l11 = l1 ++ if (value == (-1)) then "." else [intToDigit value] where value = (getValue pos)
        let l111 = l11 ++ if (getRightBorderBlock pos) then "|" else " "

        let l22 = l2 ++ if (getDownBorderBlock pos) then "-" else " "
        let l222 = l22 ++ if ((j == (len-1)) ||
                           (getDownBorderBlock pos == False) ||
                           (getDownBorderBlock rightPos == False)) then "|" else "-"
                           where rightPos = getPosition i (j+1) board

        prettyPrintAux i (j+1) board len (l111, l222)

-- Metodo auxiliar de prettyPrint
prettyPrintCabecario :: J -> Int -> IO ()
prettyPrintCabecario j len
    | (j == (len*2)) = putStrLn "|"
    | (j == 0) = putStr "|" >>= (\x -> prettyPrintCabecario (j+1) len)
    | otherwise = putStr "-" >>= (\x -> prettyPrintCabecario (j+1) len)
------------------------------------------------------------------------------------

