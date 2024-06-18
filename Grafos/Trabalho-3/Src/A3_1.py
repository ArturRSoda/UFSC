from sys import argv
from grafo import Grafo
from Algoritmos.edmonds_karp import edmonds_karp


def ex1() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=True)

    grafo.ler(fileName)
    
    # Pesquisa todos os fluxos maximos possiveis no grafo, e retorna o maior deles
    print(int(max([edmonds_karp(grafo.getcopy(), u, v) for u in range(1, grafo.qtdVertices()+1) for v in range(1, grafo.qtdVertices()+1)])))

ex1()


