function x = metodo_newton(f, dominio)
	%derivada_f = @(x) log(x) + 1
	xi = localizacao(f, dominio);
	delta_x = 1;
	k = 0;


	for (i = 1:length(xi))
		while ((abs(delta_x) > 1e-15) && (k < 100))
			k += 1;
			derivada_f = (f(xi(i) + delta_x) - f(xi(i)))/delta_x;
			delta_x = -f(xi(i))/derivada_f;
			x(i) = xi(i) + delta_x;
			xi(i) = x(i);
		end
	end
end

