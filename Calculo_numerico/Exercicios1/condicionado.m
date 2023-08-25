function X = condicionado(A)

	n = size(A,1);

	soma_T = 0;

	for (i = 1:n)
		soma_L = 0;
		for (j = 1:n)
			soma_L += A(i,j)**2;
		end
		soma_T += sqrt(soma_L);
	end

	X = soma_T;

end
