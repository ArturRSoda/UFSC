function ya = valor_polinomio(xp, a, grau)
	
	for (k = 1:length(xp))
		pow = 1;
		ya(k) = a(1);
		for (i = 2:grau+1)
			pow *= xp(k);
			ya(k) += a(i)*pow;
	end

end
