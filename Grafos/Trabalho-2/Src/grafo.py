class Vertex:
    "Classe para os vertices do grafo"

    def __init__(self, i: int, lb: str) -> None:
        self.__id: int = i
        self.__label: str = lb
        self.__degree: int = 0
        self.__neighbors: list[int] = list()

    @property
    def id(self) -> int:
        return self.__id

    @property
    def label(self) -> str:
        return self.__label

    @property
    def degree(self) -> int:
        return self.__degree

    @property
    def neighbors(self) -> list:
        return self.__neighbors

    @degree.setter
    def degree(self, v: int) -> None:
        self.__degree = v


class Grafo:
    def __init__(self, dirigido: bool = False) -> None:
        self.__adjacencyMatriz: list[list[float]] = list()
        self.__vertexes: list[Vertex] = list()

        self.__dirigido: bool = dirigido
        self.__filePath: str = str()

        self.__qtdVertex: int = 0
        self.__qtdEdge: int = 0


    def qtdVertices(self) -> int:
        return self.__qtdVertex


    def qtdArestas(self) -> int:
        return self.__qtdEdge


    def grau(self, v: int) -> int:
        return self.__vertexes[v-1].degree


    def rotulo(self, v: int) -> str:
        return self.__vertexes[v-1].label


    def vizinhos(self, v: int) -> list:
        return self.__vertexes[v-1].neighbors


    def haAresta(self, u: int, v: int) -> bool:
        return False if (self.__adjacencyMatriz[u-1][v-1] == float("inf")) else True


    def peso(self, u: int, v: int) -> float:
        return self.__adjacencyMatriz[u-1][v-1]


    def arestas(self) -> list[tuple[int, int]]:
        edges: list[tuple[int, int]] = list()
        for vertex in range(1, self.qtdVertices()+1):
            for n in self.vizinhos(vertex):
                if ((n, vertex) not in edges):
                    edges.append((vertex, n))
        return edges


    def ler(self, filePath: str) -> None:
        self.__filePath = filePath
        f = open(filePath, "r")
        lines: list[str] = f.read().split("\n")
        f.close

        self.__qtdVertex = int(lines[0].split()[1])

        self.__vertexes = [Vertex(int(line[0]), " ".join(line[1:])) for line in [lines[i].replace('"', "").split() for i in range(1, self.__qtdVertex+1)]]

        self.__adjacencyMatriz = [[float("inf") for _ in range(self.__qtdVertex)] for _ in range(self.__qtdVertex)]
        for i in range(self.__qtdVertex+2, len(lines)):
            line: list[str] = lines[i].split()
            if (line):
                id1: int = int(line[0])
                id2: int = int(line[1])
                weight: float = float(line[2])

                v1: Vertex = self.__vertexes[id1-1]
                v2: Vertex = self.__vertexes[id2-1]

                v1.degree += 1
                v2.degree += 1

                v1.neighbors.append(v2.id)
                self.__adjacencyMatriz[id1-1][id2-1] = weight

                if (not self.__dirigido):
                    self.__adjacencyMatriz[id2-1][id1-1] = weight
                    v2.neighbors.append(v1.id)

                self.__qtdEdge += 1

    def getGrafoTransposto(self):
        transposedGraph: Grafo = Grafo()

        f = open(self.filePath, "r")
        lines: list[str] = f.read().split("\n")
        f.close

        transposedGraph.qtdVertex = int(lines[0].split()[1])

        transposedGraph.vertexes = [Vertex(int(line[0]), " ".join(line[1:])) for line in [lines[i].replace('"', "").split() for i in range(1, transposedGraph.qtdVertex+1)]]

        transposedGraph.adjacencyMatriz = [[float("inf") for _ in range(transposedGraph.qtdVertex)] for _ in range(transposedGraph.qtdVertex)]
        for i in range(transposedGraph.qtdVertex+2, len(lines)):
            line: list[str] = lines[i].split()
            if (line):
                id1: int = int(line[1])
                id2: int = int(line[0])
                weight: float = float(line[2])

                v1: Vertex = transposedGraph.vertexes[id1-1]
                v2: Vertex = transposedGraph.vertexes[id2-1]

                v1.degree += 1
                v2.degree += 1

                v1.neighbors.append(v2.id)
                transposedGraph.adjacencyMatriz[id1-1][id2-1] = weight

                transposedGraph.qtdEdge += 1

        return transposedGraph

    @property
    def filePath(self) -> str:
        return self.__filePath

    @property
    def adjacencyMatriz(self) -> list[list[float]]:
        return self.__adjacencyMatriz

    @adjacencyMatriz.setter
    def adjacencyMatriz(self, v: list[list[float]]) -> None:
        self.__adjacencyMatriz = v

    @property
    def vertexes(self) -> list[Vertex]:
        return self.__vertexes

    @vertexes.setter
    def vertexes(self, v: list[Vertex]) -> None:
        self.__vertexes = v

    @property
    def qtdVertex(self) -> int:
        return self.__qtdVertex

    @qtdVertex.setter
    def qtdVertex(self, v: int) -> None:
        self.__qtdVertex = v

    @property
    def qtdEdge(self) -> int:
        return self.__qtdEdge

    @qtdEdge.setter
    def qtdEdge(self, v: int) -> None:
        self.__qtdEdge = v


