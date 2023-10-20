% Obtenção de raízes de equações não lineares pelo método de Newton e Raphson

% .* , .- | Operações com vetores

f = @(x) x.*log(x) .- 1

dominio = [1e-4 10] % 1e-4 <= dominio < 10

x = metodo_newton(f, dominio)
residuo = abs(f(x))
