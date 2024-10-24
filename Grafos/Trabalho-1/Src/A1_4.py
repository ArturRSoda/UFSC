from sys import argv
from grafo import Grafo
from Algoritmos.bellman_ford import bellman_ford
from Algoritmos.dijkstra import dijkstra


def ex4() -> None:
    if (len(argv) != 3):
        print("Error: arg1=caminho_instancia arg2=vertice_origem")
        return

    fileName: str = argv[1]
    s: int = int(argv[2])
    grafo: Grafo = Grafo()

    grafo.ler(fileName)
    
    # Resolve problema de caminhos de custo minimo poor Bellman_Ford e Dijkstra

    print("------------------- Bellman_Ford --------------------")
    print(" -> Bellman_Ford:")
    v, distances, ancestors = bellman_ford(grafo, s)
    if (v):
        imprimeCaminhos(grafo, s, distances, ancestors)
    print("-----------------------------------------------------")

    print()

    print("--------------------- Dijkstra ----------------------")
    print(" -> Dijkstra:")
    distances, ancestors = dijkstra(grafo, s)
    imprimeCaminhos(grafo, s, distances, ancestors)
    print("-----------------------------------------------------")

# Funcao para facilitar a impressao
def imprimeCaminhos(grafo: Grafo, s: int, distances: list[float], ancestors: list[int]) -> None:
    path: list[int] = list()
    for i in range(1, grafo.qtdVertices()+1):
        path.clear()
        a: int = i
        while (True):
            path.insert(0, a)
            if (a == s): break
            a = ancestors[a-1]

        print("%d: %s; d=%d" % (i, ",".join([str(x) for x in path]), distances[i-1]))
ex4()


