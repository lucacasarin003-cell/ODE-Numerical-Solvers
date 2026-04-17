function [t,y,flag]=crank_nicolson(t0,y0,t_end,h,fcn,tol)
flag=0;

max_count=100;

n = fix((t_end-t0)/h) + 1;
t = linspace(t0,t0+(n-1)*h,n)';
y = zeros(n,1); y(1) = y0;

for i=2:n 
  fold=feval(fcn,t(i-1),y(i-1));
  yt1 = y(i-1) + h*fold; % approssimazione EE
  count = 0;  diff = 1;
  while diff(end) > tol && count < max_count % punto fisso
    yt2 = y(i-1) + (h/2)*(fold+feval(fcn,t(i),yt1));
    
    % z(k+1)=y(i-1) + (h/2)*(feval(fcn,t(i-1),y(i-1))+feval(fcn,t(i),z(k)));
    
    diff(count+1) = abs(yt2-yt1); 
    yt1 = yt2;
    count = count +1;
  end
  
  if count >= max_count
      flag=1;
  end
  y(i) = yt2;
end