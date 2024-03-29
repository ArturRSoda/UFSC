from sys import argv
from grafo import Grafo
from Algoritmos.hierholzer import hierholzer


def ex3() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return

    fileName: str = argv[1]
    grafo: Grafo = Grafo()

    grafo.ler(fileName)

    
    for edges in grafo.arestas():
        print(edges)

    print(len(grafo.arestas()), grafo.qtdArestas())
    eulariano, ciclo = hierholzer(grafo)
    print(eulariano)
    print(ciclo)


ex3()


