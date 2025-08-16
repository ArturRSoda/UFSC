import Fila

main = do
    let fila = enqueue emptyQueue 1
    let fila2 = enqueue fila 2
    let fila3 = enqueue fila2 3
    let fila4 = dequeue fila3
    print fila3
    print (first fila3)
    print fila4

    
