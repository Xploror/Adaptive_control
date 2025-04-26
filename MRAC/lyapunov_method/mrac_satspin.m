clc;clear;

% True model parameters
a = 10;
A = [0 a; -a -a/2];
B = eye(2);
C = [1 a;-a 1];
D = zeros(2,2);

% Nominal model used by the MRAC controller 
A_nominal = [0 0.5*a; -0.5*a -0.5*a]; % The uncertianity free model of plant dynamics
% A mismatch matrix 
det_A = A - A_nominal; 

% Reference model
Ar = [-5 0; 0 -5];
Br = 5*eye(2);