function x = questao_1B()
	dom = [0 pi/2];

	grau = 4
	hp = (dom(2) - dom(1))/grau;
	xp = dom(1):hp:dom(2)
	yp = xp .* cos(xp);

	xi = (dom(1) + dom(2))/2;

	hn = (dom(2) - dom(1))/100;
	xn = dom(1):hn:dom(2);
	yn = xn .* cos(xn);

	coef = gregory_newton(xp, yp, grau)
	ya = valor_polinomio_newton(xn, xp, coef);

	erro_max = max(abs(yn - ya))
	
end
