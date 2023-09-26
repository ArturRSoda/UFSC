function [T, R, I, B] = cria_vetores()
	n1 = 5;
	n2 = 10;
	n3 = 20;

	T = zeros(n3);
	R = zeros(n3);
	I = zeros(n3);
	B = zeros(n3);

	i = 1;
	T(i) = NaN
	R(i) = 3;
	I(i) = 2;
	B(i) = 2;

	for (i = 2:n1)
		T(i) = -2;
		R(i) = 4;
		I(i) = -3;
		B(i) = -3;
	end

	for (i = n1+1:n2)
		T(i) = -4;
		R(i) = -4;
		I(i) = -3;
		B(i) = 3;
	end

	for (i = n2+1:n3)
		T(i) = -3;
		R(i) = 7;

		if (i == n3)
			I(i) = NaN;
		else
			I(i) = 2;
		end

		B(i) = 5;
	end
end;
