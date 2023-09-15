

%exemplo 1
%f = @(x) x .* log(x) .- 1
%subdominio = [1e-4 10]

%exemplo 2
f = @(x) x .* tan(x) .- 1
subdominio = [-7 7]

x = metodo_newton(f, subdominio)
residuo = abs(f(x))
