def f(i, v):
    if (i == 0):
        return v//2
    elif (i == 1):
        return v//3
    else:
        return v//5

print(min([f(i, v) for i, v in enumerate(list(map(int, input().split())))]))

