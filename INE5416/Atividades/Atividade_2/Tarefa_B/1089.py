while True:
    n = int(input())
    
    if n == 0:
        break
    
    up = False
    down = False
    count = 0
    
    lista = [int(x) for x in input().split()]
    
    if n == 2:
        print(2)
    
    else:
        for c in range(1, n):
            if (lista[c] - lista[c-1]) > 0:
                if (not up):
                    count += 1
                up = True
                down = False
                
            if (lista[c] - lista[c-1]) < 0:
                if (not down):
                    count += 1
                down = True
                up = False
                
        if up:
            if (lista[1] - lista[0]) > 0:
                count += 1
        elif down:
            if (lista[1] - lista[0]) < 0:
                count += 1
                
        print(count)
