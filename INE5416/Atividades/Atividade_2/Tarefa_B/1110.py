while True:
    n = int(input())

    if (n == 0):
        break

    c = list(range(n+1))[1:]

    print("Discarded cards: ", end="")
    while (len(c) > 1):
        if (len(c) > 2):
            print(c.pop(0), end=", ")
        else:
            print(c.pop(0))

        c.append(c.pop(0))

    print("Remaining card: %d" % c[0])

