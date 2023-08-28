% Metodo iterativo de Gauss-Seidel
format long

A = [3 -1 -1; 1 3 1; 1 -1 2]
B = [1; 5; 2]

"Gauss-Seidel especifico exemplo 2.10"
X = fgauss_seidel_ex_2_10(A, B)
res = max(abs(A*X-B))
"Gauss-Seidel Generico para matriz A e B (seleciona os coeficentes nao nulos um unica vez)"
X = fgauss_seidel(A, B)
res = max(abs(A*X-B))