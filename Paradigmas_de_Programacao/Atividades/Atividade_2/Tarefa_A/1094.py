coelho = rato = sapo = total = 0
p_coelho = p_rato = p_sapo = 0
for _ in range(int(input())):
    num, animal = input().split()
    num = int(num)
    
    total += num
    
    if animal == "C":
        coelho += num
        
    elif animal == "R":
        rato += num
        
    else:
        sapo += num
        
    p_coelho = coelho / total * 100
    p_rato = rato / total * 100
    p_sapo  = sapo / total * 100
    
print("Total: %d cobaias" % total)
print("Total de coelhos: %d" % coelho)
print("Total de ratos: %d" % rato)
print("Total de sapos: %d" % sapo)
print("Percentual de coelhos: %.2f %%" % p_coelho)
print("Percentual de ratos: %.2f %%" % p_rato)
print("Percentual de sapos: %.2f %%" % p_sapo)

