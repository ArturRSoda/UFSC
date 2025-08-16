a = 0;
b = pi/2;

x = [0 pi/6 pi/3 pi/2]
y = [0 1/4 3/4 1]

grau = length(x) - 1

for (i = 1:grau)
	delta_y(i, 1) = (y(i+1) - y(i))/(x(i+1) - x(i));
end
for (k = 2:grau)
	for (i = 1:grau+1-k)
		delta_y(i, k) = (delta_y(i+1, k-1) - delta_y(i, k-1))/(x(i+k) - x(i));
	end
end

coef = [y(1), delta_y(1, (1:grau))]

xp = a:0.01:b;
ye = (sin(xp)).^2;

for (k = 1:length(xp))
	pow = 1;
	ya(k) = coef(1);
	for (i = 1:grau)
		pow *= (xp(k) - x(i));
		ya(k) += pow*coef(i+1);
	end
end

erro_max = abs(max(ye - ya))

plot(xp, ye);
hold on;
p = plot(xp, ya);
waitfor(p);



