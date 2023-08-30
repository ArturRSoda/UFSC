function x = questao22a(A);

	n = size(A, 1);

	maior_q = 0;
	convergente_dominante = 1;
	convergente_extritamente_dominante = 1;

	for (i = 1:n)
		soma = 0;

		for (j = 1:(i-1))
			soma += abs(A(i,j));
		end

		for (j = (i+1):n)
			soma += abs(A(i,j));
		end

		v = abs(A(i,i));
		if (v > soma)
			maior_q = 1;
			printf("|%d| > |%d| V \n", A(i,i), soma)

		elseif (v >= soma)
			printf("|%d| >= |%d| V \n", A(i,i), soma)
			convergente_extritamente_dominante = 0;

		else
			convergente_dominante = 0;
			convergente_extritamente_dominante = 0;
			printf("|%d| >= |%d| F \n", A(i,i), soma)
		end

	end

	maior_q
	convergente_dominante
	convergente_extritamente_dominante

	if (convergente_extritamente_dominante == 1);
		disp("Sistema convergente, pois possui diagonal extritamente dominante")	
		disp("ou seja, para todo A(i,i): A(i,i) > Zi (i = 1, ... , n)")
		return;
	end

	if (convergente_dominante == 1)
		if (maior_q == 1)
			disp("Sistema convergente, pois possui diagonal dominante")	
			disp("ou seja, para todo A(i,i): A(i,i) >= Zi (i = 1, ... , n)")
			disp("e ainda, pelo menos um A(i,i) > Zi (i = 1, ..., n)")
			return;
	end


	disp("Sistema nao convergente, nao possui diagonal dominante")

end
