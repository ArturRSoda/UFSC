function X = fgauss_seidel(A, B)

	X = [0;
		0;
		0;]

	diferenca = 1;
	k = 0;
	lambda = 0.8;
	for (i = 1:100)
		k += 1
		X_anterior = X;

		X(1) = (B(1,1) - (A(1,2)*X(2) + A(1,3)*X(3)))/A(1,1);
		X(2) = (B(2,1) - (A(2,1)*X(2) + A(2,3)*X(3)))/A(2,2);
		X(3) = (B(3,1) - (A(3,1)*X(1) + A(3,2)*X(2)))/A(3,3);

		% X(i) = (1 - lambda)*X_anterior(i) + lambda*X(i)
		%X(1) = (1 - lambda)*X_anterior(1) + lambda * ((B(1,1) - (A(1,2)*X(2) + A(1,3)*X(3)))/A(1,1));
		%X(2) = (1 - lambda)*X_anterior(2) + lambda * ((B(2,1) - (A(2,1)*X(2) + A(2,3)*X(3)))/A(2,2));
		%X(3) = (1 - lambda)*X_anterior(3) + lambda * ((B(3,1) - (A(3,1)*X(1) + A(3,2)*X(2)))/A(3,3));
		X
		diferenca = max(abs(X - X_anterior))
	end

end
