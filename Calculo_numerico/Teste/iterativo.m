function [X, operacoes] = questao22b(A, B)
    n = size(A, 1);
	operacoes = 0;
    for (i = 1:n)
        nao_nulos_total(i) = 0; 
        for (j = 1:(i-1))
            if (abs(A(i, j)) > 1e-14)
               nao_nulos_total(i) += 1; 
               NN(i, nao_nulos_total(i))=j;
            end
        end
        
        for (j = (i+1):n)
            if (abs(A(i, j)) > 1e-14)
               nao_nulos_total(i) += 1; 
               NN(i, nao_nulos_total(i))=j;
            end
        end
        
    end
    X = zeros(n, 1);
    diferenca = 1;
    k = 0;
    lambda = 0.1
    while ((diferenca > 1e-6))
        k = k + 1;
        X_anterior = X;
        for (i=1:n)
			c=1:nao_nulos_total(i);
            X(i) = (1-lambda)*X_anterior(i)+lambda*(B(i,1) - sum(A(i, NN(i,c))*X(NN(i,c),1)))/A(i,i);
        end
        diferenca = max(abs(X - X_anterior));
    end

	for (i = 1:n)
		operacoes = operacoes + 5 + (nao_nulos_total(i) - 1) + nao_nulos_total(i);
	end
	operacoes = (operacoes * k);
endfunction

