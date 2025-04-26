function dKdt = dyn_adapt(t, x, r, yr, time, Am, Bm, A, B, gamma)

% Interpolation of reference signal and reference model output at time t
u_interp = interp1(time, r, t);
y_interp = interp1(time, yr, t);

dKdt(1,1) = x(2);
dKdt(2,1) = -Am*x(2) - gamma*Am*x(5)*u_interp + gamma*Am*y_interp*u_interp;
dKdt(3,1) = x(4);
dKdt(4,1) = -Am*x(4) + gamma*Am*x(5)^2 - gamma*Am*x(5)*y_interp;
dKdt(5,1) = -(A + B*x(3))*x(5) + B*x(1)*u_interp;    % A and B are only used in this line

end