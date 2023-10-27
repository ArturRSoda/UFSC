


g1 = @(x) sin(x(1)) * cos(x(2)) + x(3) - 1.5
g2 = @(x) x(1)*x(1) + x(2)*x(2) + x(3)*x(3) - 3.0
g3 = @(x) x(1) + x(2) + x(3) - 3.1

wi = [complex(-1,1); complex(1,1); complex(1,1)]
w = newtonsis3(wi, g1, g2, g3)
res_max_w = max(abs([g1(w); g2(w); g3(w)]))

zi = [complex(-1,1); complex(0.5,1); complex(0.5,1)]
z = newtonsis3(zi, g1, g2, g3)
res_max_z = max(abs([g1(z); g2(z); g3(z)]))

% Para esse valor inicial:
% xi = = [complex(1,1); complex(1,1); complex(1,1)]

% Encontramos:
% w =                                                                             
%   1.0345 + 0.3662i                                                             
%   1.0238 - 0.1486i                                                             
%   1.0417 - 0.2175i

% Para o seguinte valor inicial:
% wi = [complex(-1,1); complex(1,1); complex(1,1)]

% Encontramos:
% z =                                                           
%   -0.55702 + 0.29938i                                                           
%    1.57571 - 1.56223i                                                           
%    2.08131 + 1.26285i
