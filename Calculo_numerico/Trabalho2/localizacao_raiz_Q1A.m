function xi = localizacao_raiz_Q1A(f, subdominio)
	n_raiz = 1000000;
	h = (subdominio(2) - subdominio(1))/n_raiz;
	x = subdominio(1):h:subdominio(2);
	y = f(x);
	limite = 0.1/h;

	i_raiz = 0;
	for (i = 1:(length(x)-1))
		if (((y(i) * y(i+1)) <= 0) && ((abs(y(i)) + abs(y(i+1))) < limite))
			i_raiz++;
			xi(i_raiz) = (y(i) + y(i+1)) * 0.5;
		end
	end
end
