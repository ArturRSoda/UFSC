from collections import deque
from grafo import Grafo

def busca_em_largura(graph: Grafo, s: int) -> tuple[list[float], list[int]]:
    #somente continua se s for um vertice valido
    if ((s < 1) or (s > graph.qtdVertices())):
        print("Error: indice invalido. Validos: (1 <= s <= %d)" % graph.qtdVertices())
        exit()

    #lista de vertices ainda nao conhecidos
    known: list[bool] = [False for _ in range(graph.qtdVertices())]
    #lista de distancias
    distances: list[float] = [float("inf") for _ in range(graph.qtdVertices())]
    #lista ce ancestrais
    ancestors: list[int] = [None for _ in range(graph.qtdVertices())]    

    #seta o vertice passado como conhecido
    known[s-1] = True
    #sua distancia para ele mesmo
    distances[s-1] = 0
    
    #e o adiciona para a fila
    queue: deque = deque() 
    queue.append(s)

    #enquanto tiver vertices na fila
    while (len(queue)):
        #U recebe o primeiro item da fila
        u: int = queue.popleft()
        
        #para cada visinho de U
        for v in graph.vizinhos(u):
            #se o visinha ainda nao for conhecido
            #seta como conhecido, sua distancia de S e seu ancestra 
            #e eh adicionado a fila
            if (not known[v-1]):
                known[v-1] = True
                distances[v-1] = distances[u-1] + 1
                ancestors[v-1] = u
                queue.append(v)

    #retorna distancias e ancestrais
    return (distances, ancestors)
        

    

