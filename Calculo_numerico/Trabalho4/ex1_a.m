function x = ex1_a()
	disp("Gm = sum(C(m,k) * G(t(m,k))) ; m = 3");
	disp("2*m -> 2*3=6 Equacoes");
	disp("");
	disp(" -> 2   = C(3,1) + C(3,2) + C(3,3)");
	disp(" -> 0   = C(3,1)*t(3,1) + C(3,2)*t(3,2) + C(3,3)*t(3,3)");
	disp(" -> 2/3 = C(3,1)*(t(3,1)^2) + C(3,2)*(t(3,2)^2) + C(3,3)*(t(3,3)^2)");
	disp(" -> 0   = C(3,1)*(t(3,1)^3) + C(3,2)*(t(3,2)^3) + C(3,3)*(t(3,3)^3)");
	disp(" -> 2/5 = C(3,1)*(t(3,1)^4) + C(3,2)*(t(3,2)^4) + C(3,3)*(t(3,3)^4)");
	disp(" -> 0   = C(3,1)*(t(3,1)^5) + C(3,2)*(t(3,2)^5) + C(3,3)*(t(3,3)^5)");
end