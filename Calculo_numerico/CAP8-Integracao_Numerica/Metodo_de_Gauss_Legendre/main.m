format long
%Vamos calcular numericamente a integral de 1/(1+x) entre 1 e 6, 
% com 6 digitos significativos exatos (erro estimado menor que 1e-6)

%Vamos definir a função integranda f(x)
f = @(x) 1./(1+x)
a = 1
b = 6
Integral_exata = log(1+b) - log(1+a)


printf("\n3: Método de Gauss-Legendre\n")
% 1)Precisamos definir o número de pontos onde aplicaremos o método de 
% Gauss-Legendre
m = 6 # número de pontos

% Vamos definir o resultado da integral
Gm = f_gauss_legendre(m, a, b, f)
erro_exato_Gm = abs(Gm - Integral_exata) #valor aproximado obtido menos 
% o valor exato
erro_estimado_Gm = abs(Gm - f_gauss_legendre(m+1, a, b, f))

