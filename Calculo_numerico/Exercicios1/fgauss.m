function [X, op] = fgauss(A, B);

	n = size(A, 1);

	op = 0;

	A = [A B];

	for (k = 1:(n-1))
		for (i = (k+1):n)
			aux = A(i,k)/A(k,k);
			op += 1;
			A(i,k) = 0;

			for (j = (k+1):(n+1))
				A(i,j) = A(i,j) - aux*A(k,j);
				op += 2;
			end
		end
	end

	X(n,1) = A(n,(n+1))/A(n,n);
	op += 1;

	for (i = (n-1):-1:1)
		somatoria = 0;

		for (j = (i+1):n)
			somatoria += A(i,j)*(X(j,1));
			op += 2;
		end

		X(i,1) = (A(i,(n+1)) - somatoria)/A(i,i);
		op += 2;

	end

end
