% aproxime a função f(x) = cos²(x) no intervalo [0, pi/2] com erro max < 5e-2 (0,05) pela série de Taylor
a = 0 ; b = pi/2; % intervalo

% f(x) = f(xi) + (f'(xi)/1!) (x-xi) +  (f''(xi)/2!) (x-xi)² + (f'''(xi)/3!) (x-xi)³ + ... + (f^(n) (xi)/n!) (x-xi)^n + ...
% f(x) = c(1)  + c(2)        (x-xi) +  c(3)         (x-xi)² + c(4)          (x-xi)³ + ... + c(n+1)          (x-xi)^n 

% em nosso exemplo, n = 3
% xi  = (0+pi/2)/2 = pi/4
xi = pi/4;

% calculamos manualmente todos os coeficientes c:
% coeficiente: f(xi) ,  f'(xi)/1! , f''(xi)/2! ...
c = [1/2 , -1 , 0 , +2/3 ];
c = [
		(sqrt(2)/2)*(1 - pi/4),
		(sqrt(2)/4)*(-2 - pi/4),
		(sqrt(2)/12)*(-3 + pi/4),
		(sqrt(2)/48)*(4+pi/4),
		(sqrt(2)/240)*(5 - pi/4),
		(sqrt(2)/1440)*(-6-pi/4)
		]


% para fazer os gráficos, vamos criar vários valores de x e y
h = (b-a)/100;
xp = [a : h : b];

ya = valor_polinomio(xp, c , xi); % nossa função aproximada
ye = (cos(xp)).^2; % função nativa para exato
ye = xp .* cos(xp);
erro = abs(ya-ye); 
erro_max = max(erro)

%plot(xp, ya, "r;-;", xp, ye, "b; -;")
p = plot(xp, erro, "r;-;")
grid on
waitfor(p);

% diminuir erro -> aumenta número de termos 
% erro maximo ->  nas extremidades do intervalo da aproximação
