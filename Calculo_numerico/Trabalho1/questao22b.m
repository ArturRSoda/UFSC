function X = questao22b(A, B)
	n = size(A, 1);

	X = zeros(n,1);
	lambda = 1

	diferenca = 1;
	k = 0;
	while ((diferenca > 1e-6) && (k < 100))
		k++;
		X_anterior = X;

		for (i = 1:n)
			somatoria = 0;

			for (j = 1:(i-1))
				somatoria += A(i,j) * X(j,1);
			end
			for (j = (i+1):n)
				somatoria += A(i,j) * X(j,1);
			end

			aux = (B(i,1) - somatoria)/A(i,i);
			X(i,1) = (1 - lambda)*X_anterior(i,1) + lambda*aux;
		end

		diferenca = max(abs(X - X_anterior));
	end

end
