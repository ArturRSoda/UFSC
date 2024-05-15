from sys import argv
from grafo import Grafo
from Algoritmos.kruskal import kruskal
from Algoritmos.prim import prim

def ex2() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=False)

    grafo.ler(fileName)

    print("------------------- Kruskal --------------------")

    # Retorna arvore geradora minima
    # Definida pelo conjunto das arestas de menor peso que ligam todos os vertices
    A: set[tuple[int, int]] = kruskal(grafo)

    print(sum([grafo.peso(u, v) for (u, v) in A]))
    print(", ".join(["%d-%d"%(u, v) for (u, v) in A]))

    print("------------------------------------------------")

    print()

    print("-------------------- Prim ----------------------")

    # Retorna arvore geradora minima
    # definida pela lista de antecessores
    A_: list[int] = prim(grafo)
    edges: list[tuple[int, int]] = [(A_[i], i+1) for i in range(len(A_)) if (A_[i])]

    print(sum([grafo.peso(u, v) for (u, v) in edges]))
    print(", ".join(["%d-%d"%(u, v) for (u, v) in edges]))

    print("------------------------------------------------")


ex2()

