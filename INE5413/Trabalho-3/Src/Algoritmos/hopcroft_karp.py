from grafo import Grafo
from collections import deque

# Busca por largura para procurar caminhos aumentantes
def BFS(graph: Grafo, mate: list[int], D: list[float]) -> bool:
    Q: deque = deque()

    # Passa por todos os vertices do conjunto X
    # Se ele ja esta emparelhado -> Define distancia com 0, e coloca na fila para participar da busca
    # Se nao -> Define distancia como infinito
    for (x, _) in graph.arestas():
        if (mate[x] == 0):
            D[x] = 0
            Q.append(x)
        else:
            D[x] = float("inf")

    # Define distancia do sorvedouro virtual como distancia infinita
    D[0] = float("inf")

    # Enquanto houver vertice para a busca
    while(len(Q)):
        # Pega o proximo da fila
        x = Q.popleft()

        # Somente nos interessa, se a dist. ateh x for menor que a dist. ateh o sorvedouro virtual
        if (D[x] < D[0]):
            # Olha para os vizinhos de x
            for y in graph.vizinhos(x):
                # Se o vizinho de x ja esta emparelhado,
                #    aumenta a distancia do vertice que esta emparelhado com y, e o adiciona na fila
                if (D[mate[y]] == float("inf")):
                    D[mate[y]] = D[x]+1
                    Q.append(mate[y])
                

    # Indica se achou caminho aumentante
    return D[0] != float("inf")


# Busca em profundidade para alterar emparelhamento se houver caminho aumentante
def DFS(graph: Grafo, mate: list[int], x: int, D: list[float]) -> bool:
    # Se nao for o sorvedouro virtual
    if (x != 0):
        # Verifica se tem caminho aumentante a partir de x
        #   Se sim, altera o emparelhamento
        for y in graph.vizinhos(x):
            if (D[mate[y]] == D[x]+1):
                if (DFS(graph, mate, mate[y], D)):
                    mate[y] = x
                    mate[x] = y
                    return True
        D[x] = float("inf")
        return False
    return True



def hopcroft_karp(graph: Grafo) -> tuple[int, list[int]]:
    # Vetor de distancia dos vertices
    D: list[float] = [float("inf") for _ in range(graph.qtdVertices()+1)]
    # Vetor que indica o emparelhamento dos vertices
    mate: list[int] = [0 for _ in range(graph.qtdVertices()+1)]

    # conta numero de emparelhamento
    m: int = 0

    # BFS procupar caminho aumentante
    # Enquanto houver caminho aumentante
    while (BFS(graph, mate, D)):
        # Passa por todos os vertices do conjunto X
        # E faz seu emparelhamento se houver/precisar
        for (x, _) in graph.arestas():     
            if (mate[x] == 0):
                if (DFS(graph, mate, x, D)):
                    m += 1


    return (m, mate)
    

