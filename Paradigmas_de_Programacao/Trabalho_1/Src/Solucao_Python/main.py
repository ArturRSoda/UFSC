from sys import argv

def main() -> None:
    file: str = argv[1]

    f = open(file, "r")
    print(f.read())

    f.close()

main()
