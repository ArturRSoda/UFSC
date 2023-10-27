function x = newtonsis2(f1, f2)

    k = 0;
    delta_x = [1e-10; 1e-10];
    xi = [1; -1];
    while max(abs(delta_x)) > 1e-14 && k < 100
        k = k + 1;
        
        % Calculo manual das derivadas das funcoes:
        % A = [exp(xi(1)) 1; 2*xi(1) 2*xi(2)];
        
        % Calculo numerico das derivadas (pela definicao do limite):
        % A = [f1(xi + delta_x) / delta_x, f2(xi + delta_x) / delta_x]
        
        % Calculo numerico das derivadas parciais 
        % (pela definicao da matriz jacobiana)
        A(1,1) = (f1([xi(1)+delta_x(1); xi(2)           ])-f1(xi)) / delta_x(1);
        A(1,2) = (f1([xi(1)           ; xi(2)+delta_x(2)])-f1(xi)) / delta_x(2);
        A(2,1) = (f2([xi(1)+delta_x(1); xi(2)           ])-f2(xi)) / delta_x(1);
        A(2,2) = (f2([xi(1)           ; xi(2)+delta_x(2)])-f2(xi)) / delta_x(2);
        B = -[f1(xi); f2(xi)];
    
        delta_x = A \ B;
        x = xi + delta_x;
        xi = x;
    end
    repeticoes_newtonsis2 = k

endfunction