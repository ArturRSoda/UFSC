def p1(txt):
    return "".join(list(chr(ord(c) + 3) if (c.isalpha()) else c for c in txt))

def p2(txt):
    return txt[::-1]

def p3(txt):
    return "".join(list(chr(ord(txt[i]) - 1) if (i >= len(txt)//2) else txt[i] for i in range(len(txt))))

print("\n".join(list(p3(p2(p1(input()))) for _ in range(int(input())))))
