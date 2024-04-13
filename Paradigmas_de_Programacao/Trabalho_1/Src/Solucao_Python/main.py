from sys import argv

class Position:
    def __init__(self, value: int) -> None:

        self.value: int = value
        self.constant: bool = False if (value == -1) else True
        self.upBorderBlock: bool = False
        self.downBorderBlock: bool = False
        self.leftBorderBlock: bool = False
        self.rightBorderBlock: bool = False
        self.region: int = None

class Board:
    def __init__(self, boardText: list[str], n: int) -> None:
        self.n: int = n
        self.board: list[list[Position]] = self.make_board(boardText)
        self.regions: dict[int, list[int]] = dict()
        self.find_regions()


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

    def solve(self, i: int = 0, j: int = 0) -> bool:
        if (i == self.n):
            return True

        elif (j == self.n):
            return self.solve(i+1, 0)

        elif (self.board[i][j].value != -1):
            return self.solve(i, j+1)

        else:
            for guess in range(1, 10):
                if (self.validate(i, j, guess)):
                    self.board[i][j].value = guess
                    self.regions[self.board[i][j].region].append(guess)
                    self.regions[self.board[i][j].region].remove(-1)

                    if (self.solve(i, j+1)):
                        return True

                    self.board[i][j].value = -1
                    self.regions[self.board[i][j].region].remove(guess)
                    self.regions[self.board[i][j].region].append(-1)

            return False


    def validate(self, i: int, j: int, guess: int) -> bool:
        if (guess in self.regions[self.board[i][j].region]):
            return False

        if (guess > len(self.regions[self.board[i][j].region])):
            return False

        if (i != 0):
            if (self.board[i-1][j].value == guess):
                return False
            
            if (not self.board[i][j].upBorderBlock):
                if (self.board[i-1][j].value <= guess):
                    return False

        if (i != self.n-1):
            if (self.board[i+1][j].value == guess):
                return False

            if (not self.board[i][j].downBorderBlock):
                if (self.board[i+1][j].value >= guess):
                    return False

        if (j != 0):
            if (self.board[i][j-1].value == guess):
                return False

        if (j != self.n-1):
            if (self.board[i][j+1].value == guess):
                return False


        return True

    def find_regions(self) -> None:
        r: int = 1
        indexArr: list[tuple[int, int]] = list()
        valueArr: list[int] = list()
        for i in range(self.n):
            for j in range(self.n):
                p = self.board[i][j]

                if (not p.region):
                    indexArr, valueArr = self.find_region(i, j, r, indexArr, valueArr)

                    self.regions[r] = valueArr.copy()
                    indexArr.clear()
                    valueArr.clear()
                    r += 1

    def find_region(self, i: int, j: int, r: int, indexArr: list[tuple[int, int]], valueArr: list[int]) -> tuple[list[tuple[int, int]], list[int]]:
        p: Position = self.board[i][j]
        
        if ((i, j) not in indexArr):
            self.board[i][j].region = r
            indexArr.append((i,j))
            if ((p.value not in valueArr) or (p.value == -1)):
                valueArr.append(p.value)

        if ((not p.upBorderBlock) and ((i-1, j) not in indexArr)):
            indexArr, valueArr = self.find_region(i-1, j, r, indexArr, valueArr)

        if ((not p.downBorderBlock) and ((i+1, j) not in indexArr)):
            indexArr, valueArr = self.find_region(i+1, j, r, indexArr, valueArr)

        if ((not p.leftBorderBlock) and ((i, j-1) not in indexArr)):
            indexArr, valueArr = self.find_region(i, j-1, r, indexArr, valueArr)

        if ((not p.rightBorderBlock) and ((i+1, j) not in indexArr)):
            indexArr, valueArr = self.find_region(i, j+1, r, indexArr, valueArr)

        return indexArr, valueArr

    def print_regions(self) -> None:
        print("|"+"-"*((self.n*2)-1)+"|")
        l1: str = ""
        l2: str = ""
        for i in range(self.n):
            l1 = "|"
            l2 = "|"
            for j in range(self.n):
                p: Position = self.board[i][j]

                l1 += ("%d" % p.region) if (p.region) else "."
                l1 += "|" if p.rightBorderBlock else " "

                l2 += "-" if p.downBorderBlock else " "
                l2 += "|" if ((j == self.n-1) or (not p.downBorderBlock) or (not self.board[i][j+1].downBorderBlock)) else "-"

            print(l1)
            print(l2)
            
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
    board.print_board()
    print()
    board.print_regions()
    print(board.regions)
    print()
    board.solve()
    print()
    board.print_board()


main()
