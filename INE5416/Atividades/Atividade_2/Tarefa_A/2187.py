values = [50, 10, 5, 1]
test = 1
while True:
    v = int(input())
    if (not v):
        break

    print("Teste %d" % test)
    test += 1

    arr = list()
    for x in values:
        qtd = v//x
        v -= qtd*x
        arr.append(qtd)

    print(" ".join(list(map(str, arr))))
    print()




