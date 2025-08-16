bask :: Float -> Float -> Float -> [Float]
bask a b c = [(-b+((b*b - 4*a*c)**(1/2)))/(2*a), (-b-((b*b - 4*a*c)**(1/2)))/(2*a)]

main = do
    a <- getLine
    b <- getLine
    c <- getLine
    print (bask (read a :: Float) (read b :: Float) (read c :: Float))
