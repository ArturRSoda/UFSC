disp("EXERCICIO 3")
[A, B] = matriz()

disp("")

disp("EXERCICIO 3.a)")
condicionado(A)

disp("")

disp("EXERCICIO 3.b)")
disp("Caso ele seja MAL CONDICIONADO, o metodo mais indicado e o iterativo")

disp("")

disp("EXERCICIO 3.c)")
disp("Devemos escolher os maiores valores possiveis para a diagonal principal")

disp("")

disp("EXERCICIO 3.D)")
convergente(A)

disp("")

disp("EXERCICIO 3.G)")
[X, nop] = fgauss(A, B);
X
residuo = sum((A*X) - B)

disp("")
disp("EXERCICIO 3.h)")
n = size(X, 1);
op = (4*(n**3) + 9*(n**2) - n - 6)/6
nop
