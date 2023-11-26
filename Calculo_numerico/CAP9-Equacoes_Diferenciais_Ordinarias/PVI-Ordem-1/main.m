format long

% y' = x - y + 2
f = @(x,y) x - y + 2
% y_exato (y) é a solução exata da equação diferencial (y') ( calculada na mão ) -> para poder verificar eficácia do método
y_exato = @(x) (x + 1) + exp(-x);
x_inicial = 0;
y_inicial = 2;

a = 0; b = 1;

printf("\nRunge-Kutta de 4ª ordem\n\n") 

n = 8
[x4, y4] = f_RK4(x_inicial, y_inicial, f, a, b, n);

% calculando erros:
y4_exato = y_exato(x4);

% dobramos o valor de n
[x4_exato_estimado, y4_exato_estimado] = f_RK4(x_inicial, y_inicial, f, a, b, 2*n);

% Erro máximo exato
[erro_max_exato4, pos_erro_exato4] = max(abs(y4-y4_exato)) 

% Erro máximo estimado
[erro_max_estimado4, pos_erro_estimado4] = max(abs(y4-y4_exato_estimado(1 : 2 : 2*n + 1)))

% para calcular o erro max estimado, criamos um valor "exato" melhorando a aproximação (y4_exato_estimado). 
% Logo, temos um erro relativo ao y4 com menos iterações (y4) - y4 com mais iterações (y4_exato_estimado)
% Como o y4 melhorado tem o dobro de iterações, para realizar a subtração, precisamos fazê-la de 2 em 2 y4 melhorado. 
% --> y4_exato_estimado(1 : 2 : 2*n + 1)

x = 0:1/8:1;
p = plot(x4, y4, "-r", x, y_exato(x), "-b");
legenda = legend("runge kutta4", "exato");
legend(legenda, "location", "northwest")
grid on
waitfor(p)
