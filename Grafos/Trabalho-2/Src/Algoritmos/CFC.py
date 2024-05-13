from grafo import Grafo

def DFS_Visit(graph: Grafo, v: int, C: list[bool], T: list[float], F: list[float], A: list[int], time: int) -> tuple[list[bool], list[float], list[float], list[int], int]:
    C[v-1] = True
    time += 1
    T[v-1] = time

    for u in graph.vizinhos(v):
        if (not C[u-1]):
            A[u-1] = v
            C, T, F, A, time = DFS_Visit(graph, u, C, T, F, A, time)

    time += 1
    F[v-1] = time

    return (C, T, F, A, time)


def DFS(graph: Grafo, F_adaptado: list[float] = list()) -> tuple[list[bool], list[float], list[float], list[int]]:
    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    T: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    F: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    A: list[int] = [None for _ in range(graph.qtdVertices())]

    time: int = 0
    vertexes: list[int] = [i for i in range(1, graph.qtdVertices()+1)]

    if (F_adaptado):
        vertexes.clear()
        F_adaptado_ = F_adaptado.copy()
        while (F_adaptado):
            maxV: float = max(F_adaptado)
            vertexes.append(F_adaptado_.index(maxV)+1)
            F_adaptado.remove(maxV)

    for u in vertexes:
        if (not C[u-1]):
            C, T, F, A, time = DFS_Visit(graph, u, C, T, F, A, time)

    return (C, T, F, A)


def CFC(graph: Grafo) -> list[int]:
    C: list[bool] = list()
    T: list[float] = list()
    F: list[float] = list()
    A: list[int] = list()

    C, T, F, A = DFS(graph)

    transpostGraph: Grafo = graph.getGrafoTransposto()

    C, T, F, A = DFS(transpostGraph, F)

    return A


