from grafo import Grafo

def floyd_warshall(graph: Grafo) -> list[list[float]]:
    distances: list[list[float]] = [[float("inf") for _ in range(graph.qtdVertices())] for _ in range(graph.qtdVertices())]

    for i in range(graph.qtdVertices()):
        for j in range(graph.qtdVertices()):
            distances[i][j] = 0 if (i == j) else (graph.peso(i+1, j+1) if graph.peso(i+1, j+1) != float("inf") else distances[i][j])

    for k in range(graph.qtdVertices()):
        for u in range(graph.qtdVertices()):
            for v in range(graph.qtdVertices()):
                distances[u][v] = min((distances[u][v], distances[u][k] + distances[k][v]))

    return distances

