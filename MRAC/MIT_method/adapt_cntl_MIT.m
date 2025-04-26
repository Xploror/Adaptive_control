clc;clear;

%%% Known parameters %%%
Am = 2;
Bm = 2;

% Actual plant parametes unknown
A = 1;
B = 0.5;

% Final values of K1 and K2 (to be compared for convergence)
K1_des = Bm/B;
K2_des = (Am-A)/B;

% Reference model transfer function
r_m = tf([Bm],[1 Am]);

tmax = 100;
time = 0:0.001:tmax;

% Generating reference input signal
r = 2*pulstran(time, 5:20:tmax, 'rectpuls', 10) - 1;

% Output of reference model given reference signal
yr = lsim(r_m, r, time);
figure(1)
plot(time, yr, 'r')
hold on;
plot(time, r, 'k')
ylim([-1.5, 1.5])

%% Now starting with Adaptive control
% Initial conditions (for state space form of K1 and K2 differential equation)
x0 = zeros(5,1);
gamma = 2;

% Solving for K1 and K2 given the states and reference 
[t1, gain_vals] = ode45(@(t,x) dyn_adapt(t, x, r, yr, time, Am, Bm, A, B, gamma), time, x0);
K1 = gain_vals(:,1);
K2 = gain_vals(:,3);
y = gain_vals(:,5);

figure(2)
plot(time, yr, 'k');
hold on;
plot(time, y, 'm');

%%%%% Cross-checking K1 and K2 values w.r.t time
figure(3)
plot(time, K1_des*ones(length(K1),1), 'r')
hold on;
plot(time, K1, 'b')
hold on;
plot(time, K2, 'g')
hold on;
plot(time, K2_des*ones(length(K2),1), 'r')