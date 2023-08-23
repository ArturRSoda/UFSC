function x = questao1(n)
	x = n;
	erro_double = abs(((x-n)/n));
	erro_float = abs(((single(x)-n)/n));
	printf("Double......: %.20f\n", x)
	printf("Erro Double.: %.20f\n", erro_double)
	printf("Float.......: %.20f\n", single(x))
    printf("Erro Float..: %.20f\n", erro_float)
end
