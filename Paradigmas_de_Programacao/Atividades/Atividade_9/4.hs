bhask :: Float -> Float -> Float -> (Float, Float)
bhask = (\a b c -> ((-b+(b*b - 4*a*c)**(1/2))/(2*a),(-b-(b*b - 4*a*c)**(1/2))/(2*a)))

main = do
    let a = 2
    let b = (-6)
    let c = 4
    print (bhask a b c)
