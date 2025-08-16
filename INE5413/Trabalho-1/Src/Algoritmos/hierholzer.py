from grafo import Grafo

def busca(graph: Grafo, v: int, knownEdges: list[bool], edges: list[tuple[int, int]]) -> tuple[bool, list[int], list[bool]]:
    # Lista que representa o ciclo, iniciado com o vertex passado
    cicle: list[int] = [v]
    t: int = v

    while True:
        # Lista de arestas ligadas a V e ainda nao foram conhecidas
        vEdges: list[tuple[int, int]] = [edges[i] for i in range(len(edges)) if ((v in edges[i]) and (knownEdges[i] == False))]
        # Caso a lista for vazia retorna Falso
        if (not vEdges):
            return (False, [], knownEdges)

        # Escolhe alguma aresta ligada a V que ainda nao foi conhecida
        # Neste caso pega a primeira disponivel
        #   Depois, define como conhecida e define v para o proximo vertice
        knownEdges[edges.index(vEdges[0])] = True
        v = vEdges[0][1] if (vEdges[0][1] != v) else vEdges[0][0]

        # Adiciona V (proximo vertice) ao ciclo
        cicle.append(v)

        # Identifica se fechou o ciclo
        if (v == t):
            break

    # Procura outro ciclo eleriano apartir de algum dos vertices dentro do ciclo ja achado
    while True:
        # Listas das arestas que ainda nao foram conhecidas
        edgesNotPassed: list[tuple[int, int]] = [edges[i] for i in range(len(knownEdges)) if knownEdges[i] == False]

        # Utiliza a lista de arestas nao conhecidas para achar vertices pertencentes ao ciclo ja definido
        # que possuem alguma dessas arestas (utiliza set para evitar vertices repetidos)
        vertexWithEdgesNotPassed: set[int] = set([vert for edge in edgesNotPassed for vert in edge if (vert in cicle)])

        # Para se todos os vertices do ciclo somente possuem arestas ja conhecidas
        if (not vertexWithEdgesNotPassed):
            break

        # Escolhe um dos vertices com arestas nao conhecidas
        #   neste casso o primeiro
        vertex = list(vertexWithEdgesNotPassed)[0]

        # Procura ciclos neste vertice
        eulariano, newCicle, knownEdges = busca(graph, vertex, knownEdges, edges)

        # Retorna falso se nao encontrar
        if (not eulariano):
            return (False, [], knownEdges)

        # Caso tenha encontrado outro ciclos 
        #   uni o este novo ciclo com o anterior
        i: int = cicle.index(newCicle[0])
        cicle.pop(i)
        cicle[i:i] = newCicle


    # Retorna True caso for eulariano
    return (True, cicle, knownEdges)


def hierholzer(graph: Grafo) -> tuple[bool, list[int]]:
    # Lista para controle de arestas ja visitadas 
    knownEdges: list[bool] = [False for _ in range(graph.qtdArestas())]

    # Lista de todas as arestas
    edges: list[tuple[int, int]] = graph.arestas()

    # Caso nao exista arestas retorna Falso
    if (not edges):
        return (False, [])

    # Seleciona um vertex que possui uma aresta
    # neste caso, o primeiro
    v = edges[0][0]

    # Busca ciclos eulerianos
    eulariano, cicle, knownEdges = busca(graph, v, knownEdges, edges)

    # Retorna True caso for eulariano e nao existam arestas que nao foram passadas
    return (True, cicle) if ((eulariano) and (False not in knownEdges)) else (False, [])

