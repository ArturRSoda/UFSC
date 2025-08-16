function X = condicionado(A)

	n = size(A, 1);

	soma_T = 0;
	for (i = 1:n)
		soma_L = 0;

		for (j = 1:n)
			soma_L += A(i,j)**2;
		end

		soma_T += sqrt(soma_L);
	end

	cond = abs(det(A))/soma_T;
	soma_T
	det(A)
	cond

	if (cond < 0.01)
		disp("Como ||det(A)|| << 1, o Sistema e mal condicionado,")
		disp("Ou seja, e sensivel a pequenas mudancas")
	else
		disp("como ||det(A)|| >= 0.01, o Sistema e condicionado")
	end
end
