function [a b c d] = spline_cubica(n,x,y)
	for i=1:n	
		h(i)=x(i+1)-x(i);
	end
	t(2)=0; r(2)=3*h(1)+2*h(2);
	d(2)=h(2);
	b(2)=6*((y(3)-y(2))/h(2)-(y(2)-y(1))/h(1)); %para S1

	for i=3:n-1
		t(i)=h(i-1); r(i)=2*(h(i-1)+h(i)); d(i)=h(i); b(i)=6*((y(i+1)-y(i))/h(i)-(y(i)-y(i-1))/h(i-1)); 
	end

	t(n)=h(n-1);
	r(n)=(2*h(n-1)+3*h(n));
	d(n)=0;
	b(n)=6*((y(n+1)-y(n))/h(n)-(y(n)-y(n-1))/h(n-1)); 

	for i=3:n
		aux=t(i)/r(i-1);t(i)=0;
		r(i)=r(i)-aux*d(i-1);
		b(i)=b(i)-aux*b(i-1);
	end

	S(n)=b(n)/r(n);

	for i=n-1:-1:2
	  S(i)=(b(i)-d(i)*S(i+1))/r(i);
	end

	S(1) = S(2);
	S(n+1)=S(n);

	a=[];
	b=[];
	c=[];
	d=[];

	for i=1:n
		a(i)=(S(i+1)-S(i))/(6*h(i));
		b(i)= S(i)/2;
		c(i)=(y(i+1)-y(i))/h(i)-(S(i+1)+2*S(i))*h(i)/6;
		d(i)= y(i);
	end
end
