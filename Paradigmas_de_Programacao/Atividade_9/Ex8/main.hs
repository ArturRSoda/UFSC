import Matriz

main = do
    print (sumElementMatriz [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    print (sumTwoMatriz [[1, 1, 1], [1, 1, 1], [1, 1, 1]] [[2, 2, 2], [2, 2, 2], [2, 2, 2]])
    --let mat = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    let mat = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    print (verifyNumbers mat)
