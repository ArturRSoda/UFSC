
f = @(x) x .* log(x) .- 1

subdominio = [1e-4 10]

x = metodo_newton(f, subdominio)
residuo = abs(f(x))
