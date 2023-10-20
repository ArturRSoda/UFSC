A = [1 -1 0 0 0;
	 1 1 -1 0 0;
	 0 1 -1 1 0;
	 0 0 -1 1 1;
	 0 0 0 -1 2]

B = [0; 1; 2; -1; -2]

n = size(A, 1);
T = zeros(n, 1);
R = zeros(n, 1);
D = zeros(n, 1);

for (i = 1:n)
	if (i == 1)
		T(i) = NaN;
	else
		T(i) = A(i,(i-1));
	end

	if (i == n)
		D(i) = NaN;
	else
		D(i) = A(i,(i+1));
	end

	R(i) = A(i,i);
end


X = tridiagonal(T, R, D, B)
