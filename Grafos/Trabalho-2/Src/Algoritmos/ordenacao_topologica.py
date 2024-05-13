from grafo import Grafo

def DFS_Visit_Ot(graph: Grafo, v: int, C: list[bool], O: list[int]) -> tuple[list[bool], list[int]]:
    C[v-1] = True

    for u in graph.vizinhos(v):
        if (not C[u-1]):
            C, O = DFS_Visit_Ot(graph, u, C, O)

    O = [v]+O

    return (C, O)

def ordenacao_topologica(graph: Grafo) -> list[int]:
    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    O: list[int] = list()

    for v in range(1, graph.qtdVertices()+1):
        if (not C[v-1]):
            C, O = DFS_Visit_Ot(graph, v, C, O)

    return O
