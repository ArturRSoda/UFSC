from sys import argv
from grafo import Grafo
from Algoritmos.lawler import lawler

def colore(grafo: Grafo):
    cores: list[int] = [None for _ in range(grafo.qtdVertices())]
    possiveis: list[int] = list()

    cores[0] = 1
    possiveis.append(1)
    
    i: int = 2
    for u in range(grafo.qtdVertices()):
        coresVizinhos = [cores[v-1] for v in grafo.vizinhos(u+1) if cores[v-1] != None]
        coresRestantes = list(set(possiveis).difference(set(coresVizinhos)))
        if (coresRestantes):
            cores[u] = coresRestantes[0]
        else:
            cores[u] = i
            possiveis.append(i)
            i += 1

    return cores



def ex3() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=False)

    grafo.ler(fileName)

    X = lawler(grafo)
    print(X)

    cores = colore(grafo)
    print(", ".join([str(x) for x in cores]))



ex3()

