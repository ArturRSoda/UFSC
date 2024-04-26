from grafo import Grafo

def bellman_ford(graph: Grafo, s: int) -> tuple[bool, list[float], list[int]]:
    # Lista de distancias de S para todos os outros vertices
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    # Lista de ancestrais
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]

    # Define distancia de S para S
    distances[s-1] = 0 

    # Lista com todas as arestas
    arestas: list[tuple[int, int]] = graph.arestas()

    # Passa por todas as as arestas qtdVertices vezes
    for _ in range(graph.qtdVertices()-1):
        for u, v in arestas:
            # para cada aresta (U, V)
            # Verifica se a distancia de V eh maior que a distancia de U + o peso de V
            #   caso verdadeiro, define nova distancia de V e seu ancestral
            if (distances[v-1] > (distances[u-1] + graph.peso(u, v))):
                distances[v-1] = distances[u-1] + graph.peso(u, v)
                ancestors[v-1] = u

    # Procura existencia de ciclos negativos
    #   Retornando falso caso ache
    for u, v in graph.arestas():
        if (distances[v-1] > (distances[u-1] + graph.peso(u, v))):
            return (False, [], [])

    # retorna distancias e ancestrais
    return (True, distances, ancestors)

    
