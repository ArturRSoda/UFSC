function x = questao1()

	disp("Questao1.a)")
	n = -20.125
	printf("float = %.20f\n", single(n))
	erro_float = abs(((double(single(n)) - (-20.125))/(-20.125))) * 100;
	printf("Erro_float = %f %s\n", erro_float, "%")
	printf("v = (-1)^(1) * 2^(4) * (1.01000010000000000000000)\n")
	printf("s = 1\n")
	printf("e = 131(decimal) = 10000011(binario)\n")
	printf("f = 01000010000000000000000\n")
	printf("|1|10000011|01000010000000000000000|\n")

	disp("")

	printf("double = %.20f\n", n)
	erro_double = abs(((n - (-20.125))/(-20.125))) * 100;
	printf("Erro_double = %f %s\n", erro_double, "%")
	printf("v = (-1)^(1) * 2^(5) * (1.0100001000000000000000000000000000000000000000000000)\n")
	printf("s = 1\n")
	printf("e = 1027(decimal) = 10000000011(binario)\n")
	printf("f = 0100001000000000000000000000000000000000000000000000\n")
	printf("|1|10000000011|0100001000000000000000000000000000000000000000000000|\n")
	
	disp("")

	disp("Questao1.b)")
	n = -60.06
	printf("float = %.20f\n", single(n))
	erro_float = abs(((double(single(n)) - (-60.06))/(-60.06))) * 100;
	printf("Erro_float = %f %s\n", erro_float, "%")
	printf("v = (-1)^(1) * 2^(4) * (1.11100000011110101110001)\n")
	printf("s = 1\n")
	printf("e = 132(decimal) = 10000100(binario) \n")
	printf("f = 11100000011110101110001\n")
	printf("|1|10000100|11100000011110101110001|\n")

	disp("")

	printf("double = %.20f\n", n)
	erro_double = abs(((n - (-60.06))/(-60.06))) * 100;
	printf("Erro_double = %f %s\n", erro_double, "%")
	printf("v = (-1)^(1) * 2^(5) * (1.1110000001111010111000010100011110101110000101001000)\n")
	printf("s = 1\n")
	printf("e = 1028(decimal) = 10000000100(binario)\n")
	printf("f = 1110000001111010111000010100011110101110000101001000\n")
	printf("|1|10000000100|1110000001111010111000010100011110101110000101001000|\n")
	
end
