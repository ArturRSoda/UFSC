function [A, B] = matriz(n)

	n1 = 5;
	n2 = 10;
	n3 = 20;

	A = zeros(n, n);
	B = zeros(n, 1);


	i = 1;
	A(i,i) = 3;
	A(i,(i+2)) = 2;
	B(i,1) = 2;

	for (i = 2:n1)
		A(i,(i-1)) = -2;
		A(i,i) = 4;
		A(i,(i+5)) = -3;
		B(i,1) = -3;
	end

	for (i = (n1+1):n2)
		A(i,(i-4)) = -8;
		A(i,i) = -4;
		A(i,(i+1)) = -3;
		B(i,1) = 3;
	end

	for (i = (n2+1):n3)
		A(i,(i-3)) = -3;	
		A(i,(i-1)) = -2;
		A(i,i) = 7;
		B(i,1) = 5;
	end


end
