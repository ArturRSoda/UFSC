from grafo import Grafo
from Algoritmos.binary_heap import BinaryHeap

def dijkstra(graph: Grafo, s: int) -> tuple[list[float], list[int]]:
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]
    known: list[bool] = [False for _ in range(graph.qtdVertices())]

    distances[s-1] = 0

    add: bool = True
    heap: BinaryHeap = BinaryHeap([])
    while ((False in known)):
        if (add):
            heap = BinaryHeap([distances[i] for i in range(len(distances)) if known[i] == False])
            add = False


        if (heap.isEmpty()): break
        dis: float = heap.remove()
        u: int = distances.index(dis)+1
        known[u-1] = True

        for v in [x for x in graph.vizinhos(u) if known[x-1] == False]:
            if (distances[v-1] > (distances[u-1] + graph.peso(u, v))):
                distances[v-1] = distances[u-1] + graph.peso(u, v)
                ancestors[v-1] = u
                add = True

    return distances, ancestors

