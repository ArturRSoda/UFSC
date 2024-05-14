from grafo import Grafo

def DFS_Visit(graph: Grafo, v: int, C: list[bool], T: list[float], F: list[float], A: list[int], time: int) -> tuple[list[bool], list[float], list[float], list[int], int]:
    # Marca vertice v como vizitado
    C[v-1] = True

    # Marca seu tempo de chegada
    time += 1
    T[v-1] = time

    # Faz a busca por todos os vizinhos de v, que ainda nao foram vizitados
    for u in graph.vizinhos(v):
        if (not C[u-1]):
            A[u-1] = v
            C, T, F, A, time = DFS_Visit(graph, u, C, T, F, A, time)

    # Marca tempo de volta
    time += 1
    F[v-1] = time

    return (C, T, F, A, time)


# Busca por profundidade
# Caso F_adaptado receber um valor, os vertices sao escolhidos em ordem descrescente de F_adaptado
def DFS(graph: Grafo, F_adaptado: list[float] = list()) -> tuple[list[bool], list[float], list[float], list[int]]:
    # Lista de controle de vertices visitados
    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    # Lista de tempos de chegada
    T: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    # Lista de tempos de volta
    F: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    # Lista de antecessores
    A: list[int] = [None for _ in range(graph.qtdVertices())]

    # Tempo
    time: int = 0
    # Vertices
    vertexes: list[int] = [i for i in range(1, graph.qtdVertices()+1)]

    # Caso F_adaptado receber um valor, a lista de vertices eh organizado em ordem decrescente de F_adaptado
    if (F_adaptado):
        vertexes.clear()
        F_adaptado_ = F_adaptado.copy()
        while (F_adaptado):
            maxV: float = max(F_adaptado)
            vertexes.append(F_adaptado_.index(maxV)+1)
            F_adaptado.remove(maxV)

    # Faz a busca por profundidade
    for u in vertexes:
        if (not C[u-1]):
            C, T, F, A, time = DFS_Visit(graph, u, C, T, F, A, time)

    return (C, T, F, A)


# Algoritmo para achar componentes fortemente conexos
def CFC(graph: Grafo) -> list[int]:
    # Lista de controle de vertices ja visitados
    C: list[bool] = list()
    # Lista de tempos de chegada
    T: list[float] = list()
    # Lista de tempos de volta
    F: list[float] = list()
    # Lista de antecessores
    A: list[int] = list()

    # Busca por profundidade
    C, T, F, A = DFS(graph)

    # Cria matriz transposta
    transpostGraph: Grafo = graph.getGrafoTransposto()

    # Busca por profundidade adaptado, onde eh selecionado vertices em ordem decrescente de F
    C, T, F, A = DFS(transpostGraph, F)

    # Retorna a lista de antecessores
    return A


