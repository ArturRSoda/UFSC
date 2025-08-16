import Arvores

minhaArvore :: Arvore
minhaArvore = No 52 (No 32 (No 35 Null Null) (No 35 Null Null)) (No 56 (No 55 Null Null) (No 64 Null Null))


main = do 
    print (ocorrenciasElemento minhaArvore 35)
    print (maioresQueElemento minhaArvore 35)
    print (mediaElementos minhaArvore)
    print (quantidade minhaArvore)
    print(elementos minhaArvore)


