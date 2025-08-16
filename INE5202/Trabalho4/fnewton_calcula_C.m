function C = fnewton_calcula_C(Ci, D, n, a, b, x, y1, y2, y3, fy1, fy2, fy3)

    delta_C = 1e-5; i = 0;
    while(abs(delta_C) > 1e-6)
        i = i + 1;
        y2(1) = Ci;
        [x, y1, y2, y3] = f_runge_kutta4_sis3(n, a, b, x, y1, y2, y3, fy1, fy2, fy3);
        erro_c_ci = y3(n + 1) - D;
        y2(1) = Ci + delta_C;
        [x, y1, y2, y3] = f_runge_kutta4_sis3(n, a, b, x, y1, y2, y3, fy1, fy2, fy3);
        erro_cc2  = y3(n + 1) - D;
        derivada_errcc = (erro_cc2 - erro_c_ci)/delta_C;
        delta_C = -erro_c_ci/derivada_errcc;
        C = Ci + delta_C;
        Ci = C;
    end
end
