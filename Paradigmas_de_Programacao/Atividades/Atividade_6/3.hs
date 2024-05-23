data Ponto = R2 Float Float | R3 Float Float Float

dist :: Ponto -> Ponto -> Float
dist (R2 x1 y1) (R2 x2 y2) = ((x2 - x1)**2 + (y2 - y1)**2)**(1/2)
dist (R3 x1 y1 z1) (R3 x2 y2 z2) = ((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)**(1/2)

main = do
    print(dist (R2 1 4) (R2 1 1))
    print(dist (R3 2 (-3) (-5)) (R3 4 (-8) (-9)))
