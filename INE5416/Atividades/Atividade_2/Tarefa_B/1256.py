n = int(input())
for case in range(n):
    m, c = list(map(int, input().split()))

    dict = {}
    for i in range(m):
        dict[i] = []
    
    for x in input().split():
        v = int(x)

        dict[v%m].append(v)

    for key, value in dict.items():
        print("%d -> " % key, end="")
        for x in value:
            print("%d -> " % x, end="")
        print("\\")

    if (case != n-1):
        print()

