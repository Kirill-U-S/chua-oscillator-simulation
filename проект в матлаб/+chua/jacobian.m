function J = jacobian(t, x, p)
%JACOBIAN Jacobian of system (8). sigma does not enter J.
require_time(t);
require_state(x);
require_params(p);
dfx = chua.df(x(1), p);
J = [-p.alpha * dfx, p.alpha, 0; ...
      1,             -1,      1; ...
      0,             -p.beta, 0];
end
