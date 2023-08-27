function x = convergente(A);
	n = size(A, 1);

	soma = 0;
	for (j = 2:n)
		soma += abs(A(1,j));
	end 

	printf("|%d| >= |%d| ", A(1,1), soma)

	if (A(1,1) >= soma)
		printf("V\n")
	else
		printf("F\n")
	end

	for (i = 2:(n-1))
		soma = 0;
		for (j = 1:(i-1))
			soma += A(i,j);
		end
		for (j = (i+1):n)
			soma += A(i,j);
		end

		printf("|%d| >= |%d| ", A(i,i), soma)

		if (A(i,i) >= soma)
			printf("V\n")
		else
			printf("F\n")
		end
	end

	soma = 0;
	for (j = 1:(n-1))
		soma += abs(A(1,j));
	end 

	printf("|%d| >= |%d| ", A(n,n), soma)

	if (A(n,n) >= soma)
		printf("V\n")
	else
		printf("F\n")
	end


	end

