function xi = localizacao(f, dominio)
	n_pontos = 1000
	h = (dominio(2) - dominio(1))/n_pontos
	x = dominio(1):h:dominio(2)
	y = f(x)
	plot(x, y)
	grid on
end
