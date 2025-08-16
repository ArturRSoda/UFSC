function x = questao_1A()
	a = 0;
	b = pi/2;

	coef = [
		(sqrt(2)*pi)/8,
		(sqrt(2)/2)*(1-pi/4),
		(-sqrt(2)/2)*(1+ pi/8),
		(sqrt(2)/12)*(-3+pi/4),
		(sqrt(2)/48)*(4+pi/4)
		]

	grau = length(coef)-1
	xi = pi/4

	h = 0.01;
	xp = a:h:b;
	ye = xp .* cos(xp);

	ya = valor_polinomio_taylor(xp, coef, xi, grau);

	erro_max = max(abs(ye - ya))

end

