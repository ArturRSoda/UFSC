
a = 0
b = pi/2

coef = [
	1/2,
	1,
	0,
	-1/3,
	0,
	2/15
	]

xi = pi/4;

grau = 5

xp = a:0.01:b;
ye = (sin(xp)).^2;

for (k = 1:length(xp))
	pow = 1;
	ya(k) = coef(1);
	for (i = 1:grau)
		pow *= (xp(k) - xi);
		ya(k) += pow*coef(i+1);
	end
end

error_max = abs(max(ye - ya))

plot(xp, ye);
hold on;
p = plot(xp, ya);
waitfor(p);

		
