
f = @(x) x .* log(x) .- 1

dominio = [1e-4 10]

x = metodo_newton(f, dominio)
residuo = abs(f(x))
