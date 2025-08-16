disp("Questao 0")

disp("Questao 0.a)");
[T, R, D, B] = cria_vetores()

n = size(T, 1);

disp("Questao 0.b)");
X = transpose(Sistema_Tridiagonal(T, R, D, B))


A = zeros(n,n);
for (i = 1:n)
	A(i,i) = R(i);

	if (i != 1)
		A(i,i-1) = T(i);
	end

	if (i != n)
		A(i,i+1) = D(i);
	end
end

residuo = abs(max(A*X - B(:,1)))

disp("questao 0.c)");
operacoes = 8*n - 7
