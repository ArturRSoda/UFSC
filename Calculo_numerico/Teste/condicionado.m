function x = condicionado(A)
	n = size(A, 1);

	somat = 0;
	for (i = 1:n)
		somatoria = 0;
		for (j = 1:n)
			somatoria += A(i,j)**2;
		end
		somat += sqrt(somatoria);
	end

	if ((abs(det(A))/somat) < 0.01)
		disp("sistema mal condicionado")
		disp("sensivel a pequenas mudancas")
	else
		disp("sistema condicionado")	
		printf("||det(A)|| = %.2f\n", somat)
	end

end
