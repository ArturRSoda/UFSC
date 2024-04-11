from sys import argv

class Position:
    def __init__(self, value: int) -> None:
        self.value: int = value
        self.upBorderBlock: bool = False
        self.downBorderBlock: bool = False
        self.leftBorderBlock: bool = False
        self.rightBorderBlock: bool = False

class Board:
    def __init__(self, boardText: list[str], n: int) -> None:
        self.n = n
        self.board = self.make_board(boardText)

    def make_board(self, lines: list[str]) -> list[list[Position]]:
        board: list[list[Position]] = list()
        tempList: list[Position] = list()

        for i in range(1, self.n*2, 2):
            tempList.clear()
            for j in range(1, self.n*2, 2):
                p: Position = Position(int(lines[i][j]) if (lines[i][j] != "*") else -1)

                p.upBorderBlock = True if (lines[i-1][j] == "-") else False
                p.downBorderBlock = True if (lines[i+1][j] == "-") else False
                p.leftBorderBlock = True if (lines[i][j-1] == "|") else False
                p.rightBorderBlock = True if (lines[i][j+1] == "|") else False

                tempList.append(p)
            board.append(tempList.copy())
        return board

    def print_board(self) -> None:
        print("|"+"-"*((self.n*2)-1)+"|")
        l1: str = ""
        l2: str = ""
        for i in range(self.n):
            l1 = "|"
            l2 = "|"
            for j in range(self.n):
                p: Position = self.board[i][j]

                l1 += ("%d" % p.value) if (p.value != -1) else "*"
                l1 += "|" if p.rightBorderBlock else " "

                l2 += "-" if p.downBorderBlock else " "
                l2 += "|" if ((j == self.n-1) or (not p.downBorderBlock) or (not self.board[i][j+1].downBorderBlock)) else "-"

            print(l1)
            print(l2)

def main() -> None:
    file: str = argv[1]
    n: int = int(argv[2])

    f = open(file, "r")
    text: str = f.read()
    f.close()

    board: Board = Board(text.split('\n'), n)
    board.print_board()


main()
