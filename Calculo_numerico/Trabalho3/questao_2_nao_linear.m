function x = questao_2_nao_linear()
	g1 = @(x) sin(x(1)) * cos(x(2)) + x(3) - 1.5
	g2 = @(x) x(1)*x(1) + x(2)*x(2) + x(3)*x(3) - 3.0
	g3 = @(x) x(1) + x(2) + x(3) - 3.1

	wi = [complex(-1,1); complex(1,1); complex(1,1)]

	w = newtonsis3(wi, g1, g2, g3)
	res_max_w = max(abs([g1(w); g2(w); g3(w)]))

	zi = [complex(-1,1); complex(0.5,1); complex(0.5,1)]
	z = newtonsis3(zi, g1, g2, g3)
	res_max_z = max(abs([g1(z); g2(z); g3(z)]))
end

