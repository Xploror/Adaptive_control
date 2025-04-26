clc;clear;

dt = 0.001;
gamma = 10;   % Add adapting feature for gamma itself 
t_sim = 10;

%%%%% Plant dynamics nominal
A = [0 1; 1 1];
B = [0; 1];
C = [1 0];
D = 0;
W = [1; 1]*1;

%%%%% Initial simulation values
x = [0; 0];
u = 0;
y = C*x + D*u;

K1 = place(A,B,[-1,-2]);
K2 = -inv(C*inv(A-B*K1)*B);
Am = A-B*K1;
Bm = B*K2;
P = sylvester(A',A,eye(2));
W_hat = [0; 0];
xm = x;

for t = 0:dt:t_sim
    
   sigma = [x(1)^2; x(1)*x(2)];
   %%%%% Reference signal
   if t<=t_sim/2
       r = 1;
   else
       r = -1;
   end
   %%%%%%%%%%%%%%%%%%%%%
   u = -K1*x + K2*r - W_hat'*sigma;
   W_hat = W_hat + dt*(gamma*sigma*(x-xm)'*P*B);
   xm = xm + dt*(Am*xm + Bm*r);
   
   %%%%%%% Updating actual model %%%%%%
   x = x + dt*(A*x + B*(u + W'*sigma));
   y = C*x + D*u;
   
   plot(t, xm(1), '.g', 'Markersize', 5);
   hold on;
   plot(t, x(1), '.r', 'Markersize', 5);
   hold on;
   
    
end