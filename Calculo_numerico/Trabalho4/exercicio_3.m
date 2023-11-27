function x = exercicio_3()

	f_y1 = @(x,y1,y2,y3) y2
	f_y2 = @(x,y1,y2,y3) y3
	f_y3 = @(x,y1,y2,y3) x.*cos(x) .- (x.+1).*y1 .- y2 .- y3

	a = 0; b = pi/2;
	x(1) = 0;
	y1(1) = 1;
	y2(1) = 0;
	y3(1) = -1;

	n = 7
	[x, y1, y2, y3] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, n);
	[x_e, y1_e, y2_e, y3_e] = f_runge_kutta4_3EDOs(x, y1, y2, y3, f_y1, f_y2, f_y3, a, b, 2*n);

	erro_estimado_y1 = max(abs(y1 - y1_e(1 : 2 : 2*n+1)))
	erro_estimado_y2 = max(abs(y2 - y2_e(1 : 2 : 2*n+1)))
	erro_estimado_y3 = max(abs(y3 - y3_e(1 : 2 : 2*n+1)))

	p = plot(x, y1, "-r", x, y2, "-g", x, y3, "-b");
	legenda = legend("y1", "y2", "y3");
	legend(legenda, "location", "northwest")
	grid on

	disp("")
	disp("Erro comparando Ye com Cos(x):");
	erro = max(abs(y1 - cos(x)))

	disp("Analizando o erro vemos que foi possivel chegar em uma solucao bem proxima de cos(x)!");

end
