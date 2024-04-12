from sys import argv

class Position:
    def __init__(self, value: int) -> None:

        self.value: int = value
        self.constant: bool = False if (value == -1) else True
        self.upBorderBlock: bool = False
        self.downBorderBlock: bool = False
        self.leftBorderBlock: bool = False
        self.rightBorderBlock: bool = False
        self.visited = False

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

    def inc_ij(self, i: int, j: int) -> tuple[int, int]:
        j += 1
        if (j == self.n):
            j = 0
            i += 1
        return i,j

    def dec_ij(self, i: int, j: int) -> tuple[int, int]:
        j -= 1
        if (j == -1):
            j = self.n-1
            i -= 1
        return i,j

    def solve(self) -> None:
        i: int = 0
        j: int = 0
        v: int = 1

        while (i < self.n):
            self.print_board()
            input()
            if (not self.board[i][j].constant):
                print("teste")
                print(i,j)
                print(v)
                print(self.verify_region(i, j, v, ""))
                if (self.verify_region(i, j, v, "")):
                    self.board[i][j].value = v
                    v = 1
                    i, j = self.inc_ij(i, j)

                else:
                    v += 1
                    if (v == 10):
                        i, j = self.dec_ij(i, j)
                        v = self.board[i][j].value

            else:
                i, j = self.inc_ij(i, j)

    def verify_region(self, i: int, j: int, value: int, back: str) -> bool:
        p: Position = self.board[i][j]

        if (p.value == value):
            return False

        if ((not p.upBorderBlock) and (back != "up")):
            if (not self.verify_region(i-1, j, value, "down")):
                return False

        if ((not p.downBorderBlock) and (back != "down")):
            if (not self.verify_region(i+1, j, value, "up")):
                return False

        if ((not p.leftBorderBlock) and (back != "left")):
            if (not self.verify_region(i, j-1, value, "right")):
                return False

        if ((not p.rightBorderBlock) and (back != "right")):
            if (not self.verify_region(i, j+1, value, "left")):
                return False

        return True

    def verify_up(self, i: int, j: int, value: int) -> bool:
        p: Position = self.board[i][j]
        if (p.value == value):
            return False
        return True if p.upBorderBlock else self.verify_up(i-1, j, value)

    def verify_down(self, i: int, j: int, value: int) -> bool:
        p: Position = self.board[i][j]
        if (p.value == value):
            return False
        return True if p.downBorderBlock else self.verify_up(i+1, j, value)

    def verify_left(self, i: int, j: int, value: int) -> bool:
        p: Position = self.board[i][j]
        if (p.value == value):
            return False
        return True if p.leftBorderBlock else self.verify_up(i, j-1, value)

    def verify_right(self, i: int, j: int, value: int) -> bool:
        p: Position = self.board[i][j]
        if (p.value == value):
            return False
        return True if p.rightBorderBlock else self.verify_up(i, j+1, value)

    def print_board(self) -> None:
        print("|"+"-"*((self.n*2)-1)+"|")
        l1: str = ""
        l2: str = ""
        for i in range(self.n):
            l1 = "|"
            l2 = "|"
            for j in range(self.n):
                p: Position = self.board[i][j]

                l1 += ("%d" % p.value) if (p.value != -1) else "."
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
    board.solve()
    board.print_board()


main()
