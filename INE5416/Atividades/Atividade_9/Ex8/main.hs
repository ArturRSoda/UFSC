import Matriz

main = do
    print (sumElementMatriz [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    print (sumTwoMatriz [[1, 1, 1], [1, 1, 1], [1, 1, 1]] [[2, 2, 2], [2, 2, 2], [2, 2, 2]])
    --let mat = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    let mat = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    let mat2 = [[2, 7, 6], [9, 5, 1], [4, 3, 8]]
    let mat3 = [[0, 0, 0, 1], [0, 1, 0, 0], [1, 0, 0, 0], [0, 0, 1, 0]]
    print (verifyNumbers mat)
    print (sumMainDiagonal mat)
    print (sumSecundaryDiagonal mat)
    print (isMagicSquare mat2)
    print (isPermutationMatriz mat3)
    print (replaceRowValue [1, 2, 3, 4, 5, 6] 2 6)
    print (replaceMatrizRow mat 2 [1, 1, 1])
    print (replaceMatrizValue mat 2 1 9)
    let mat4 = [[0, 12, 12], [16, 10, 0], [8, 0, 0]]
    print (solveD mat4)
