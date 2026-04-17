function main_adams
    t0=0; y0=0; t_end=10;
    fcn=@(x,y) 0*x+(cos(y)).^2;
    fsol=@(x) atan(x);
    NV=[8 16 32 64 128 256];
    
    abserr = [];
    
    % Prepare a single figure with two subplots
    figure(1); clf;
    colors = lines(length(NV)); % Generate different colors for each N
    
    for i = 1:length(NV)
        N = NV(i);
        h = (t_end-t0)/(N-1);
        
        % Solution calculation (using 3-step as example)
        [t,u] = adams_bashforth_3passi(t0,y0,t_end,h,fcn,fsol);
        
        y = fsol(t);
        errV = abs(u(:) - y(:));
        abserr(end+1) = max(errV);
        
        subplot(1,2,1); hold on; grid on;
        semilogy(t, errV, 'Color', colors(i,:), 'LineWidth', 1.5, 'DisplayName', ['N=', num2str(N)]);
        title('Absolute Error Trend');
        xlabel('x'); ylabel('Error (log scale)');
        
        fprintf('\n Infinity norm for N = %d : %1.2e', N, max(errV));
    end
    
    subplot(1,2,1); legend('show', 'Location', 'best');

    subplot(1,2,2);
    semilogy(NV, abserr, 'r-o', 'LineWidth', 2, 'MarkerFaceColor', 'g', 'MarkerSize', 8);
    grid on;
    title('Convergence: Max Error vs N');
    xlabel('Number of points N'); ylabel('Max Error (log scale)');

  exportgraphics(figure(1), 'adams_error_and_convergence.png', 'Resolution', 300);

end