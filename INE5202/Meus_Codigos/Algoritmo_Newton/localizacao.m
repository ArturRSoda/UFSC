function xi = localizacao(f, dominio)
	n_intervalos = 100;
	h = (dominio(2) - dominio(1))/n_intervalos;
	x = dominio(1):h:dominio(2);
	y = f(x);
	limite = 0.1/h;

	i_raiz = 0;
	for (i = 1:(length(x)-1))
		if (((y(i) * y(i+1)) <= 0) && ((abs(y(i)) + abs(y(i+1)) < limite)))
			i_raiz++;
			xi(i_raiz) = (x(i) + x(i+1)) * 0.5;
		end
	end
end
