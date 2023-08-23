A = [0 1 1;
	1 1 4;
	2 3 2]

B = [8;
	15;
	9]

X = questao21b(A, B)
residuo = abs((A*X) - B)

A = [A B];
n = size(A, 1);

for (i = 1:n)
	[m,po] = max(a((i:n),i))
	A([i,po],:) = A([po,i],:);
end




