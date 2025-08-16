from sys import argv
from grafo import Grafo
from Algoritmos.floyd_warshall import floyd_warshall

def ex5() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return

    fileName: str = argv[1]

    grafo: Grafo = Grafo()
    grafo.ler(fileName)

    # Retonar a matriz de distancia (todos para todos)
    distances: list[list[float]] = floyd_warshall(grafo)

    # Imprime as distancias referentes de cada vertice
    for i, d in enumerate(distances):
        print("%d:%s"%(i+1, ",".join([str(int(x)) for x in d])))

ex5()



