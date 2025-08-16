type Raio = Float
type Altura = Float
type Base = Float

data Forma = Circulo Raio | Retangulo Base Altura | Triangulo Base Altura

area :: Forma -> Float
area (Circulo r) = pi * r * r
area (Retangulo b h) = b * h
area (Triangulo b h) = (b * h) / 2

main = do
    print(area (Triangulo 1 2))
    print(area (Retangulo 3 4))
    print(area (Circulo 5))
