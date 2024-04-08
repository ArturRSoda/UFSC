from grafo import Grafo

def bellman_ford(graph: Grafo, s: int) -> tuple[bool, list[float], list[int]]:
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]

    distances[s-1] = 0 

    arestas: list[tuple[int, int]] = graph.arestas() + [(v, u) for (u, v) in graph.arestas()]
    for _ in range(graph.qtdVertices()-1):
        for u, v in arestas:
            if (distances[v-1] > (distances[u-1] + graph.peso(u, v))):
                distances[v-1] = distances[u-1] + graph.peso(u, v)
                ancestors[v-1] = u

    for u, v in graph.arestas():
        if (distances[v-1] > (distances[u-1] + graph.peso(u, v))):
            return (False, [], [])

    return (True, distances, ancestors)

    
