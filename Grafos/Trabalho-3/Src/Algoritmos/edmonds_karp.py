from grafo import Grafo
from collections import deque

# Busca em largura para encontrar caminho aumentante
def busca_em_largura_EK(graph: Grafo, s: int, t: int) -> list[tuple[int, int]]:
    # Lista para controle de vertices vizitados
    C: list[bool] = [False for _ in range(graph.qtdVertices())]
    # Lista de ancestrais
    A: list[int] = [None for _ in range(graph.qtdVertices())]
    
    # Marca vertice de inicio como vizitado
    C[s-1] = True

    # Fila para busca em largura
    Q: deque = deque()
    Q.append(s)

    # Lista que representa caminho aumentante
    p: list[tuple[int, int]] = list()

    # Busca em largura, verificando se o proximo vertice ja foi vizitado ou se ainda eh possivel adicionar fluxo na aresta
    #   Ateh chegar ao logradouro,
    #       Se chegar -> Monta caminho aumentante
    #       Se nao chegar -> Retorna lista vazia (nao ha caminho aumentante)
    while(len(Q)):
        u: int = Q.popleft()
        
        for v in graph.vizinhos(u):
            if ((not C[v-1]) and (graph.adjacencyMatriz[u-1][v-1] > 0)):
                C[v-1] = True
                A[v-1] = u

                if (v == t):
                    w: int = t
                    while (w != s):
                        p = [(A[w-1], w)] + p
                        w = A[w-1]
                    return p
                Q.append(v)
    return p

# Retorna fluxo maximo, apartir do vertice fonte s, ateh o sorvedouro t
def edmonds_karp(graph: Grafo, s: int, t: int) -> float:
    # Indica Fluxo maximo
    F: float = 0

    # Enquanto houver caminho aumentante
    while (True):
        p: list[tuple[int, int]] = busca_em_largura_EK(graph, s, t)
        if (not p): break
        
        # Pega o fluxo minimo do caminho aumentante encontrado
        fp: float = min([graph.peso(u, v) for (u, v) in p])

        # Adiciona o fluxo encontrado
        F += fp
        for (u, v) in p:
            graph.flowMatriz[u-1][v-1] += fp
            graph.adjacencyMatriz[u-1][v-1] -= fp

    return F

        


        
                
