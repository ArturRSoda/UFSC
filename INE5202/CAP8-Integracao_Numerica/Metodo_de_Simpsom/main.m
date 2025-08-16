format long
%Vamos calcular numericamente a integral de 1/(1+x) entre 1 e 6, 
% com 6 digitos significativos exatos (erro estimado menor que 1e-6)

%Vamos definir a função integranda f(x)
f = @(x) 1./(1+x)
a = 1
b = 6
Integral_exata = log(1+b) - log(1+a)


printf("\n2: Método de Simpson\n")
% 1)Precisamos definir o número de sub-intervalos onde aplicaremos o 
% método de Simpsorro_estimado_Sn = abs(Sn - f_simpson(2*n, a, b, f))
