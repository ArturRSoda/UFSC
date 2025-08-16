module Solve (validate, solve) where
import Data.Map
import Board
import Position
import Utils
import System.Posix (ProcessTimes(childUserTime))

-- Resolve tabuleiro
solve :: Board -> Maybe Board
solve board = do
    let regionDict = defineRegions board
    solveAux 0 0 1 board (getLen board) regionDict
    
-- Logica para resolucao do tabuleiro
solveAux :: I -> J -> Int -> Board -> Int -> Map Char [Int] -> Maybe Board
solveAux i j guess board n regionDict
    -- Caso passe da ultima linha -> Problema resolvido
    | (i == n) = Just board
    -- Caso passe da ultima coluna -> Passa para a proxima linha
    | (j == n) = solveAux (i+1) 0 guess board n regionDict
    -- Caso posicao ja possui um valor -> Passe para o proximo da coluna
    | (getValue (getPosition i j board) /= (-1)) = solveAux i (j+1) guess board n regionDict
    -- Senao tenta atribuir um valor a posicao:
    | otherwise = do
        -- verifica o chute
        case guess of
            -- Se passar do ultimo chute, cancela e temos que voltar um passo
            10 -> Nothing
            -- Se ainda nao chegou no ultimo chute
            --   Tenta atribui um valor a posicao
            otherwise -> do
                -- Atribui um valor a posicao
                let pos = getPosition i j board
                let regPos = getRegion pos
                let regionList = findWithDefault [] regPos regionDict
                let newBoard = changeValueBoard board i j guess

                -- Verifica se valor atribuido a posicao eh valido
                case (validate i j guess regionList newBoard) of
                    -- Caso nao for -> Tenta atribuir proximo valor
                    False -> solveAux i j (guess+1) board n regionDict

                    -- Caso for valido
                    True ->
                        -- Tentamos resolver o novo tabuleiro
                        case (solve newBoard) of
                            -- Se nao for possivel -> Passamos para proximo valor
                            Nothing -> solveAux i j (guess+1) board n regionDict
                            -- Se for possivel -> retorna o tabuleiro pronto
                            Just bd -> Just bd

-- Verifica se valor atribuido a posicao eh valido
validate :: I -> J -> Int -> RegionList -> Board -> Bool
validate i j guess rl board =
    -- Se valor ja esta presente na regiao
    notInArr guess rl &&
    -- Se o valor eh maior do que a regiao permite
    (guess <= regionLen) &&
    -- Verifica se adequa a posicao de cima
    verifyAbovePosition i j guess pos board &&
    -- Verifica se adequa a posicao de baixo
    verifyBellowPosition i j guess pos board n &&
    -- Verifica se adequa a posicao da esquerda
    verifyLeftPosition i j guess board &&
    -- Verifica se adequa a posicao da direita
    verifyRightPosition i j guess board n where 
          pos = getPosition i j board
          n = getLen board
          regionLen = getLen rl

-- Verifica se posicao atribuida se adequa a posicao de cima
verifyAbovePosition :: I -> J -> Int -> Position -> Board -> Bool
verifyAbovePosition i j guess pos board
    -- Caso ele esteja na primeira linha retorna verdadeiro
    | (i == 0) = True
    | otherwise = 
        let abovePos = getPosition (i-1) j board in
            -- (Caso valor de cima for diferente) e
            -- (Caso valor de cima esteja na mesma regiao, se possui um valor maior)
            (getValue abovePos /= guess) &&
            (case (getUpBorderBlock pos) of
                True -> True
                False -> (getValue abovePos > guess))
        
-- Verifica se posicao atribuida se adequa a posicao de baixo
verifyBellowPosition :: I -> J -> Int -> Position -> Board -> Int -> Bool
verifyBellowPosition i j guess pos board n
    -- Caso ele esteja na ultima linha retorna verdadeiro
    | (i == (n-1)) = True
    | otherwise =
        let bellowPos = getPosition (i+1) j board in 
            -- (Caso valor de baixo for diferente) e
            -- (Caso valor de baixo esteja na mesma regiao, se possui um valor menor)
            (getValue bellowPos /= guess) &&
            (case (getDownBorderBlock pos) of
                True -> True
                False -> (getValue bellowPos < guess))


-- Verifica se valor da esquerda eh diferente
verifyLeftPosition :: I -> J -> Int -> Board -> Bool
verifyLeftPosition i j guess board
    | (j == 0) = True
    | otherwise = 
        let leftPos = getPosition i (j-1) board in 
            (getValue leftPos /= guess)

-- Verifica se valor da direita eh diferente
verifyRightPosition :: I -> J -> Int -> Board -> Int -> Bool
verifyRightPosition i j guess board n
    | (j == (n-1)) = True
    | otherwise = 
        let rightPos = getPosition i (j+1) board in
            (getValue rightPos /= guess)

