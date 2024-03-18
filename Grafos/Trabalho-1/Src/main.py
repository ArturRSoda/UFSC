from sys import argv, exc_info
from grafo import Grafo

def main() -> None:
    if (len(argv) != 2):
        print("Error: Passar apenas o nome do arquivo de instancia como argumento")
        return

    fileName: str = argv[1]
    grafo: Grafo = Grafo()

    grafo.ler("./Instancias/"+fileName)

    print(grafo.qtdVertices())
    print(grafo.grau(1))
    print(grafo.rotulo(1))
    print([neighbor.label for neighbor in grafo.vizinhos(1)])

    print(grafo.haAresta(1, 2))
    print(grafo.peso(1, 2))

main()


