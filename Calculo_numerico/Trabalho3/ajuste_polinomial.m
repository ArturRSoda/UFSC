function coef = ajuste_polinomial(x, y, grau)

	for (i = 1:grau+1)
		for (j = 1:grau+1)
			A(i,j) = sum(x .^ (i+j-2));
		end
		B(i, 1) = sum(x.^(i-1) .* y);
	end

	coef = A \ B;

end
