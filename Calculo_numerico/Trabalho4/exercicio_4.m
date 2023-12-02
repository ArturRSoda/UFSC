function x = exercicio_4()
	f_y_exato = @(x) cos(x);
	fy1 = @(x, y1, y2, y3) y2
	fy2 = @(x, y1, y2, y3) y3
	fy3 = @(x, y1, y2, y3) x.*cos(x) .- (x.+1).*y1 .- y2 .- y3

	x (1) = 0;
	y1(1) = 1;
	Chute_inicial = 0;
	y2(1) = Chute_inicial;
	y3(1) = -1;
	D = 0;

	a = 0
	b = pi/2

	n = 2^3

	C = fnewton_calcula_C(Chute_inicial, D, n, a, b, x, y1, y2, y3, fy1, fy2, fy3)
	y2(1) = C;

	[x, y1, y2, y3] = f_runge_kutta4_sis3(n, a, b, x, y1, y2, y3, fy1, fy2, fy3);

	ye = f_y_exato(x);
	[x_estimado, y1_estimado, y2_estimado, y3_estimado] = f_runge_kutta4_sis3(2*n, a, b, x, y1, y2, y3, fy1, fy2, fy3);
	erro_max_exato = max(abs(y1-ye))
	erro_max_estimado = max(abs(y1-y1_estimado(1:2:2*n+1)))

	xe = 0:0.001:pi/2;
	p = plot(xe, cos(xe), "-r", x, y1, "-b");
	legenda = legend("cos(x)", "y(x)");
	legend(legenda, "location", "northeast");
	grid on;

	disp("");
	disp("Erro comparando cos(pi/2) e y1(pi/2))");
	erro = abs(cos(pi/2) - y1(9))
	disp("-> Analizando o erro para x=pi/2, vemos que foi possivel chegar em uma solucao para y(pi/2) bem proxima de cos(pi/2)!");
end
