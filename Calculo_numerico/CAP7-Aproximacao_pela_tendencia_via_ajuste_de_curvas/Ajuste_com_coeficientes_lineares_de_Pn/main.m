% Vamos determinar uma funcao aproximadora que represente os m = 5 pontos
% experimentais:

x = [1 3 4 6 8];
y = [0 1 2 4 5];

% Agora, iremos ajustar um polinomio de grau n = 1

n = 1
a1 = coeficientes_ajuste_polinomial(x, y, n)
%Grafico para xp
xp=min(x):0.01:max(x);
yp1 = valor_polinomio_base_canonica(xp, a1);

n = 2
a2 = coeficientes_ajuste_polinomial(x, y, n);
%Grafico para xp
yp2 = valor_polinomio_base_canonica(xp, a2);


plot(xp, yp2)
hold on
p = plot(xp, yp1)
waitfor(p)

