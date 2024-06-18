from sys import argv
from grafo import Grafo
from Algoritmos.hopcroft_karp import hopcroft_karp

def make_vertices(mate: list[int]) -> list[tuple[int, int]]:
    C = [False for _ in range(len(mate))] 
    C[0] = True

    A: list[tuple[int, int]] = list()
    for u in range(len(mate)):
        if ((not C[u]) and (mate[u] != 0)):
            C[u] = True
            C[mate[u]] = True
            A.append((u, mate[u]))

    return A


def ex2() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(True)

    grafo.ler(fileName)

    # Monta o emparelhamento maximo no grafo
    m, mate = hopcroft_karp(grafo)
    # Monta o par de vertices
    A = make_vertices(mate)

    print(m)
    print(", ".join(["%d-%d"%(u, v) for (u, v) in A]))

ex2()

