function ya = valor_polinomio_newton(xe, xp, coef, grau);
	
	for (k = 1:length(xe))
		pow = 1;
		ya(k) = coef(1);
		for (i = 1:grau)
			pow *= (xe(k) - xp(i));
			ya(k) += pow*coef(i+1);
		end
	end



end
