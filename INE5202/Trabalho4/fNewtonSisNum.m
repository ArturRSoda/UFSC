function X = fNewtonSisNum(n,Xi)

	warning off;
	tol = 1e-20;
	criterio = 1;
	contador = 0;

	for (i = 1:n)
		Dx(i) = 1e-15;
	end

	while (criterio>tol && contador<50)

		contador++;
		Yi = G(Xi); 
		Xj = Xi;

		for (j = 1:n)
			Xj(j)=Xi(j).+Dx(j);
			A(:,j)=(G(Xj) .- Yi)/Dx(j); 
			Xj=Xi;
		end

		B(:,1) = -Yi;
		Dx = A\B;
		X = Xi+Dx;
		Xi = X;
		criterio = min(abs(Dx));
	end
	contador
	criterio
end
