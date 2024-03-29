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

    #pega as distancias dos vertices em relacao a S
    #por meio de busca em largura
    distances = busca_em_largura(grafo, s)[0]

    #dicionario onde as chaves sao os levels e o valores sao os vertices no nivel
    levels: dict[float, list[int]] = dict()
    #para cada distancia
    for i, d in enumerate(distances):
        #se houver uma distancia
        if (d != float("inf")):
            #adiciona o vertices em seu respectivo nivel
            if (levels.get(d)):
                levels[d].append(i+1)
            else:
                levels[d] = [i+1]

    #printa os niveis
    for k, v in sorted(levels.items()):
        print("%d: %s" % (k, ",".join([str(x) for x in v])))
ex2()

