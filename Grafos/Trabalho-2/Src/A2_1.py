from sys import argv
from grafo import Grafo
from Algoritmos.CFC import CFC

def monta_componentes(componentes: list[list[int]], v: int, A: list[int]) -> list[list[int]]:
    for subconj in componentes:
        if (v in subconj):
            return componentes
    a: int = A[v-1]

    if (a):
        componentes = monta_componentes(componentes, a, A)
        for subconj in componentes:
            if (a in subconj):
                subconj.append(v)
        return componentes

    else:
        return componentes+[[v]]


def ex1() -> None:
    if (len(argv) != 2):
        print("Error: arg1=caminho_instancia")
        return 

    fileName: str = argv[1]
    grafo: Grafo = Grafo(dirigido=True)

    grafo.ler(fileName)

    # Algoritmo para procurar componentes fortemente conexos
    # Retorna lista de antecessores
    A: list[int] = CFC(grafo)

    # Monta lista dos componentes
    componentes: list[list[int]] = list()
    for i in range(1, len(A)+1):
        componentes = monta_componentes(componentes, i, A)

    # Imprime os componentes
    for subconj in componentes:
        print(",".join([str(x) for x in sorted(subconj)]))

ex1()


