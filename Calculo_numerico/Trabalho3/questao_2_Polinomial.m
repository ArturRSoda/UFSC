function x = questao_2_Polinomial()
	x = [1.2,  1.5, 2,    4,   6,    10,  15]
	y = [0.45, 0.4, 0.33, 0.2, 0.14, 0.1, 0.06];

	xp = min(x):0.01:max(x);

	warning off;
	for (i = 1:6)
		grau = i
		coef = ajuste_polinomial(x, y, grau);
		ya = valor_polinomio_ajuste_polinomial(x, coef);
		desvio_quadratico = sum((ya - y).^2)
		disp("");
	end

	disp("-> Analizando os desvio_quadraticos, e os graficos, vemos que o que apresenta o menor desvio, ou seja, a melhor aproximacao eh o polinomio de grau 4, com um desvio quadratico de 1.6582e-4")

	
end
