
while True:
    n = int(input())

    if (n == 0):
        break

    while True:
        v = list(map(int, input().split()))

        if (v == [0]):
            break

        arr = list()
        j = 0

        for i in range(1,n+1):
            arr.append(i)

            while ((len(arr) != 0) and (v[j] == arr[-1])):
                j += 1
                arr.pop()

        print("Yes" if (len(arr) == 0) else "No")
    print()

