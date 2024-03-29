from grafo import Grafo

def busca(graph: Grafo, v: int, knownEdges: list[bool], edges: list[tuple[int, int]]) -> tuple[bool, list[int], list[bool]]:
    cicle: list[int] = [v]
    t: int = v

    while True:
        vEdges: list[tuple[int, int]] = [edges[i] for i in range(len(edges)) if ((v in edges[i]) and (knownEdges[i] == False))]
        if (not vEdges):
            return (False, [], knownEdges)

        v = vEdges[0][1] if (vEdges[0][1] != v) else vEdges[0][0]
        knownEdges[edges.index(vEdges[0])] = True

        cicle.append(v)

        if (v == t):
            break

    print("cicle:", cicle)
    edgesNotPassed: list[tuple[int, int]] = [edges[i] for i in range(len(knownEdges)) if knownEdges[i] == False]
    print("edgesNotPassade:", edgesNotPassed)
    for vertex in cicle:
        print(vertex)
        print([edges[i] for i in range(len(edges)) if ((vertex in edges[i]) and (knownEdges[i] == False))])
        
        if (not [edges[i] for i in range(len(edges)) if ((vertex in edges[i]) and (knownEdges[i] == False))]):
            break

        eulariano, newCicle, knownEdges = busca(graph, vertex, knownEdges, edges)

        print(vertex, 1)
        if (not eulariano):
            return (False, [], knownEdges)
        print(vertex, 2)

    return (True, cicle, knownEdges)


def hierholzer(graph: Grafo) -> tuple[bool, list[int]]:
    knownEdges: list[bool] = [False for _ in range(graph.qtdArestas())]
    edges: list[tuple[int, int]] = graph.arestas()

    if (not edges):
        return (False, [])

    v = edges[0][0]

    eulariano, cicle, knownEdges = busca(graph, v, knownEdges, edges)

    return (True, cicle) if ((eulariano) and (False not in knownEdges)) else (False, [])





