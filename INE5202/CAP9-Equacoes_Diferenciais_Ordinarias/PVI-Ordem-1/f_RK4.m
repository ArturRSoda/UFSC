function [x, y] = f_RK4(x_inicial, y_inicial, f, a, b, n)

h =  (b-a)/n;
x(1) = x_inicial;
y(1) = y_inicial;

% k = derivada em um ponto
% k3 é um k melhorado de k2, no mesmo ponto

for i = 1 : n
    x(i+1) = x(i) + h;
    k1 = f(x(i)      , y(i)           );
    k2 = f(x(i)+(h/2), y(i)+(h/2) * k1);
    k3 = f(x(i)+(h/2), y(i)+(h/2) * k2);
    k4 = f(x(i)+ h   , y(i)+ h    * k3);
    #(k1+ 2*(k2 + k3) + k4)/6 = k médio
    y(i+1) = y(i) + (k1+ 2*(k2 + k3) + k4)/6 * h;
end

end
