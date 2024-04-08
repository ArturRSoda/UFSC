from grafo import Grafo

def busca(graph: Grafo, v: int, knownEdges: list[bool], edges: list[tuple[int, int]]) -> tuple[bool, list[int], list[bool]]:
    #lista que representa o ciclo, iniciado com o vertex passado
    cicle: list[int] = [v]
    t: int = v

    while True:
        #lista de arestas ligadas a V e ainda nao foram conhecidas
        vEdges: list[tuple[int, int]] = [edges[i] for i in range(len(edges)) if ((v in edges[i]) and (knownEdges[i] == False))]
        #caso a lista for vazia retorna Falso
        if (not vEdges):
            return (False, [], knownEdges)

        #pega a primeira aresta da lista e seta como conhecida
        knownEdges[edges.index(vEdges[0])] = True
        #passa para o proximo vertice
        v = vEdges[0][1] if (vEdges[0][1] != v) else vEdges[0][0]

        #adiciona o proximo vertice a lista
        cicle.append(v)

        #para quando fechar o ciclo
        if (v == t):
            break

    while True:
        #listas de arestas que ainda nao foram conhecidas
        edgesNotPassed: list[tuple[int, int]] = [edges[i] for i in range(len(knownEdges)) if knownEdges[i] == False]
        #vercices ligados a essas arestas ainda nao conhecidas e que pertencem ao ciclo
        vertexWithEdgesNotPassed: set[int] = set([vert for edge in edgesNotPassed for vert in edge if (vert in cicle)])

        #Para quando todas as arestas ja foram conhecidas
        if (not vertexWithEdgesNotPassed):
            break

        #pega um dos vertices ligados a arestas nao conhecidas
        #neste casso o primeiro
        vertex = list(vertexWithEdgesNotPassed)[0]

        #procura ciclos neste vertice
        eulariano, newCicle, knownEdges = busca(graph, vertex, knownEdges, edges)

        #retorna falso se nao encontrar
        if (not eulariano):
            return (False, [], knownEdges)

        #caso tenha encontrado outro ciclo, uni o este novo ciclo com o anterior
        i: int = cicle.index(newCicle[0])
        cicle.pop(i)
        cicle[i:i] = newCicle


    #retorna True caso for eulariano
    return (True, cicle, knownEdges)


def hierholzer(graph: Grafo) -> tuple[bool, list[int]]:
    #lista que representa se aresta foi conhecida
    knownEdges: list[bool] = [False for _ in range(graph.qtdArestas())]

    #lista de todas as arestas
    edges: list[tuple[int, int]] = graph.arestas()

    #caso nao exista arestas retorna Falso
    if (not edges):
        return (False, [])

    #seleciona um vertex que possui uma aresta
    #neste caso, o primeiro
    v = edges[0][0]

    #busca ciclos eularianos
    eulariano, cicle, knownEdges = busca(graph, v, knownEdges, edges)

    #retorna True caso for eulariano e nao existam arestas que nao foram passadas
    return (True, cicle) if ((eulariano) and (False not in knownEdges)) else (False, [])

