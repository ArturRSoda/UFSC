

function raiz = metodo_newton(f, dominio)
    
    % Localização das raízes iniciais:
    
    xi = localizacao(f, dominio)
    
    % Refinamento do valor da raíz inicial xi:
    % Podemos escrever f(x) por série de Taylor, a partir de xi:
    % Qualquer função pode ser escrita como:
    %       f(x) = f(xi) + f'(xi)(x-xi)¹/1! + f''(xi)(x-xi)²/2! + f'''(xi)(x-xi)³/3! + ... = 0
    %       Se xi e x estão próximos, podemos usar uma série aproximada com menos termos
    %       faprox(x) = f(xi) + f'(xi)(x-xi)/1!
    %       faprox(x) != f(x)     |  0 da faprox(x) não é o 0 de f(x)
    %
    %       Δ(x) = - f(xi)/f'(xi)
    %       x    =    xi + Δ(x)     =     xi - f(xi)/f'(xi)
    
    delta_x = 1;
    repeticoes = 0;
    while (abs(delta_x) > 1e-15 && repeticoes < 100) % Se qualquer condicao falhar, para.
        
        repeticoes = repeticoes + 1;
        
        derivada_f = (f(xi + delta_x) - f(xi))/delta_x; % Derivada numérica baseada na definição do limite, com delta_x tendendo a zero numerico
        
        delta_x = - f(xi)/derivada_f;
        
        raiz = xi + delta_x;
        
        xi = raiz;

    end

end




