function [x, M] = roots_polinomios(a)
    n = length(a) - 1;
    k = 0;

    while n > 0 
        k++;
        r = 1 + max(abs(a(2:n+1))) / abs(a(1));
        xi(k) = complex(0.1 * r, 0.1 * r);
        [x(k), M(k)] = newton_pn(n, a, xi(k));
        [n, a] = reduzirGrauMvezes(x(k), M(k), n, a);
    end
end
