from collections import deque
from grafo import Grafo

def busca_em_largura(graph: Grafo, s: int) -> tuple[list[float], list[int]]:
    # Somente continua se s for um vertice valido
    if ((s < 1) or (s > graph.qtdVertices())):
        print("Error: indice invalido. Validos: (1 <= s <= %d)" % graph.qtdVertices())
        exit()

    # Lista para controle de vertices ja conhecidos
    known: list[bool] = [False for _ in range(graph.qtdVertices())]
    # Lista de distancias
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    # Lista de ancestrais
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]    

    # Define o vertice S ja como conhecido
    known[s-1] = True
    # Distancia dele para ele mesmo
    distances[s-1] = 0
    
    # Cria fina e adciona S
    queue: deque = deque() 
    queue.append(s)

    # Continua enquanto tiver vertice na fila
    while (len(queue)):
        #U recebe o proximo vertice da fila
        u: int = queue.popleft()
        
        # Para cada visinho (V) de U
        for v in graph.vizinhos(u):
            # Se V ainda nao for conhecido
            #   Define como conhecido, sua distancia de S e seu ancestral
            #   e adiciona V na fila
            if (not known[v-1]):
                known[v-1] = True
                distances[v-1] = distances[u-1] + 1
                ancestors[v-1] = u
                queue.append(v)

    # Retorna distancias e ancestrais
    return (distances, ancestors)
        

    

