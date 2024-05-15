from grafo import Grafo
from Algoritmos.binary_heap import BinaryHeap

# Retorna lista de antecessores, formando uma arvore geradora minima
def prim(graph: Grafo) -> list[int]:
    # Seleciona um vertice arbitrariamente
    # Neste caso sempre esta pegando o primeiro
    r: int = 0

    # Lista de antecessores
    A: list[int] = [None for _ in range(graph.qtdVertices())]

    # Chaves de cada vertice
    K: list[float] = [float("inf") for _ in range(graph.qtdVertices())]

    # Controla os vertices que ja fazem parte da solucao
    C: list[bool] = [False for _ in range(graph.qtdVertices())]

    # Define chave do vertice escolhido como 0
    K[r] = 0

    for _ in range(graph.qtdVertices()):

        # Arvore binaria, para retornar a chave de menor valor
        Q: BinaryHeap = BinaryHeap([K[i] for i in range(len(K)) if (not C[i])])

        # Busca pelo vertice com menor chave
        u: int = K.index(Q.heap[0])+1
        K_ = K.copy()
        while (C[u-1]):
            K_[u-1] = float("inf")
            u = K_.index(Q.heap[0])+1

        # Define que o vertice faz parte da solucao
        C[u-1] = True
        
        # Passa por todos os vizinhos de u
        for v in graph.vizinhos(u):
            # Se o peso da aresta (u, v) for menor que a chave de V
            if ((not C[v-1]) and (graph.peso(u, v) < K[v-1])):
                # Definimos u como antecessor de V
                A[v-1] = u
                # Definimos que a chave e V eh o peso de (u, v)
                K[v-1] = graph.peso(u, v)

    return A

