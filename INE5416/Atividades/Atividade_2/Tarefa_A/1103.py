while True:
    h1, m1, h2, m2 = map(int, input().split())

    if ((not h1) and (not m1) and (not h2) and (not m2)):
        break

    print((((h2+24)*60)+m2)-((h1*60)+m1) if ((h1 > h2) or ((h1 == h2) and (m1 > m2))) else ((h2*60)+m2)-((h1*60)+m1))

