function ya = valor_polinomio_taylor(xp, coef, xi);
	n = length(coef) - 1;

	for (k = 1:length(xp))
		pow = 1;
		ya(k) = coef(1);
		for (i = 1:n)
			pow *= (xp(k) - xi);
			ya(k) += coef(i+1)*pow;
		end
	end

end
