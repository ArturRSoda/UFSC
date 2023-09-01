function X = fgauss(A, B)
	n = size(A, 1);
	A = [A B]
	X = zeros(n, 1);


	for (k = 1:(n-1))
		for (i = (k+1):n)
			aux = A(i,k)/A(k,k);
			A(i,k) = 0;
			for (j = (k+1):(n+1))
				A(i,j) = A(i,j) - aux*A(k,j);
			end
		end
	end

	A

	X(n,1) = A(n,(n+1))/A(n,n);

	for (i = (n-1):-1:1)
		somatoria = 0;
		for (j = (i+1):n)
			somatoria += A(i,j)*X(j,1);
		end
		X(i,1) = (A(i,(n+1)) - somatoria)/A(i,i);
	end

end
