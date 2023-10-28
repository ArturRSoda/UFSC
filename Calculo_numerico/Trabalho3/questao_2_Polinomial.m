function x = questao_2_Polinomial()
	warning off;

	x = [1.2,  1.5, 2,    4,   6,    10,  15]
	y = [0.45, 0.4, 0.33, 0.2, 0.14, 0.1, 0.06]

	xp = min(x):0.01:max(x);

	grau = 4
	coef = ajuste_linear(x, y, grau)
	yp = valor_polinomio_ajuste_linear(xp, coef);

	g = @(coef, x) coef(1) .+ coef(2).*x .+ coef(3).*x.^2 .+ coef(4).*x.^3 .+ coef(5).*x.^4;
	desvio_quadratico = sum((g(coef, x) - y).^2)

	plot(x, y, "r*");
	hold on;
	p = plot(xp, yp);
	title("Questao 2 polinomial grau 4");
	hold off;
end
