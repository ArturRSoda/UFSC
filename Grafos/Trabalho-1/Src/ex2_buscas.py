from sys import argv
from grafo import Grafo
from Algoritmos.busca_em_largura import busca_em_largura


def ex2() -> None:
    if (len(argv) != 3):
        print("Error: arg1=caminho_instancia arg2=vertice_origem")
        return

    fileName: str = argv[1]
    s: int = int(argv[2])
    grafo: Grafo = Grafo()

    grafo.ler(fileName)

    distances = busca_em_largura(grafo, s)[0]

    levels: dict[float, list[int]] = dict()
    for i, d in enumerate(distances):
        if (d != float("inf")):
            if (d in levels.keys()):
                levels[d].append(i+1)
            else:
                levels[d] = [i+1]

    for k, v in sorted(levels.items()):
        print("%d: %s" % (k, ",".join([str(x) for x in v])))
ex2()

