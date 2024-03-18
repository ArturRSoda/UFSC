
class Vertex:
    "Classe para os vertices do grafo"

    def __init__(self, i: int, lb: str) -> None:
        self.__id = i
        self.__label = lb
        self.__degree = 0
        self.__neighbors = list()

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
    "Implementacao de Grafo nao-dirigido e ponderado"

    def __init__(self) -> None:
        self.__adjacencyMatriz = list()
        self.__vertexes = list()

        self.__qtdVertex = 0
        self.__qtdEdge = 0


    def qtdVertices(self) -> int:
        return self.__qtdVertex


    def qtdArestas(self) -> int:
        return self.__qtdEdge


    def grau(self, v) -> int:
        return self.__vertexes[v-1].degree


    def rotulo(self, v) -> str:
        return self.__vertexes[v-1].label


    def vizinhos(self, v) -> list:
        return self.__vertexes[v-1].neighbors


    def haAresta(self, u, v) -> bool:
        return False if (self.__adjacencyMatriz[u-1][v-1] == float("inf")) else True


    def peso(self, u, v) -> float:
        return self.__adjacencyMatriz[u-1][v-1]


    def ler(self, filePath: str) -> None:
        f = open(filePath, "r")
        lines = f.read().split("\n")
        f.close

        self.__qtdVertex = int(lines[0].split()[1])

        for i in range(1, self.__qtdVertex+1):
            line = lines[i].replace('"', "").split()
            id = int(line[0])
            label = " ".join(line[1:])
            self.__vertexes.append(Vertex(id, label))

        self.__adjacencyMatriz = [[float("inf") for _ in range(self.__qtdVertex)] for _ in range(self.__qtdVertex)]
        for i in range(self.__qtdVertex+2, len(lines)-1):
            line = lines[i].split()
            id1 = int(line[0])
            id2 = int(line[1])
            weight = float(line[2])

            v1 = self.__vertexes[id1-1]
            v2 = self.__vertexes[id2-1]

            v1.degree += 1
            v2.degree += 1

            v1.neighbors.append(v2)
            v2.neighbors.append(v1)

            self.__qtdEdge += 1
            self.__adjacencyMatriz[id1-1][id2-1] = weight

            if (id1 == 1) and (id2 == 135):
                print("aki")
                print(self.__adjacencyMatriz[id1-1][id2-1])

