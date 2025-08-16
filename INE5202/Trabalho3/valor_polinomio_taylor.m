function ya = valor_polinomio_taylor(xp, coef, xi, grau);

	for (k = 1:length(xp))
		pow = 1;
		ya(k) = coef(1);
		for (i = 1:grau)
			pow *= (xp(k) - xi);
			ya(k) += pow*coef(i+1);
		end
	end
end
