function x = questao1(n)
	double_x = n
	erro_double = abs(((double_x-n)/n)) * 100
	float_x = single(double_x)
	erro_float = abs(((double(float_x)-n)/n)) * 100
end
