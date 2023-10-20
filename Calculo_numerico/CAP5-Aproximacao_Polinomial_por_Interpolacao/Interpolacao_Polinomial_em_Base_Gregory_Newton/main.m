%aproxime a função f(x) = cos²(x) no intervalo [0, pi/2] com erro max < 5e-2 (0,05)
a = 0 ; b = pi/2; % intervalo

' Primeiro caminho pela série de Taylor:'

% f(x) = f(xi) + (f'(xi)/1!) (x-xi) +  (f''(xi)/2!) (x-xi)² + (f'''(xi)/3!) (x-xi)³ + ... + (f^(n) (xi)/n!) (x-xi)^n + ...
% f(x) = c(1)  + c(2)        (x-xi) +  c(3)         (x-xi)² + c(4)          (x-xi)³ + ... + c(n+1)          (x-xi)^n 

% em nosso exemplo, n = 3
% xi  = (0+pi/2)/2 = pi/4 (ponto médio do subintervalo [0, pi/2])
%n=3
xi = pi/4
yi=cos(xi)^2
% calculamos manualmente todos os coeficientes c(i):
% coeficiente: f(xi) ,  f'(xi)/1! , f''(xi)/2! , f'''(xi)/3! , f''''(xi)/4! ...
 c = [+1/2, -1        , 0, +2/3           ] 
%c = [+1/2, -2^1*(1/2), 0, +2^3/3!*(1/2), 0, -2^5/5!*(1/2), 0, +(2^7)/7!*(1/2) ] %, 0,..., +-(2^n)/n!*(1/2)]
%n=7 % Erro_Max_Taylor<0,0000785)
%c = [+1/2, -2^1*(1/2), 0, +2^3/factorial(3)*(1/2), 0, -2^5/factorial(5)*(1/2), 0, +(2^7)/factorial(7)*(1/2) ] %, 0,..., +-(2^n)/n!*(1/2)]

% para fazer os gráficos, vamos criar vários valores de x e y para plotar
h = (b-a)/100;
xp = [a : h : b];

ya = valor_polinomio_Taylor(xp, c , xi); % nossa função aproximada por Taylor
ye = (cos(xp)).^2; % função nativa, exata (Octave)
Erro_Taylor = abs(ya-ye); 
Erro_Max_Taylor = max(Erro_Taylor) %(n=3 -> Erro_Max_Taylor≃0.037<0,05; )
% erro maximo ->  nas extremidades do intervalo da aproximação

' Segundo caminho pela interpolação polinomial de Gregory Newton:'

% Primeiro calculamos os coeficientes
% Definindo os pontos
n = 3 % Grau escolhido (chute inicial, depois avaliamos o erro: n=2 -> Erro_GN≃1e-2; n=5 -> Erro_GN≃5.4e-3 -> Melhor n=3; )
h = (b-a)/n; % Intervalo dos n+1 pontos exatos para "ancorar" o polinômio
x_exato = [ a:h:b ]
y_exato = (cos(x_exato)).^2
% Pn(x) = y(1)*1 + Δ¹y(1)(xp - x(1)) + Δ²y(1)(xp - x(1))(xp - x(2)) + ... + Δ^n y(1) * Π[j=1:n](x - x(j))
% Pn(x) = c(1)*1 + c(2)  (xp - x(1)) + c(3)  (xp - x(1))(xp - x(2)) + ... + c(n+1)   * Π[j=1:n](x - x(j))
coeficientes = coeficientes_gregory_newton(x_exato, y_exato)
wa = valor_polinomio_gregory_newton(xp, coeficientes, x_exato, y_exato); % nossa função aproximada por Gregory Newton
Erro_GN = abs(wa-ye); 
Erro_Max_GN = max(Erro_GN) %(n=3 -> Erro_Max_GN≃0.0054<0,05;  )
% erro maximo ->  no meio dos subintervalos [x(i), x(i+1)], e maior nos subintervalos das extremidades

% plot(xp, ya, "r;-;", xp, ye, "b; -;", xp, wa, "g; -;")
plot(xp, Erro_Taylor, "r;-;", xp, Erro_GN, "g; -;")
grid on

% diminuir erro -> aumenta número de termos -> n
