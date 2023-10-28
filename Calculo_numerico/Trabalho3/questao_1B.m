function x = questao_1B()
	a = 0;
	b = pi/2;

	grau = 4
	hp = (b - a)/grau;
	xp = a:hp:b;
	yp = xp .* cos(xp);

	he = 0.01;
	xe = a:he:b;
	ye = xe .* cos(xe);

	coef = gregory_newton(xp, yp, grau)
	ya = valor_polinomio_newton(xe, xp, coef, grau);

	erro_max = max(abs(ye - ya))
	
end
