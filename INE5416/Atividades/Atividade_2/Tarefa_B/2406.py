def func(arr):
    dict = {
        "{" : "}",
        "[" : "]",
        "(" : ")"
    }
    stk = list()
    for c in arr:
        if (c in "{[("):
            stk.append(dict[c])

        elif (c in "}])"):
            if ((len(stk) == 0) or (stk[-1] != c)):
                return False
            stk.pop()

    return True if (len(stk) == 0) else False

for _ in range(int(input())):
    print("S" if func(input()) else "N")

