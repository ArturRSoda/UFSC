
distancia :: (Float, Float) -> (Float, Float) -> Maybe Float
distancia (x1, y1) (x2, y2) = Just (((x2 - x1)**2 + (y2-y1)**2)**(1 / 2))

areaTriangulo :: Float -> Float -> Float -> Maybe Float
areaTriangulo a b c =
    let p = (a + b + c)/2 in
        Just ((p*(p-a)*(p-b)*(p-c))**(1/2))

colineares :: (Float, Float) -> (Float, Float) -> (Float, Float) -> Bool
colineares (x1, y1) (x2, y2) (x3, y3) = ((x1 * y2) + (y1 * x3) + (x2 * y3) - (y2 * x3) - (x1 * y3) - (y1 * x2)) == 0

formaTriangulo :: (Float, Float) -> (Float, Float) -> (Float, Float) -> Maybe Float
formaTriangulo a b c
    | colineares a b c = Nothing
    | otherwise = do
        dab <- distancia a b
        dac <- distancia a c
        dbc <- distancia b c
        areaTriangulo dab dac dbc

main = do
    print (formaTriangulo (-2, -1) (1, 2) (2, -2))
    print (formaTriangulo (100, 0) (2, 0) (-1, 0))
