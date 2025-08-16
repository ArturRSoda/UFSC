dict = {
    0 : "A",
    1 : "B",
    2 : "C",
    3 : "D",
    4 : "E"
}
    
while True:
    n = int(input())
    if (not n):
        break
    for _ in range(n):
        opt = list(1 if (x <= 127) else 0 for x in list(map(int, input().split())))
        u = opt.count(1)
        print("*" if (u != 1) else dict[opt.index(1)])


