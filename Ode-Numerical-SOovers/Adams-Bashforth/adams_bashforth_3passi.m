function [t,y]=adams_bashforth_3passi(t0,y0,t_end,h,fcn,fsol)
        t = t0:h:t_end;
        t_end_start = t(3);
        [t_start,y_start] = euler_explicit(t0,y0,t_end_start,h,fcn);
        y = y_start(:); 
        N_punti = length(t);
        for k=4:N_punti
            fnm3 = fcn(t(k-3), y(k-3));
            fnm2 = fcn(t(k-2), y(k-2));
            fnm1 = fcn(t(k-1), y(k-1));
            y(k) = y(k-1) + (h/12)*(23*fnm1 - 16*fnm2 + 5*fnm3);
        end
    end