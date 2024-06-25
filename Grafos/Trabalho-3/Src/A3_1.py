from sys import argv
from grafo import Grafo
from Algoritmos.edmonds_karp import edmonds_karp


def ex1() -> None:
    if (len(argv) != 4):
        print("Error: arg1=caminho_instancia; arg2=fonte; arg3=logradouro")
        return 

    fileName: str = argv[1]
    s: int = int(argv[2])
    t: int = int(argv[3])
    grafo: Grafo = Grafo(dirigido=True)
    grafo.ler(fileName)
    
    # Pesquisa fluxo maximo do grafo do vertice s ao t
    print(int(edmonds_karp(grafo, s, t)))

ex1()


