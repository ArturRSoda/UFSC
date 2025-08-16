from grafo import Grafo

# Retorna conjunto das arestas de menor peso que ligam todas os vertices
def kruskal(graph: Grafo) -> set[tuple[int, int]]:
    # conjunto que armazena as arestas
    A: set[tuple[int, int]] = set()

    # vetor que represetam os conjuntos que cada vertice estao participando
    S: list[set[int]] = [set([v]) for v in range(1, graph.qtdVertices()+1)]

    # Lista de arestas ordenadas por ordem crescente de peso
    E: list[tuple[int, int]] = sorted(graph.arestas(), key=lambda t : graph.peso(t[0], t[1]))

    # Monta o conjunto das arestas
    # Passa por todas as arestas, em ordem crescente de peso
    for (u, v) in E:
        # Se o conjunto que u pertence for diferente do conjunto que v pertence
        if (S[u-1] != S[v-1]):
            # Adicionamos o vertice (u, v) em A
            A.add((u, v))

            # E unimos os conjutos de u e v
            x: set[int] = S[u-1].union(S[v-1])
            for y in x:
                S[y-1] = x
    return A
