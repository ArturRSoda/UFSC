from collections import deque
from grafo import Grafo

def busca_em_largura(graph: Grafo, s: int) -> tuple[list[float], list[int]]:
    if ((s < 1) or (s > graph.qtdVertices())):
        print("Error: indice invalido. Validos: (1 <= s <= %d)" % graph.qtdVertices())
        exit()

    known: list[bool] = [False for _ in range(graph.qtdVertices())]
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]    

    known[s-1] = True
    distances[s-1] = 0
    
    queue: deque = deque() 
    queue.append(s)

    while (len(queue)):
        u: int = queue.popleft()
        
        for v in graph.vizinhos(u):
            if (not known[v-1]):
                known[v-1] = True
                distances[v-1] = distances[u-1] + 1
                ancestors[v-1] = u
                queue.append(v)

    return (distances, ancestors)
        

    

