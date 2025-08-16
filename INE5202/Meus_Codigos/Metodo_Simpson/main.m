f = @(x) 1./(1 + x.^2)
a = 0
b = 1
Ie = atan(1) - atan(0)

n = 4

Sn = f_simpson(f, a, b, n)

erro = abs(Ie - Sn)



