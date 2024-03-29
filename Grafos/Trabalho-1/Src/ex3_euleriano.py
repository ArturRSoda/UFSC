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

    #busca ciclo eulariano
    eulariano, ciclo = hierholzer(grafo)
    #printa 1 se for eulariano
    print(1 if eulariano else 0)
    #printa o ciclo
    print(",".join(str(x) for x in ciclo))


ex3()


