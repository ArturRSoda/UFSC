from sys import argv
from grafo import Grafo
from Algoritmos.kruskal import kruskal

def ex2() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=True)

    grafo.ler(fileName)

    A: set[tuple[int, int]] = kruskal(grafo)

    print(sum([grafo.peso(u, v) for (u, v) in A]))
    print(", ".join(["%d-%d"%(u, v) for (u, v) in A]))

ex2()

