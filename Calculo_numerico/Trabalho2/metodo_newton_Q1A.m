function x = metodo_newton_Q1A(f, chute, subdominio)
	xi = chute;
	delta_x = 1;
	k = 0;
	while ((abs(delta_x) > 1e-15) && (k < 100))
		k++;
		df = (f(xi + delta_x) - f(xi))/delta_x;
		delta_x = -f(xi)/df;
		x = xi + delta_x;
		xi = x;
	end
end
