aprovado :: Float -> Float -> Float -> Bool
aprovado a b c = (\a b c -> ((a+b+c)/3) >= 6) a b c

main = do
   print (aprovado 6 6 6)
