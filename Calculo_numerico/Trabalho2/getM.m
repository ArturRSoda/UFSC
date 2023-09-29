function M = getM(R)

    M = 1;
    somaRestos = sum(abs(R(1:2))); # soma dois primeiros restos
    while somaRestos < 1e-15
        M = M + 1;
        somaRestos = somaRestos + abs(R(M+1));
    end
end
