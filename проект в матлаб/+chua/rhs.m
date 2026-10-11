function dx = rhs(t, x, p)
%RHS Right-hand side of smooth Chua system (8).
require_time(t);
require_state(x);
require_params(p);
dx = [p.alpha * (x(2) - chua.f(x(1), p) - p.sigma); ...
      x(1) - x(2) + x(3); ...
      -p.beta * x(2)];
end
