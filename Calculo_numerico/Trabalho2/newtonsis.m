function x = newtonsis(xi, f1, f2, f3)
	delta_x = [1e-10; 1e-10; 1e-10];
	k = 0;

	while ((max(abs(delta_x)) > 1e-14) && (k < 100))

		%k++;

		J(1,1) = (f1([xi(1) + delta_x(1) ; xi(2) ; xi(3)]) - f1(xi))/delta_x(1);
		J(1,2) = (f1([xi(1) ; xi(2) + delta_x(2) ; xi(3)]) - f1(xi))/delta_x(2);
		J(1,3) = (f1([xi(1) ; xi(2) ; xi(3) + delta_x(3)]) - f1(xi))/delta_x(3);

		J(2,1) = (f2([xi(1) + delta_x(1) ; xi(2) ; xi(3)]) - f2(xi))/delta_x(1);
		J(2,2) = (f2([xi(1) ; xi(2) + delta_x(2) ; xi(3)]) - f2(xi))/delta_x(2);
		J(2,3) = (f2([xi(1) ; xi(2) ; xi(3) + delta_x(3)]) - f2(xi))/delta_x(3);

		J(3,1) = (f3([xi(1) + delta_x(1) ; xi(2) ; xi(3)]) - f3(xi))/delta_x(1);
		J(3,2) = (f3([xi(1) ; xi(2) + delta_x(2) ; xi(3)]) - f3(xi))/delta_x(2);
		J(3,3) = (f3([xi(1) ; xi(2) ; xi(3) + delta_x(3)]) - f3(xi))/delta_x(3);

		B = -[f1(xi) ; f2(xi) ; f3(xi)];

		delta_x = J \ B;
		x = xi + delta_x;
		xi = x;



	end

end
