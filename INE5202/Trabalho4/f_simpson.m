function y_simpson = f_simpson(f, a, b, n)
	h = (b-a)/n;
	x = a:h:b;
	y = f(x);

	y_simpson = (h/3) * (y(1) + 4*sum(y(2:2:n)) + 2*sum(y(3:2:n-1)) + y(n+1));
end
