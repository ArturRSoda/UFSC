def func(f):
    stk = list()
    for x in f:
        if (x == "("):
            stk.append(x)
        elif (x == ")"):
            if (len(stk) != 0):
                stk.pop()
            else:
                return False
    return True if (len(stk) == 0) else False

while True:
    try:
        print("correct" if func(input()) else "incorrect")
    except Exception:
        break
