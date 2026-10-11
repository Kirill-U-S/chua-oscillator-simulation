function eq = equilibria(p)
%EQUILIBRIA Real roots of f(x) + sigma = 0, with y = 0 and z = -x.
require_params(p);
rts = roots([p.a1, 0, p.a2, p.sigma]);
xs = sort(real(rts(abs(imag(rts)) <= 1e-8)));
n = numel(xs);
eq = repmat(struct('name', "", 'state', zeros(3, 1)), n, 1);
labels = ["O1", "O2", "O3"];
for k = 1:n
    if n == 3
        eq(k).name = labels(k);
    else
        eq(k).name = "";
    end
    eq(k).state = [xs(k); 0; -xs(k)];
end
end
