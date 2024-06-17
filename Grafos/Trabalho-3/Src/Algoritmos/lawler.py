from itertools import chain, combinations
from grafo import Grafo

def powerSet(arr) -> list[tuple[int]]:
    return list(chain.from_iterable(combinations(arr, r) for r in range(len(arr)+1)))

def conjInd(graph: Grafo, s_: tuple[int]) -> list[tuple[int]]:
    S: list[tuple[int]] = powerSet(list(s_))
    R: list[tuple[int]] = []

    for s in S.copy()[1:]:
        c: bool = True
        for v in s:
            for u in s:
                if (graph.haAresta(u, v)):
                    c = False
                    break
        if (c):
            ps: list[tuple[int]] = powerSet(s)
            for sc in ps:
                if (sc in S):
                    S.remove(sc)
            R.append(s)
    return R
                    


def lawler(graph: Grafo):
    X: list[float] = [float("inf") for _ in range(pow(2, graph.qtdVertices()))]
    X[0] = 0
    f: dict[str, int] = {'[]' : 0}

    S: list[tuple[int]] = powerSet([i+1 for i in range(graph.qtdVertices())])

    arestas: list[tuple[int, int]] = graph.arestas()
    for index in range(1, len(S)):
        s: tuple[int] = S[index]
        f[str(list(s))] = index

        G_: Grafo = graph.getcopy()
        G_.qtdVertex = len(s)
        for i in range(len(G_.adjacencyMatriz)):
            for j in range(len(G_.adjacencyMatriz[0])):
                G_.adjacencyMatriz[i][j] = 1 if ((i+1 in s) and (j+1 in s) and (((i+1,j+1) in arestas) or ((j+1,i+1) in arestas))) else float("inf")

        for I in conjInd(G_, s):
            i: int = f[str(sorted(list(set(s).difference(set(I)))))]
            if X[i]+1 < X[index]:
                X[index] = X[i]+1

    return X[-1]

