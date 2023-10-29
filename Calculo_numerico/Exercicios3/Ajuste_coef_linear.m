x = [0 1 2 3 4 5]
y = [1 0.71 0.45 0.32 0.24 0.2]

grau = 3;

for (i = 1:grau+1)
	for (j = 1:grau+1)
		m_x(i, j) = sum(x.^(i+j-1));
	end
	m_y(i, 1) = sum(y .* x.^(i-1));
end
coef = m_x \ m_y

xp = min(x):0.01:max(x);
for (k = 1:length(xp))
	pow = 1;
	ya(k) = coef(1);
	for (i = 1:grau)
		pow *= xp(k);
		ya(k) += pow * coef(i+1);
	end
end


g = @(c, x)  c(1) .+ c(2).*x .+ c(3).*x.^2 + c(4).*x.^3;
desv = sum((g(coef, x) - y).^2)
