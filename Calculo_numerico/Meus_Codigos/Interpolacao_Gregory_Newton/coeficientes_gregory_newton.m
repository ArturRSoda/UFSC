function coef = coeficientes_gregory_newton(xp, grau, yp)
	
	for (i = 1:grau)
		delta_y(i, 1) = (yp(i+1) - yp(i))/(xp(i+1) - xp(i));
	end

	for (k = 2:grau)
		for (i = 1:(grau+1-k))
			delta_y(i, k) = (delta_y(i+1, k-1) - delta_y(i, k-1))/(xp(i+k) - xp(i));
		end
	end

	coef = [yp(1), delta_y(1, 1:grau)];

end
