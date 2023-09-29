function [n, a] = reduzirGrauMvezes(x, M, n, a)
    for k = 1:M 
        b(1) = a(1);

        for i = 2:n+1
            b(i) = a(i) + x * b(i-1);
        end

        n = n-1;
        a = b(1:n+1);
    end
end
