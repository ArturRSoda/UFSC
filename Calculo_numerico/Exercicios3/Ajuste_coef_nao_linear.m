x = [0 1 2 3 4 5]
y = [1 0.71 0.45 0.32 0.24 0.20]

g = @(coef, x) coef(1)./sqrt(coef(2) .+ coef(3).*x.^2)

f1 = @(coef, x, y) sum((g(coef, x) .- y) ./ sqrt(coef(2) .+ coef(3).*x.^2));
f2 = @(coef, x, y) sum((g(coef, x) .- y) ./ (coef(2) .+ coef(3).*x.^2).^(3/2));
f3 = @(coef, x, y) sum((g(coef, x) .- y) .* ((x.^2)/(coef(2) .+ coef(3).*x.^2).^(3/2)));

coef_i = [1, 1, 1];
warning off;
coef = newtonsis3(coef_i, x, y, f1, f2, f3)

xp = min(x):0.01:max(x);
yp = g(coef, xp);

desv = abs(sum((g(coef, x) - y).^2))



