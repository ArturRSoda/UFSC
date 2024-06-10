from sys import argv
from grafo import Grafo

def ex2() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=False)

    grafo.ler(fileName)



ex2()

