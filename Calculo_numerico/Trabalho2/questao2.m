function x = questao2()

	printf("f1 = sin(X(1)) * cos(X(2)) + X(3) - 1.5 \n")
	printf("f2 =  X(1)^2 + X(2)^2 + X(3)^2 - 3 \n")
	printf("f3 = @(X) X(1) + X(2) + X(3) - 3.1 \n")

	f1 = @(X) sin(X(1)) * cos(X(2)) + X(3) - 1.5;
	f2 = @(X) X(1)^2 + X(2)^2 + X(3)^2 - 3;
	f3 = @(X) X(1) + X(2) + X(3) - 3.1;

	printf("\nraizes 1 \n");
	xi = [complex(-1,1); complex(1,1); complex(1,1)];
	x = newtonsis(xi, f1, f2, f3);

	for (i = 1:3)
		printf("x(%d) = %f %+fi \n", i, real(x(i)), imag(x(i)))
	end

	residuo = max(abs([f1(x), f2(x), f3(x)]))


	printf("\nraizes 2 \n");
	xi = [complex(-1,1); complex(1,-1); complex(1,1)];
	x = newtonsis(xi, f1, f2, f3);

	for (i = 1:3)
		printf("x(%d) = %f %+fi \n", i, real(x(i)), imag(x(i)))
	end

	residuo_maximo = max(abs([f1(x), f2(x), f3(x)]))

end
