{-
 A sintaxe e uso de newtype sao quase igual a data,
 entretanto newtype esta limitado a somente um construtor
 enquando data pode ter varios
 -}

newtype X = X Int
-- Valido; igual a data X = X Int

-- newtype T = Z Int | Y Int
-- Invalido
--
main = do
    putStrLn "Ler este arquivo"
