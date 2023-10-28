function x = questao_2_nao_linear()
	x = [1.2,  1.5, 2,    4,   6,    10,  15]
	y = [0.45, 0.4, 0.33, 0.2, 0.14, 0.1, 0.06]

	g = @(c, x) c(1)./(c(2)+c(3).*(x).^2)

	f1 = @(c, x, y) sum( (g(c, x) - y) ./ (c(2) + c(3).*(x).^2));
	f2 = @(c, x, y) sum( (g(c, x) - y) ./ ((c(2) + c(3).*(x).^2).^2));
	f3 = @(c, x, y) sum( (g(c, x) - y) .* ( (x.^2)/((c(2) + c(3).*(x).^2).^2)));


	ci = [1; -1; 1];
	c = newtonsis3(ci, x, y, f1, f2, f3)

	h = 0.01;
	xp = min(x) : h : max(x);
	yp = g(c, xp);


	Desvio_quadratico = sum((g(c, x) - y).^2)

	plot(x, y, "r*");
	hold on;
	plot(xp, yp);
	title("Questao 2 nao linear");
	hold off;
end

