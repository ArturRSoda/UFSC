stk = list()
min = 0
for _ in range(int(input())):
    opr = input().split()
    if (opr[0] == "PUSH"):
        v = int(opr[1])

        if (len(stk) == 0):
            min = v
            stk.append(v)

        elif (v < min):
            stk.append(2*v - min)
            min = v

        else:
            stk.append(v)

    elif (len(stk)):
        if (opr[0] == "POP"):
            t = stk.pop()
            if (t < min):
                min = 2*min - t

        elif (opr[0] == "MIN"):
            print(min)
    else:
        print("EMPTY")


