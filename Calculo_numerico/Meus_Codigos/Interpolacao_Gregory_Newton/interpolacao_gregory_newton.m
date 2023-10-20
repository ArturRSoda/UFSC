function ya = interpolacao_gregory_newton(xn, xp, grau, coef)	

	for (k = 1:length(xn))
		pow = 1;
		ya(k) = coef(1);
		for (i = 1:grau)
			pow *= (xn(k) - xp(i));
			ya(k) += coef(i+1)*pow;
		end
	end
end
