function x = questao1() 

	disp("Questao 1.a) ")
	disp("sin(x)^3 * cos(x)^3+0.1=0, subdominio=[-6, +6]")
	f = @(x) sin(x).^3 .* cos(x).^3 .+ 0.1;
	subdominio = [-6, +6];

	chutes = [-1, 5.3, -0.6, 5.68, -4.1];
	raizes = zeros(length(chutes));
	for (i = 1:length(chutes))
		printf("\nraiz %d \n", i)
		x = metodo_newton_Q1A(f, chutes(i), subdominio)
		raizes(i) = x;
		printf("residuo = %d \n", f(x))
	end

	printf("\nForma fatorada \n");
	printf("f(x) = ")
	for (i = length(raizes):-1:2)
		printf("(x %+d) * ", -raizes(i))
	end
	printf("(x %+d) \n", -raizes(1))


	printf("\n\n\n")
	disp("Questao 1.b)");
	disp("f(x) = x^4 - 2x^3 - 1.5x^2 + 0.5x + 0.0625");
	coeficientes = [1, -2, -1.5, 0.5, 0.0625];
	[raizes, M] = roots_polinomios(coeficientes);
	residuos = valorPolinomio(coeficientes, raizes);
	for (i = 1:length(raizes))
		disp("")
		printf("raiz %d \n", i)
		printf("x = %f \n", raizes(i))
		printf("residuo = %d \n", residuos(i))
	end

	printf("\nForma fatorada \n");
	printf("f(x) = ")
	for (i = length(raizes):-1:2)
		printf("(x %+d) * ", -raizes(i))
	end
	printf("(x %+d) \n", -raizes(1))


	printf("\n\n\n")
	disp("Questao 1.c)");
	disp("f(x) = x^8 - 11.3 x^7 + 50.83 x^6 - 114.581 x^5 + 132.9985 x^4 - 72.57875 x^3 + 14.865625 x^2 - 1.2734375 x + 0.0390625");
	coeficientes = [1 ,-11.3, 50.83, -114.581, 132.9985, -72.57875, 14.865625, -1.2734375, 0.0390625];
	[raizes, M] = roots_polinomios(coeficientes);
	residuos = valorPolinomio(coeficientes, raizes);
	for (i = 1:length(raizes))
		disp("")
		printf("raiz %d \n", i)
		printf("x = %f %+f*i \n", real(raizes(i)), imag(raizes(i)))
		printf("residuo = %d \n", residuos(i))
	end

	printf("\nForma fatorada \n");
	printf("f(x) = ")
	for (i = length(raizes):-1:2)
		printf("(x - (%d %+f*i)) * ", real(raizes(i)), imag(raizes(i)))
	end
	printf("(x - (%d %+f*i)) * ", real(raizes(1)), imag(raizes(1)))


end

