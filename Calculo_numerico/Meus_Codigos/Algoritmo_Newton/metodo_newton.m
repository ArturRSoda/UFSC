function x = metodo_newton(f, dominio)
	%derivada_f = @(x) log(x) + 1
	xi = localizacao(f, dominio)
	delta_x = 1
	k = 0
	while ((abs(delta_x) > 1e-15) && (k < 100))
		k += 1
		derivada_f = (f(xi + delta_x) - f(xi))/delta_x
		delta_x = -f(xi)/derivada_f
		x = xi + delta_x
		xi = x;
	end
end

