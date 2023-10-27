function x = questao_1A()
	dom = [0 pi/2];

	%coef = [
		%	(pi*sqrt(2))/8,
			%(sqrt(2)*(4-pi))/8,
			%-(sqrt(2)*(8+pi))/16,
			%-(sqrt(2)*(12-pi))/96,
			%(sqrt(2)*(16+pi))/2304
			%]
			%(sqrt(2)*(20-pi))/276480,
		%	-(sqrt(2)*(24+pi))/24883200,
	%		-(sqrt(2)*(28-pi))/8026324992000
%		]
	coef = [
		(sqrt(2)/2)*(1 - pi/4),
		(sqrt(2)/4)*(-2 - pi/4),
		(sqrt(2)/12)*(-3 + pi/4),
		(sqrt(2)/48)*(4+pi/4),
		(sqrt(2)/240)*(5 - pi/4),
		(sqrt(2)/1440)*(-6-pi/4),
		]

	grau = length(coef)-1

	xi = (dom(1) + dom(2))/2

	h = (dom(2) - dom(1))/100;
	xp = dom(1):h:dom(2);

	ye = xp .* cos(xp);
	ya = valor_polinomio_taylor(xp, coef, xi);

	erro_max = max(abs(ya - ye))
end

