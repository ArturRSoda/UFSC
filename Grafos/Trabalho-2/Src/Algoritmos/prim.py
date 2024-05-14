from grafo import Grafo
from Algoritmos.binary_heap import BinaryHeap

def prim(graph: Grafo) -> list[int]:
    r: int = 0

    A: list[int] = [None for _ in range(graph.qtdVertices())]
    K: list[float] = [float("inf") for _ in range(graph.qtdVertices())]

    K[r] = 0
    
    Q: BinaryHeap = BinaryHeap(K.copy())

    add: bool = True
    while (not Q.isEmpty()):


        if (add):
            Q: BinaryHeap = BinaryHeap(K.copy())
            add = False

        u: int = K.index(Q.remove())+1
        
        for v in graph.vizinhos(u):
            if (graph.peso(u, v) < K[v-1]):
                A[v-1] = u
                K[v-1] = graph.peso(u, v)
                add = True

    return A


