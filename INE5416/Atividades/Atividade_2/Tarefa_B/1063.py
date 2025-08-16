while True:
    n = int(input())

    if (n == 0):
        break

    a = list(input().split())
    b = list(input().split())

    arr = list()
    j = 0


    for i in range(n):
        arr.append(a[i])
        print("I", end="")

        while ((len(arr) != 0) and (b[j] == arr[-1])):
            j+=1
            arr.pop()
            print("R", end="")

    print("" if (len(arr) == 0) else " impossible")



