disp("EXERCICIO 3")
[A, B] = matriz(20)

disp("EXERCICIO 3.A)")
det_A = det(A)
X = condicionado(A)

m_det_A = abs(det_A)/X
disp("SISTEMA E CONDICIONADO POIS ||det(A)|| >> 1")

disp("")

disp("EXERCICIO 3.B")
disp("Se o a matriz fosse mal condicionado, o sistema mais indicado seria o iterativo")

disp("")

disp("EXERCICIO 3.C")
disp("Escolher as linhas mais indicadas, aquelas com os maiores A(i,i)")

disp("")

disp("EXERCICIO 3.D")
convergente(A)
disp("A E CONVERGENTE, pois os modulos de A(i,i) sao maiores que os modulos das somas dos restantes valores da linha")

disp("")

disp("EXERCICIO 3.F")
X = fgauss(A, B)
n = size(X, 1)
residuo = sum((A*X) - B)
Operacoes_realizadas = (4*(n**3) + 9*(n**2) - n - 6)/6

