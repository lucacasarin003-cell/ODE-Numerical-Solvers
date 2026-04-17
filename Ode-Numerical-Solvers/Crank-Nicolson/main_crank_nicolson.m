function main_crank_nicolson
    t0=0; y0=0; tfin=10; % Problem data
    fcn2=@(x,y) 0.*x + (cos(y)).^2; % CORRECTED: added .^
    tol=10^(-6); % Tolerance
    hV=[0.2 0.1 0.05]; % Step size
    ae10=[]; % List of absolute errors at t=10
    
    % 1. Define colors
    colors = {'b', 'r', 'g'}; 
    c_idx = 1;
    
    figure(1); clf; hold on; grid on;
    title('Absolute Error Comparison');
    xlabel('x'); ylabel('Error');
    
    figure(2); clf; hold on; grid on;
    title('Relative Error Comparison');
    xlabel('x'); ylabel('Error');
    
    for h=hV
        [t,u]=crank_nicolson(t0,y0,tfin,h,fcn2,tol);
        
        % Determine errors
        y=atan(t);
        ae=abs(y-u);
        re=ae./abs(u); 
        % 3. Plot Absolute Error (Figure 1)
        figure(1)
        % Use colors{c_idx} to change color and DisplayName for the legend
        semilogy(t, ae, colors{c_idx}, 'LineWidth', 2, 'DisplayName', ['h = ', num2str(h)]);
        
        % 4. Plot Relative Error (Figure 2)
        figure(2)
        semilogy(t, re, colors{c_idx}, 'LineWidth', 2, 'DisplayName', ['h = ', num2str(h)]);
        
        % Increment color index for the next h
        c_idx = c_idx + 1;
        ae10(end+1)=ae(end); 
    end
    
    % 5. Show legend (only once at the end)
    figure(1); legend('show', 'Location', 'best');
    figure(2); legend('show', 'Location', 'best');
    
    % Calculate ratios 
    ratios=ae10(1:end-1)./ae10(2:end);
    exportgraphics(figure(1), 'crank_nicolson_absolute_error.png', 'Resolution', 300);
    exportgraphics(figure(2), 'crank_nicolson_relative_error.png', 'Resolution', 300);

    % Print results
    fprintf('\n \n');
    for k=1:length(ratios)
        fprintf('\n \t Ratio for h=%1.5e and h=%1.5e: %1.6e', hV(k), hV(k+1), ...
        ratios(k));
    end
    fprintf('\n \n');
end