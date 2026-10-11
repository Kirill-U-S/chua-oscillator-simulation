function y = f(x, p)
%F Cubic characteristic f(x) = a1 x^3 + a2 x.
require_scalar(x);
require_params(p);
y = p.a1 * x^3 + p.a2 * x;
end
