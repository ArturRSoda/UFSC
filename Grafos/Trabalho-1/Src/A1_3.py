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

    # Busca ciclo euleriano
    euleriano, ciclo = hierholzer(grafo)
    # Imprime 1 se for euleriano
    print(1 if euleriano else 0)
    # Imprime o ciclo caso eulerino
    if (euleriano):
        print(",".join(str(x) for x in ciclo))

ex3()


