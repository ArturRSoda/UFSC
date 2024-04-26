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

    # Pega as distancias dos vertices em relacao a S
    # por meio de busca em largura
    distances = busca_em_largura(grafo, s)[0]

    # Dicionario onde as chaves sao os niveis e o valores sao os vertices no nivel
    levels: dict[float, list[int]] = dict()
    # Para cada distancia
    for i, d in enumerate(distances):
        # Se houver uma distancia
        if (d != float("inf")):
            # Adiciona o vertices em seu respectivo nivel
            if (levels.get(d)):
                levels[d].append(i+1)
            else:
                levels[d] = [i+1]

    # Printa os niveis
    for k, v in sorted(levels.items()):
        print("%d: %s" % (k, ",".join([str(x) for x in v])))
ex2()

