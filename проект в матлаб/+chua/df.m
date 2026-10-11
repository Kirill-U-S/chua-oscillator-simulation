function y = df(x, p)
%DF Derivative f'(x) = 3 a1 x^2 + a2.
require_scalar(x);
require_params(p);
y = 3 * p.a1 * x^2 + p.a2;
end
