dom = [0 pi/2];

grau = 3;
h = (dom(2) - dom(1))/grau;
xp = dom(1):h:dom(2)
yp = sin(xp).^2

hn = (dom(2) - dom(1))/100;
xn = dom(1):hn:dom(2);
yn = sin(xn).^2;

coef = coeficientes_gregory_newton(xp, grau, yp)
ya = interpolacao_gregory_newton(xn, xp, grau, coef);

erro_max = max(abs(ya - yn))


