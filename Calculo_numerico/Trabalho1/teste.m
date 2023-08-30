function X = teste(A, B)

	n = size(A, 1);
	X = zeros(n, 1);

	for (i = 1:n)
		l = 1;
		count = 1;
		for (j = 1:n)
			if ((abs(A(i,j)) > 1e-14) && (i != j))
				nao_nulo(i,l) = j;
				l++;
			end
		end
		count_nn(i, count) = l-1;
		count++;
	end

	nn_i = size(nao_nulo, 1);

	lambda = 1;
	k = 0;
		diferenca = 1;

	l = 1;
	while ((diferenca > 1e-10) && (k < 100))
		k++;	
		X_anterior = X;

		for (i = 1:nn_i)
			c = 1:count_nn(i)

			for (j = 1:

		end


		diferenca = 1e-11;

	end

	

end
