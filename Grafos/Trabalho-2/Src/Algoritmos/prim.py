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

    # Define chave do vertice escolhido como 0
    K[r] = 0

    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    
    # Arvore binaria
    Q: BinaryHeap = BinaryHeap(K.copy())

    # Flag que indica quando temos que atualizar a arvore
    add: bool = True
    while (not Q.isEmpty()):

        if (add):
            #Q: BinaryHeap = BinaryHeap([K[i] for i in range(len(K)) if (not C[i])])
            Q: BinaryHeap = BinaryHeap(K.copy())
            add = False

        # Seleciona vertice com menor chave
        u: int = K.index(Q.remove())+1
        C[u-1] = True
        
        # Passa por todos os vizinhos de u
        for v in graph.vizinhos(u):
            # Se o peso da aresta (u, v) for menor que a chave de V
            if ((not C[v-1]) and (graph.peso(u, v) < K[v-1])):
                # Definimos u como antecessor de V
                A[v-1] = u
                # Definimos que a chave e V eh o peso de (u, v)
                K[v-1] = graph.peso(u, v)
                # Indica que a arvore binaria deve ser atualizada
                add = True

    return A

