n, m = map(int, input().split())

lista = [0 for _ in range(n)]
for _ in range(m):
    p, d = map(int, input().split())
    
    z = p-1
    lista[z] = 1
    if d != 0:
        while (z < n):
            lista[z] = 1
            z += d
            
        z = (p-1) - d
        
        while (z >= 0):
            lista[z] = 1
            z -= d
            
for k in lista:
    print(k)
