from sys import argv
from grafo import Grafo
from Algoritmos.ordenacao_topologica import ordenacao_topologica

def ex2() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=True)

    grafo.ler(fileName)

    O: list[int] = ordenacao_topologica(grafo)

    print(" -> ".join([grafo.rotulo(i) for i in O]))

ex2()



