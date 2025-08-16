function x = questao3()
	disp("");

	x = [ 1 : 0.5 : 2]
	y = 1 ./ x.^2

	n = length(x)-1;
	printf("\nnumero de intervalos, numero de Splines: %d\n\n",n)

	a=[];
	b=[];
	[a b c d] = spline_cubica(n,x,y)

	np = 4*n;  
	xpp=[];
	ypp=[];

	for i=1:n
		xp=x(i):(x(i+1)-x(i))/np:x(i+1);
		for k=1:np+1
			yp(k) = a(i)*(xp(k)-x(i))*(xp(k)-x(i))*(xp(k)-x(i));
			yp(k) = yp(k) + b(i)*(xp(k)-x(i))*(xp(k)-x(i));
			yp(k) = yp(k) + c(i)*(xp(k)-x(i))+d(i);
		end
		xpp=[xpp xp];ypp=[ypp yp];
	end

end
