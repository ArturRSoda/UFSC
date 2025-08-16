from grafo import Grafo

# Busca por profundidade
def DFS_Visit_Ot(graph: Grafo, v: int, C: list[bool], O: list[int]) -> tuple[list[bool], list[int]]:
    # Marca vertice V como vizitado
    C[v-1] = True

    # Busca os vizinhos de v
    for u in graph.vizinhos(v):
        if (not C[u-1]):
            C, O = DFS_Visit_Ot(graph, u, C, O)

    # Adiciona v no inicio da lista
    O = [v]+O

    return (C, O)

# Ordena vertices por ordem topologica
def ordenacao_topologica(graph: Grafo) -> list[int]:
    # Lista de controle dos vertices vizitados
    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    # Lista que guarda os vertices organizados
    O: list[int] = list()

    # Utiliza busca por profundidade
    for v in range(1, graph.qtdVertices()+1):
        if (not C[v-1]):
            C, O = DFS_Visit_Ot(graph, v, C, O)

    return O
