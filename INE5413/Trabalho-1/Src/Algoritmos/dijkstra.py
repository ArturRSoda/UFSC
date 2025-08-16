from grafo import Grafo
from Algoritmos.binary_heap import BinaryHeap

def dijkstra(graph: Grafo, s: int) -> tuple[list[float], list[int]]:
    # Lista de distancias de S para todos os outros vertices
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    # Lista de ancestrais
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]
    # Lista para controle de vertices ja conhecidos
    known: list[bool] = [False for _ in range(graph.qtdVertices())]

    # Define distancia de S para S
    distances[s-1] = 0

    # arvore binaria (melhor otimizacao da complexidade algoritmo)
    heap: BinaryHeap = BinaryHeap([])
    # Flag para indicar quando eh para adicionar uma nova distancia de um vertice na heap
    add: bool = True

    # Cotinua enquanto tiver vertice nao conhecido
    while ((False in known)):
        # Caso flag indica que foi adicionado novo vertice
        if (add):
            # Procura todas as distancias de vertices ainda nao conhecidos
            # e desativa a flag
            heap = BinaryHeap([distances[i] for i in range(len(distances)) if known[i] == False])
            add = False


        # Para caso a arvore estiver vazia
        if (heap.isEmpty()): break

        # Pega o vertice (U) com a menor distancia na heap
        # e define como conhecida
        dis: float = heap.remove()
        u: int = distances.index(dis)+1
        known[u-1] = True

        # Para cada vizinho (V) de U (vertice com menor distancia) que ainda nao foi conhecido
        for v in [x for x in graph.vizinhos(u) if known[x-1] == False]:
            # Se a distancia de V (Vizinho) for maior que a distancia de U + o peso de U para V
            #   define nova distancia de V, seu ancestra, e aciona flag
            if (distances[v-1] > (distances[u-1] + graph.peso(u, v))):
                distances[v-1] = distances[u-1] + graph.peso(u, v)
                ancestors[v-1] = u
                add = True

    # Retorna as distancias e ancestrais
    return distances, ancestors

