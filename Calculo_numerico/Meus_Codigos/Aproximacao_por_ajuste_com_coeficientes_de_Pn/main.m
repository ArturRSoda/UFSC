
x = [1 3 4 6 8];
y = [0 1 2 4 5];


grau = 1
a = coeficientes_ajuste_polinomial(x, y, grau)
xp = min(x):0.01:max(x);
ya = valor_polinomio(x, a, grau)

