from itertools import chain, combinations
from grafo import Grafo

def all_sub_sets(arr: list) -> list[tuple[int]]:
    return list(chain.from_iterable(combinations(arr, r) for r in range(len(arr) + 1)))


def held_karp(graph: Grafo):
    custo: list[dict[tuple[int], float]] = list()
    for k in range(len(graph.adjacencyMatriz)):
        custo.append({(k,): graph.adjacencyMatriz[0][k]})

    allSubSets = all_sub_sets([x for x in range(graph.qtdVertices())])
    for s in range(1, graph.qtdVertices()):
        for subSet in allSubSets:
            if (len(subSet) == s):
                for v in subSet:
                    for u in subSet:
                        if u != v:
                            s = tuple(list(list(subSet)).pop(u))


def main() -> None:
    graph = Grafo()
    graph.ler("./instanciaTeste.net")

    held_karp(graph)

main()
