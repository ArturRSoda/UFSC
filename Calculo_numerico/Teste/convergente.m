function x = convergente(A);
	n = size(A, 1);

	maior_q = 0;
	dominante = 1;
	extritamente_dominante = 0;

	for (i = 1:n);
		somatoria = 0;
		for (j = 1:(i-1));
			somatoria += abs(A(i,j));
		end
		for (j = (i+1):n)
			somatoria += abs(A(i,j));
		end


		if (abs(A(i,i)) >= somatoria)
			if (A(i,i) > somatoria)
				maior_q = 1;
				printf("|%d| > |%d| V\n", A(i,i), somatoria)
			else
				printf("|%d| >= |%d| V\n", A(i,i), somatoria)
				extritamente_dominante = 0;
			end
		else
			printf("|%d| >= |%d| F\n", A(i,i), somatoria)
			extritamente_dominante = 0;
			dominante = 0;
		end
	end

	if (extritamente_dominante == 1)
		disp("convergente, pois diagonal extritamente_dominante")
		return;
	end

	if (dominante == 1)
		if (maior_q == 1)
			disp("convergente, pois diagonal dominante")
			return;
		end
	end

	if ((dominante == 0) && (extritamente_dominante == 0))
		disp("nao convergente, diagonal nao dominante")
	end

end

