function x = ex1_b()
	n = 6

	for (i = 1:3)
		Cm(i,1) = 0.5;
		tm(i,1) = 0.1;
	end

disp("Solucao de 6 equacoes G não lineares por Newton com derivadas numericas:")
X = fNewtonSisNum(n,[Cm;tm]);

C = X(1:3)
t = X(4:6)

residuomaximo=max(G(X))

end
