from sys import argv

class Position:
    def __init__(self, value: int) -> None:
        self.value: int = value
        self.upBorderBlock: bool = False
        self.downBorderBlock: bool = False
        self.leftBorderBlock: bool = False
        self.rightBorderBlock: bool = False

def make_board(lines: list[str], n: int) -> list[list[Position]]:
    board: list[list[Position]] = list()
    tempList: list[Position] = list()

    for i in range(0, (n*2)-1, 2):
        tempList.clear()
        for j in range(0, (n*2)-1, 2):
            tempList.append(Position(int(lines[i][j]) if (lines[i][j] != "*") else -1))
        board.append(tempList.copy())


    return board


def main() -> None:
    file: str = argv[1]
    n: int = int(argv[2])

    f = open(file, "r")
    text: str = f.read()
    f.close()

    board = make_board(text.split('\n'), n)
    for i in range(n):
        for j in range(n):
            print(board[i][j].value, end=" ")
        print()

main()
