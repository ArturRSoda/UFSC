import Pontos

main = do
    let p1 = Ponto2D (1, 4) -- x1 y1 01 x1 y1
    let p2 = Ponto2D (1, 1) -- x2 y2 01 x2 y2
    let p3 = Ponto2D (1, 6) -- x3 y3 01 x3 y3
    let p4 = Ponto2D (2, 3)
    print (distancia p1 p2)
    print (colineares p1 p2 p3)
    print (colineares p1 p2 p4)
    let p5 = Ponto2D (1, 2)
    let p6 = Ponto2D (2, -2)
    let p7 = Ponto2D (-2, 1)
    print (formaTriangulo p5 p6 p7)
    print (formaTriangulo p1 p2 p3)
