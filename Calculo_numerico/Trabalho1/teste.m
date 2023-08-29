A = [3 -1 -1;
	1 3 1;
	1 -1 2]

B = [1;
	5;
	2]

X = questao21b(A, B)
residuo = abs((A*X) - B)

A = [A B];
n = size(A, 1);


X = questao22b(A, B)




