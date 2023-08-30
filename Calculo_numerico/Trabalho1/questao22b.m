function [X, op] = questao22b(A, B)
	n = size(A, 1);

	X = zeros(n,1);
	lambda = 1.01

	op = 0;
	diferenca = 1;
	k = 0;
	while ((diferenca > 1e-6) && (k < 100))
		k++;
		X_anterior = X;

		for (i = 1:n)
			somatoria = 0;

			for (j = 1:(i-1))
				if (A(i,j) > 1e-14)
					somatoria += A(i,j) * X(j,1);
					op += 2;
				end
			end

			for (j = (i+1):n)
				if (A(i,j) > 1e-14)
					somatoria += A(i,j) * X(j,1);
					op += 2;
				end
			end

			aux = (B(i,1) - somatoria)/A(i,i);
			op += 2;
			X(i,1) = (1 - lambda)*X_anterior(i,1) + lambda*aux;
			op += 4;
		end

		diferenca = max(abs(X - X_anterior));
	end
end
