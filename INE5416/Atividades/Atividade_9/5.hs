data Ponto3R = Ponto3R Float Float Float

dist3R :: Ponto3R -> Ponto3R -> Float
dist3R = (\(Ponto3R x1 y1 z1) (Ponto3R x2 y2 z2) -> ((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)**(1/2))

main = do
    let p1 = Ponto3R 2 (-3) (-5)
    let p2 = Ponto3R 4 (-8) (-9)
    print (dist3R p1 p2)
