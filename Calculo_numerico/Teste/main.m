
[A, B] = matriz(20);

disp("")

condicionado(A)

disp("")

convergente(A)

disp("")

X = fgauss(A, B)

residuo = max(abs(A*X - B))

disp("")

n = size(A, 1);
operacoes = (4*(n**3) + 9*(n**2) - n - 6)/6

disp("")



