function ya = valor_polinomio_newton(xn, xp, coef);
	n = length(coef) - 1;

	for (k = 1:length(xn))
		pow = 1;
		ya(k) = coef(1);
		for (i = 1:n)
			pow *= (xn(k) - xp(i));
			ya(k) += coef(i+1)*pow;
		end
	end

end
