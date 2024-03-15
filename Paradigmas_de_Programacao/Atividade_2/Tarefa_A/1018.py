arr = [100, 50, 20, 10, 5, 2, 1]
v = int(input())
print(v)
for x in arr:
    qtd = v // x
    v -= qtd * x
    print("%d nota(s) de R$ %d,00" % (qtd, x))

