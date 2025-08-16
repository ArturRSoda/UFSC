while True:
    k = int(input())
    if (k == 0):
        break

    n, m = list(map(int, input().split()))

    for _ in range(k):
        x, y = list(map(int, input().split()))

        d = str()

        if ((x == n) or (y == m)):
            d = "divisa"
        else:
            d = "N" if (y > m) else "S"
            d += "E" if (x > n) else "O"

        print(d)
            
