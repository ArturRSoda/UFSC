function x = questao1(n)
	double_x = n;
	erro_double = abs(((double_x-n)/n)) * 100;
	float_x = single(double_x);
	erro_float = abs(((double(float_x)-n)/n)) * 100;
	printf("Double......: %.20f\n", double_x)
	printf("Erro_double.: %.2f %s \n", erro_double, "%")
	printf("Float.......: %.20f\n", float_x)
	printf("Erro_float..: %f %s\n", erro_float, "%")
	
end
