function ya = valor_polinomio(xp, coef, xi);

	for (k = 1:length(xp))
		pow = 1;
		ya(k) = coef(1);
		for (i = 2:length(coef))
			pow *= (xp(k) - xi);
			ya(k) += coef(i)*pow;
		end
	end

end
