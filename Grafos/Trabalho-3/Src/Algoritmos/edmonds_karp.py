from grafo import Grafo
from collections import deque

def busca_em_largura_EK(graph: Grafo, s: int, t: int) -> list[tuple[int, int]]:
    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    A: list[int] = [None for _ in range(graph.qtdVertices())]
    
    C[s-1] = True

    Q: deque = deque()
    Q.append(s)

    p: list[tuple[int, int]] = list()
    while(len(Q)):
        u: int = Q.popleft()
        
        for v in graph.vizinhos(u):
            if ((not C[v-1]) and (graph.adjacencyMatriz[u-1][v-1] > 0)):
                C[v-1] = True
                A[v-1] = u

                if (v == t):
                    w: int = t
                    while (w != s):
                        p = [(A[w-1], w)] + p
                        w = A[w-1]
                    return p
                Q.append(v)
    return p

def edmonds_karp(graph: Grafo, s: int, t: int) -> float:
    F: float = 0

    while (True):
        p: list[tuple[int, int]] = busca_em_largura_EK(graph, s, t)
        if (not p): break
        fp: float = min([graph.peso(u, v) for (u, v) in p])
        F += fp

        for (u, v) in p:
            graph.flowMatriz[u-1][v-1] += fp
            graph.adjacencyMatriz[u-1][v-1] -= fp

    return F

        


        
                
