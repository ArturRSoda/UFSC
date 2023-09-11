
function xi = localizacao(f, dominio)

    numero_de_pontos = 1000
    
    h = (dominio(2) - dominio(1))/numero_de_pontos
    x = dominio(1):h:dominio(2)
    y = f(x)
    
    plot(x, y)
    grid on
    
    % verifica onde em x ocorrem trocas de sinal em y (curva corta o exixo x)

end
