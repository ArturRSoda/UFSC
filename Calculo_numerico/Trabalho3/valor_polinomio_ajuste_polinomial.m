function ya = valor_polinomio_ajuste_polinomial(xp, coef)
	grau = length(coef) - 1;

	for (k = 1:length(xp))
		pow = 1;
		ya(k) = coef(1);
		for (i = 1:grau)
			pow *= xp(k);
			ya(k) += pow*coef(i+1);
		end
	end
end
