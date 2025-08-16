function a = coeficientes_ajuste_polinomial(x, y, grau)
	
	for (i = 1:(grau + 1))
		for (j = 1:(grau + 1))
			X(i,j) = sum(x .^ (i+j-2));
		end
		Y(i, 1) = sum((x.^(i-1) .* y));
	end

	a = X \ Y;

end
