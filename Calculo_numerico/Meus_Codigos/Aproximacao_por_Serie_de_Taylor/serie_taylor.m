function ya = serie_taylor(xp, coef, xi)
	n = length(coef) - 1;

	for (k = 1:length(xp))
		pot = 1;
		ya(k) = coef(1);

		for (i = 1:n)
			pot *= (xp(k) - xi);
			ya(k) += coef(i+1) * pot;
		end

	end
end
