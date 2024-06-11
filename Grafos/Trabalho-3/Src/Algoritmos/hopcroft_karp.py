from grafo import Grafo
from collections import deque

def BFS(graph: Grafo, mate: list[int], D: list[float]) -> bool:
    Q: deque = deque()

    for (x, _) in graph.arestas():
        if (mate[x] == 0):
            D[x] = 0
            Q.append(x)
        else:
            D[x] = float("inf")

    D[0] = float("inf")

    while(len(Q)):
        x = Q.popleft()
        if (D[x] < D[0]):
            for y in graph.vizinhos(x):
                if (D[mate[y]] == float("inf")):
                    D[mate[y]] = D[x]+1
                    Q.append(mate[y])

    return D[0] != float("inf")


def DFS(graph: Grafo, mate: list[int], x: int, D: list[float]) -> bool:
    if (x != 0):
        for y in graph.vizinhos(x):
            if (D[mate[y]] == D[x]+1):
                if (DFS(graph, mate, mate[y], D)):
                    mate[y] = x
                    mate[x] = y
                    return True
        D[x] = float("inf")
        return False
    return True



def hopcroft_karp(graph: Grafo) -> tuple[int, list[int]]:
    D: list[float] = [float("inf") for _ in range(graph.qtdVertices()+1)]
    mate: list[int] = [0 for _ in range(graph.qtdVertices()+1)]

    m: int = 0
    while (BFS(graph, mate, D)):
        for (x, _) in graph.arestas():     
            if (mate[x] == 0):
                if (DFS(graph, mate, x, D)):
                    m += 1

    return (m, mate)
    

