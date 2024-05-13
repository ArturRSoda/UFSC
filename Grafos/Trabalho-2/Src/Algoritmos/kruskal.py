from grafo import Grafo

def kruskal(graph: Grafo) -> set[tuple[int, int]]:
    A: set[tuple[int, int]] = set()

    S: list[set[int]] = [set([v]) for v in range(1, graph.qtdVertices()+1)]

    E: list[tuple[int, int]] = sorted(graph.arestas(), key=lambda t : graph.peso(t[0], t[1]))

    for (u, v) in E:
        if (S[u-1] != S[v-1]):
            A.add((u, v))
            x: set[int] = S[u-1].union(S[v-1])

            for y in x:
                S[y-1] = x
    return A
