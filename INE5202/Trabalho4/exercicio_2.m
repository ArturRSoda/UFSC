function x = exercicio_2()

	f = @(x) x.*log(x)./(1.+cos(x))
	a = 0.1
	b = 1

	disp("-> integral exata: ");
	Ie = integral(f, a, b)

	disp("");

	disp("-> Metodo de Simpsom");
	n = 6
	y_simpson = f_simpson(f, a, b, n)
	erro_exato_simpson = abs(Ie - y_simpson)
	erro_estimado_simpson = abs(y_simpson - f_simpson(f, a, b, 2*n))

	disp("");

	disp("-> Metodo de Gauss-Legendre:");
	m = 3
	y_GL = f_gauss_legendre(f, a, b, m)
	erro_exato_GL = abs(Ie - y_GL)
	erro_estimado_GL = abs(y_GL - f_simpson(f, a, b, m+1))

	disp("");

	disp("Analizando os erros encontrados vemos que o metodo de Simpsom apresentou uma melhor aproximacao, com um erro estimado de 7.6184e-05 e erro exato de 8.3471e-05)");
end
