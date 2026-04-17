function main_euler
    t0=0; y0=0; tfin=10; % Problem data
    fcn2=@(x,y) 0.*x + (cos(y)).^2; 
    hV=[0.2 0.1 0.05];
    ae10=[]; 
    
    % 1. Define colors for different step sizes (h)
    colors = {'b', 'r', 'g'}; % Blue, Red, Green
    c_idx = 1;

    % 2. Prepare figure containers
    figure(1); clf; hold on; grid on;
    title('Absolute Error Comparison (Explicit Euler)');
    ylabel('Absolute Error');

    figure(2); clf; hold on; grid on;
    title('Relative Error Comparison (Explicit Euler)');
    ylabel('Relative Error');

    for h=hV
        [t,u]=euler_explicit(t0,y0,tfin,h,fcn2);
        
        % Determine errors
        y=atan(t);
        ae=abs(y(:)-u(:)); % Ensure column vectors
        re=ae./abs(u(:)); 
        
        % 3. Plot Absolute Error on Figure 1
        figure(1)
        semilogy(t, ae, colors{c_idx}, 'LineWidth', 2, 'DisplayName', ['h = ', num2str(h)]);
        
        % 4. Plot Relative Error on Figure 2
        figure(2)
        semilogy(t, re, colors{c_idx}, 'LineWidth', 2, 'DisplayName', ['h = ', num2str(h)]);
        
        ae10(end+1)=ae(end); 
        c_idx = c_idx + 1; % Change color for next h
    end
    
    % 5. Show legends after the loop
    figure(1); legend('show', 'Location', 'best');
    figure(2); legend('show', 'Location', 'best');

    % Calculate error ratios
    ratios=ae10(1:end-1)./ae10(2:end);
      

   exportgraphics(figure(1), 'euler_absolute_error.png', 'Resolution', 300);
   exportgraphics(figure(2), 'euler_relative_error.png', 'Resolution', 300); 


    
    % Print results to terminal
    fprintf('\n --- Final Results --- \n');
    for k=1:length(ratios)
        fprintf('\n \t Error Ratio for h=%1.5e and h=%1.5e: %1.6e', hV(k), hV(k+1), ratios(k));
    end
    fprintf('\n --------------------- \n');
end