from grafo import Grafo

def floyd_warshall(graph: Grafo) -> list[list[float]]:
    # Matriz que representa as distancias de todos os vertices para os demais vertices do grafo
    #   seus valores:
    #       - 0               se   (i == j)
    #       - peso de (i,j)   se   (i != j) e (i,j) eh uma aresta existente
    #       - float("inf")    se   (i != j) e (i,j) nao eh uma aresta existente
    distances: list[list[float]] = [[0 if (i==j) else (graph.peso(i+1, j+1) if graph.peso(i+1, j+1) != float("inf") else float("inf")) for i in range(graph.qtdVertices())] for j in range(graph.qtdVertices())]

    # define um vertice K
    for k in range(graph.qtdVertices()):
        # para cada aresta (U, V)
        for u in range(graph.qtdVertices()):
            for v in range(graph.qtdVertices()):
                # Se "distancia de U para K + distancia de K para V"
                # for menor que "distancia de U para V"
                # entao a nova "distancia de U para V" eh <u -> k -> v>
                distances[u][v] = min((distances[u][v], distances[u][k] + distances[k][v]))

    return distances

