function [x, M] = newton_pn(n, a, xi)

   
    delta_x = 1;
    iteracao = 0;

    while abs(delta_x) > 1e-15 && iteracao < 100
        iteracao = iteracao + 1;
        
        R = restos(n, a, xi);

        M = getM(R);
        delta_x = - R(M) / (M * R(M+1)); 
        
        x = xi + delta_x;
        xi = x;
    end
end
