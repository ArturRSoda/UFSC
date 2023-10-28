%Dados os m=9 pontos experimentais
x = [0.2,   0.5,    1,      2,      4,      6,      10,     15]
y = [0.5,   0.3,    0.1,    -0.4,   -0.9,   -1.4,   -2,     -2.8]

% Determine uma funcao aproximadora g(x) que represente os pontos m experimentais
% acima

g = @(c, x) c(1) + c(2) .* x.^(c(3));

% f1 = @(c, x, y) sum(c(1) + c(2) .* x.^c(3) - y);
f1 = @(c, x, y) sum(g(c, x) - y);
f2 = @(c, x, y) sum((g(c, x) - y) .* x.^c(3));
f3 = @(c, x, y) sum((g(c, x) - y) .* x.^c(3) .* log(x));

% A solucao para c eh obtida pelo metodo de newton para sistemas de 3 equacoes
% nao linerares

% Valor chutado para a solucao:
ci = [1; 1; 1];
c = newtonsis3(ci, x, y, f1, f2, f3)

h = 0.01;
xp = min(x) : h : max(x);
yp = g(c, xp);

somatorio_desvios_mod = sum(abs(g(c, x) - y))

% Agora podemos testar a aproximacao g(x) polinomia (Pn(x)) de grau 2, 3 ...

% Vamos determinar uma funcao aproximadora que represente os m = 5 pontos
% experimentais:

% Agora, iremos ajustar um polinomio de grau n = 1

n = 2
a1 = coeficientes_ajuste_polinomial(x, y, n);
%Grafico para xp

yp1 = valor_polinomio_base_canonica(xp, a1);

n = 3
a2 = coeficientes_ajuste_polinomial(x, y, n);
%Grafico para xp
yp2 = valor_polinomio_base_canonica(xp, a2);


plot(x, y, "r*", xp,yp1, "b-",xp,yp2, "k-", xp, yp, "-m")
grid on


