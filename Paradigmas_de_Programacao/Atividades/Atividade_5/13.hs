apagarEnquando :: (t -> Bool) -> [t] -> [t]
apagarEnquando f [] = []
apagarEnquando f (a:b) | f a = apagarEnquando f b
                       | otherwise = (a:b)

main = do
    print(apagarEnquando odd [1, 3, 2341, 5, 4, 7, 6])
