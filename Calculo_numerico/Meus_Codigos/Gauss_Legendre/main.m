f = @(x) 1./(1 + x.^2)
a = 0
b = 1
m = 3

Ie = atan(b) - atan(a)

IGL = f_gauss_legendre(f, a, b, m)

erro = abs(Ie - IGL)

