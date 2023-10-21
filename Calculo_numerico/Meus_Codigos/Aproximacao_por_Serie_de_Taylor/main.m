%exercicio 1 das dos exercicios da p3


dom = [0 pi/2];

xi = (dom(1) + dom(2))/2;

h = (dom(2) - dom(1))/100;
xp = dom(1):h:dom(2);

%coef = [1/2, 1, 0, -1/3, 0, 1/2160];
coef = [1/2 , -1 , 0 , +2/3 ];

%aproximado
ya = serie_taylor(xp, coef, xi);

%exato
%ye = (sin(xi)).^2;
ye = (cos(xp)).^2;

erro_max = max(abs(ya-ye))

plot(xp, ya)
hold on
p = plot(xp, ye)
waitfor(p)

