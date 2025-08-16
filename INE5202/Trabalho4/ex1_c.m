function x = ex1_c()
	disp("-> Os m=3 nos t, sao as raizes do polinomio ortogonal de legendre de grau m=3 no intervalor [-1, 1]:");
	disp("Pm+1(x) = ((2m+1) * X * Pm(x) - m*Pm-1(x))/(m+1)");
	disp("");
	disp("assim, para m = 3:");
	disp("	m=0 -> P0(X) = 1");
	disp("	m=1 -> P1(X) = x");
	disp("	m=2 -> P2(X) = (3/2)*x^2 - 1/2");
	disp("	m=3 -> P3(X) = (5/2)*x^3 - (3/2)*x");
	disp("");
	disp("Dessa forma, neste caso os m=3 t serao as 3 raizes de P3(x)=0");
	disp("Obtendo:");
	disp("	t(3,1) = -sqrt(3/5)");
	disp("	t(3,2) = 0");
	disp("	t(3,3) = sqrt(3/5)");


end
